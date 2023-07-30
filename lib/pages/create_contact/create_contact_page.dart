import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:lista_de_contatos/shared/helpers/size_extensions.dart';
import 'package:lista_de_contatos/shared/theme/colors.dart';

class CreateContactPage extends StatefulWidget {
  const CreateContactPage({super.key});

  @override
  State<CreateContactPage> createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  final MaskedTextController phone = MaskedTextController(mask: '(00) 00000-0000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Criar novo contato', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.text),),
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.backgroundPurple,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primary,
              ))),
      body: SingleChildScrollView(
        child: Container(
        height: context.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  Center(
                    child: GestureDetector(
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 36,)
                      )
                    ),
                  ),
                  Container(
                    width: context.percentWidth(.85),
                    margin: EdgeInsets.only(top: 40),
                    height: 50,
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: AppColors.primary,),
                        hintText: 'Nome',
                        hintStyle: TextStyle(color: AppColors.text),
                        fillColor: AppColors.background2,
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ) ,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        )
                      ),  
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: context.percentWidth(.85),
                    height: 50,
                    child: TextFormField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone, color: AppColors.primary,),
                        hintText: 'Telefone',
                        hintStyle: TextStyle(color: AppColors.text),
                        fillColor: AppColors.background2,
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ) ,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        )
                      ),  
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: context.percentWidth(.85),
                    height: 50,
                    child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: AppColors.primary,),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: AppColors.text),
                        fillColor: AppColors.background2,
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ) ,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        )
                      ),  
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: context.percentWidth(.40),
                        height: 45, 
                        child: ElevatedButton(
                          onPressed: (){}, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.background,
                            elevation: 0,
                          ),
                          child: Text('Cancelar',style: TextStyle(color: AppColors.primary, fontSize: 18) )
                        ),
                      ),
                      Container(
                        width: context.percentWidth(.40),
                        height: 45,
                        child: ElevatedButton(
                          onPressed: (){}, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          child: Text('Salvar',style: TextStyle(color: Colors.white,  fontSize: 18) )
                        ),
                    )
                    ],
                  ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
