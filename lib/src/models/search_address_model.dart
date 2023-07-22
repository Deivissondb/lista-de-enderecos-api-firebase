import 'dart:convert';

SearchAddressModel searchAddressModelFromJson(String str) =>
    SearchAddressModel.fromJson(json.decode(str));

String searchAddressModelToJson(SearchAddressModel data) =>
    json.encode(data.toJson());

class SearchAddressModel {
  String cep;
  String logradouro;
  String bairro;
  String localidade;
  String uf;
  String addressId;

  SearchAddressModel(
      {required this.cep,
      required this.logradouro,
      required this.bairro,
      required this.localidade,
      required this.uf,
      required this.addressId});

  factory SearchAddressModel.fromJson(Map<String, dynamic> json) =>
      SearchAddressModel(
        cep: json["cep"],
        logradouro: json["logradouro"],
        bairro: json["bairro"],
        localidade: json["localidade"],
        uf: json["uf"],
        addressId: json["address_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "cep": cep,
        "logradouro": logradouro,
        "bairro": bairro,
        "localidade": localidade,
        "uf": uf,
        "address_id": addressId
      };
}
