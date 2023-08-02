import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/contact_model.dart';

class ContactRepository{
  final Dio _dio = Dio();

  Future<List<ContactModel>> getContacts() async {
    try {
      final response = await _dio.get(
        dotenv.env['BASEURL']!,
        options: Options(
          headers: {
            'X-Parse-Application-Id': dotenv.env['XPARSEAPPLICATIONID']!,
            'X-Parse-REST-API-Key': dotenv.env['XPARSEESTAPIKEY']!,
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
        dotenv.env['BASEURL']!,
        options: Options(
          headers: {
            'X-Parse-Application-Id': dotenv.env['XPARSEAPPLICATIONID']!,
            'X-Parse-REST-API-Key':  dotenv.env['XPARSEESTAPIKEY']!,
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
        dotenv.env['BASEURL']!+ contactModel.objectId.toString(),
        options: Options(
          headers: {
            'X-Parse-Application-Id': dotenv.env['XPARSEAPPLICATIONID']!,
            'X-Parse-REST-API-Key':  dotenv.env['XPARSEESTAPIKEY']!,
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
        dotenv.env['BASEURL']!+ $objectId,
        options: Options(
          headers: {
            'X-Parse-Application-Id': dotenv.env['XPARSEAPPLICATIONID']!,
            'X-Parse-REST-API-Key':  dotenv.env['XPARSEESTAPIKEY']!,
          },
        ),
      );
    } catch (error) {
      throw error;
    }
  } 
}
