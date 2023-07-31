import 'package:dio/dio.dart';

import '../../models/contact_model.dart';

class CreateContactRepository{
  final Dio _dio = Dio();
  
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
}