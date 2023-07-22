import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:search_test_api/src/models/search_address_model.dart';
import '../controllers/address_controller.dart';

class CardCustom extends StatefulWidget {
  final String cep;
  final String uf;
  final String address;
  final String neighborhood;
  final String city;
  final SearchAddressModel addressM;

  const CardCustom({
    Key? key,
    required this.cep,
    required this.uf,
    required this.address,
    required this.neighborhood,
    required this.city,
    required this.addressM,
  }) : super(key: key);

  @override
  State<CardCustom> createState() => _CardCustomState();
}

class _CardCustomState extends State<CardCustom> {
  var searchAddress = Get.put(SearchAddressController());
  bool isCardSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  const Text('Opções de endereço'),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      FontAwesomeIcons.xmark,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(140, 10),
                    ),
                  ),
                  onPressed: () {
                    searchAddress.deleteAddress(widget.cep);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Excluir',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(140, 10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      "/editAddressPage",
                      arguments: {
                        'address': widget.addressM,
                      },
                    );
                  },
                  child: const Text(
                    'Editar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: isCardSelected ? Colors.blue : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'CEP:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(57, 61, 80, 1),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.cep,
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'UF:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(57, 61, 80, 1),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.uf,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(
                    'Endereço:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(57, 61, 80, 1),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.address,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(
                    'Bairro:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(57, 61, 80, 1),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(widget.neighborhood),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(
                    'Cidade:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(57, 61, 80, 1),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.city,
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
