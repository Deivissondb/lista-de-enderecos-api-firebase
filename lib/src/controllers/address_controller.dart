import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:search_test_api/src/models/search_address_model.dart';

class SearchAddressController extends GetxController {
  var listAddress = RxList<SearchAddressModel?>();
  var loadRemoveUser = false.obs;
  var preference = Rx<SearchAddressModel?>(null);

  TextEditingController cepController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  var searchController = TextEditingController().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getSearchAddress(String cep) async {
    var client = http.Client();

    try {
      var res = await client.get(
        Uri.parse('https://viacep.com.br/ws/$cep/json/'),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        var data = convert.jsonDecode(convert.utf8.decode(res.bodyBytes));
        preference.value = SearchAddressModel.fromJson(data);
        setAddressValues();
      } else {
        clearTextFields();
        const snackBar = SnackBar(
          content: Text(
              'Não foi possível buscar o CEP informado, verifique se os dados estão corretos.'),
          backgroundColor: Color.fromARGB(255, 184, 16, 4),
          behavior: SnackBarBehavior.fixed,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      }

      if (preference.value == null) {
        clearTextFields();
      }
    } catch (e) {
      preference.value = null;
      clearTextFields();
      const snackBar = SnackBar(
        content: Text(
            'Não foi possível buscar o CEP informado, verifique se os dados estão corretos.'),
        backgroundColor: Color.fromARGB(255, 184, 16, 4),
        behavior: SnackBarBehavior.fixed,
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  Future<bool> saveAddressToFirestore(SearchAddressModel address) async {
    try {
      String keyID;

      DocumentReference chatDocRef = await firestore.collection('address').add({
        'cep': address.cep,
        'uf': address.uf,
        'logradouro': address.logradouro,
        'bairro': address.bairro,
        'localidade': address.localidade,
        'create_date': Timestamp.fromDate(DateTime.now()),
      });
      keyID = chatDocRef.id;
      await chatDocRef.update({'address_id': keyID});

      const snackBar = SnackBar(
        content: Text('Endereço salvo com sucesso no Firestore'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

      return true;
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Erro ao salvar o endereço no Firestore'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

      return false;
    }
  }

  void setAddressValues() {
    addressController.text = preference.value?.logradouro ?? '';
    neighborhoodController.text = preference.value?.bairro ?? '';
    cityController.text = preference.value?.localidade ?? '';
    ufController.text = preference.value?.uf ?? '';
  }

  void clearTextFields() {
    addressController.clear();
    neighborhoodController.clear();
    cityController.clear();
    ufController.clear();
  }

  Future<bool> updateAddress(SearchAddressModel updatedAddress) async {
    try {
      await firestore
          .collection('address')
          .doc(updatedAddress.addressId)
          .update({
        'cep': updatedAddress.cep,
        'logradouro': updatedAddress.logradouro,
        'bairro': updatedAddress.bairro,
        'localidade': updatedAddress.localidade,
        'uf': updatedAddress.uf,
        'address_id': updatedAddress.addressId,
      });

      setAddressValues();

      const snackBar = SnackBar(
        content: Text('Endereço atualizado com sucesso'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

      return true;
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Erro ao salvar o endereço'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

      return false;
    }
  }

  Future<bool> deleteAddress(String cep) async {
    try {
      var querySnapshot = await firestore
          .collection('address')
          .where('cep', isEqualTo: cep)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentId = querySnapshot.docs[0].id;
        await firestore.collection('address').doc(documentId).delete();

        const snackBar = SnackBar(
          content: Text('Endereço deletado com sucesso'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

        return true;
      }

      return false;
    } catch (e) {
      const errorSnackBar = SnackBar(
        content: Text('Erro ao deletar o endereço'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(errorSnackBar);

      return false;
    }
  }
}
