import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:search_test_api/src/models/search_address_model.dart';
import '../components/card_custom.dart';
import '../components/custom_text_field.dart';
import '../controllers/address_controller.dart';

class ListAddressPage extends StatefulWidget {
  const ListAddressPage({
    super.key,
  });

  @override
  State<ListAddressPage> createState() => _ListAddressPageState();
}

class _ListAddressPageState extends State<ListAddressPage> {
  final searchAddress = Get.put(SearchAddressController());

  @override
  void initState() {
    super.initState();
    searchAddress.searchController.value.addListener(() {
      searchAddress.searchController.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meus Endereços'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Obx(
            () => Column(
              children: [
                CustomTextField(
                  controller: searchAddress.searchController.value,
                  icon: Icons.search,
                  hint: 'Pesquise pelo Endereço',
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: searchAddress.searchController.value.text.isEmpty
                        ? searchAddress.firestore
                            .collection('address')
                            .snapshots()
                        : searchAddress.firestore
                            .collection('address')
                            .where('logradouro',
                                isEqualTo:
                                    searchAddress.searchController.value.text)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Erro ao carregar os endereços');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final documents = snapshot.data?.docs;

                      if (documents == null || documents.isEmpty) {
                        return const Text('Nenhum endereço encontrado');
                      }

                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final address = SearchAddressModel.fromJson(
                              documents[index].data());
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "/editAddressPage",
                                arguments: address,
                              );
                            },
                            child: CardCustom(
                              cep: address.cep,
                              address: address.logradouro,
                              neighborhood: address.bairro,
                              city: address.localidade,
                              uf: address.uf,
                              addressM: address,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/newAddressPage");
          },
          mini: true,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
