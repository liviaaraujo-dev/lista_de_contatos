import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lista_de_contatos/models/contact_model.dart';

class HomeRepository{
    final Dio _dio = Dio();

  Future<List<ContactModel>> getContacts() async {
    try {
      final response = await _dio.get(
        'https://parseapi.back4app.com/classes/contact',
        options: Options(
          headers: {
            'X-Parse-Application-Id': 'VWGDW6nDA9m9aac6WcJ7bmHValmHwi1yZnWe6zGZ',
            'X-Parse-REST-API-Key': 'RERlXRsO2VAqoFPOQtiiLmAxvnGwrZ2OsYQQSgic',
          },
        ),
      );

      return ContactsModel.fromJson(response.data).results as List<ContactModel>;
    } catch (error) {
      print('Erro ao fazer a requisição: $error');
      return[];
    }
  }
}
