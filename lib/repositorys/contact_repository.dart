import 'package:dio/dio.dart';

import '../../models/contact_model.dart';

class ContactRepository{
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
  
 Future<void> createContact(ContactModel contactModel) async {
    try {
      final response = await _dio.post(
        'https://parseapi.back4app.com/classes/contact',
        options: Options(
          headers: {
            'X-Parse-Application-Id': 'VWGDW6nDA9m9aac6WcJ7bmHValmHwi1yZnWe6zGZ',
            'X-Parse-REST-API-Key': 'RERlXRsO2VAqoFPOQtiiLmAxvnGwrZ2OsYQQSgic',
          },
        ),
        data: contactModel.toCreateJson()
      );
    } catch (error) {
      throw error;
    }
  } 

  Future<void> updateContact(ContactModel contactModel) async {
    try {
      final response = await _dio.put(
        'https://parseapi.back4app.com/classes/contact/${contactModel.objectId}',
        options: Options(
          headers: {
            'X-Parse-Application-Id': 'VWGDW6nDA9m9aac6WcJ7bmHValmHwi1yZnWe6zGZ',
            'X-Parse-REST-API-Key': 'RERlXRsO2VAqoFPOQtiiLmAxvnGwrZ2OsYQQSgic',
          },
        ),
        data: contactModel.toCreateJson()
      );
    } catch (error) {
      throw error;
    }
  } 

   Future<void> deleteContact(String $objectId) async {
    try {
      final response = await _dio.delete(
        'https://parseapi.back4app.com/classes/contact/${$objectId}',
        options: Options(
          headers: {
            'X-Parse-Application-Id': 'VWGDW6nDA9m9aac6WcJ7bmHValmHwi1yZnWe6zGZ',
            'X-Parse-REST-API-Key': 'RERlXRsO2VAqoFPOQtiiLmAxvnGwrZ2OsYQQSgic',
          },
        ),
      );
    } catch (error) {
      throw error;
    }
  } 
}
