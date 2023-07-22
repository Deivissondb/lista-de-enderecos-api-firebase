import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_test_api/src/components/buttom_widget.dart';
import 'package:search_test_api/src/components/custom_text_field.dart';
import 'package:search_test_api/src/controllers/address_controller.dart';

class NewAddressPage extends StatefulWidget {
  const NewAddressPage({super.key});

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  TextEditingController cepController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  var searchAddress = Get.put(SearchAddressController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Novo Endereço',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: CustomTextField(
                          controller: cepController,
                          labelText: 'CEP',
                          hint: '00000-000',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: ButtomWidget(
                          name: 'Buscar CEP',
                          onClicked: () async {
                            String cep = cepController.text;
                            await searchAddress.getSearchAddress(cep);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Dados Encontrados',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(57, 61, 80, 1),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Endereço',
                  hint: 'Avenida Julho de Castilhos',
                  controller: searchAddress.addressController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Bairro',
                  hint: 'Progresso',
                  controller: searchAddress.neighborhoodController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Cidade',
                  hint: 'Porto Alegre',
                  controller: searchAddress.cityController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'UF',
                  hint: 'Rio Grande do Sul',
                  controller: searchAddress.ufController,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: ButtomWidget(
            name: 'Salvar novo endereço',
            onClicked: () {
              searchAddress.listAddress.add(searchAddress.preference.value);
              searchAddress.preference.value = null;
              searchAddress.preference.refresh();
              searchAddress.clearTextFields();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
