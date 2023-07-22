import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_test_api/src/components/buttom_widget.dart';
import 'package:search_test_api/src/components/custom_text_field.dart';
import 'package:search_test_api/src/controllers/address_controller.dart';
import 'package:search_test_api/src/models/search_address_model.dart';

class EditAddressPage extends StatefulWidget {
  final SearchAddressModel address;

  const EditAddressPage({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  TextEditingController cepController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  var searchAddress = Get.put(SearchAddressController());

  @override
  void initState() {
    super.initState();

    cepController.text = widget.address.cep;
    addressController.text = widget.address.logradouro;
    neighborhoodController.text = widget.address.bairro;
    cityController.text = widget.address.localidade;
    ufController.text = widget.address.uf;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Editar endereço'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  labelText: 'CEP',
                  hint: '00000-000',
                  enabled: false,
                  controller: cepController,
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
                  controller: addressController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Bairro',
                  hint: 'Progresso',
                  controller: neighborhoodController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Cidade',
                  hint: 'Porto Alegre',
                  controller: cityController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'UF',
                  hint: 'Rio Grande do Sul',
                  controller: ufController,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: ButtomWidget(
            name: 'Salvar alterações',
            onClicked: () {
              final String cep = cepController.text;
              final String address = addressController.text;
              final String neighborhood = neighborhoodController.text;
              final String city = cityController.text;
              final String uf = ufController.text;

              final updatedAddress = SearchAddressModel(
                  cep: cep,
                  logradouro: address,
                  bairro: neighborhood,
                  localidade: city,
                  uf: uf,
                  addressId: widget.address.addressId);

              searchAddress.updateAddress(updatedAddress);
              Navigator.pop(context, updatedAddress);
            },
          ),
        ),
      ),
    );
  }
}
