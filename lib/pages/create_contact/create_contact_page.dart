import 'package:flutter/material.dart';
import 'package:lista_de_contatos/shared/theme/colors.dart';

class CreateContactPage extends StatefulWidget {
  const CreateContactPage({super.key});

  @override
  State<CreateContactPage> createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar novo contato'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed:(){
            Navigator.pop(context);
          },
            icon: Icon(Icons.arrow_back_ios, color: AppColors.primary,
          ))
      ),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              child: Stack(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: AppColors.primary,
                    size: 200,
                  ),
                  Text('Tirar Foto')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}