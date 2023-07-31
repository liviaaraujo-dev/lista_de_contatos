
import 'package:flutter/material.dart';
import 'package:lista_de_contatos/models/contact_model.dart';
import 'package:lista_de_contatos/shared/helpers/size_extensions.dart';

import '../../shared/theme/app_colors.dart';

class ContactPage extends StatefulWidget {
  final ContactModel contact;
  const ContactPage({super.key, required this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundPurple,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
          )
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: context.percentHeight(.35),
                    width: context.percentWidth(.9),
                    decoration: BoxDecoration(
                      color: AppColors.background2,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Icon(Icons.person, color: Colors.white, size: 36,)
                        ),
                        SizedBox(height: 10,),
                        Text(widget.contact.name!, style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 26)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 180,
                    width: context.percentWidth(.9),
                    decoration: BoxDecoration(
                      color: AppColors.background2,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Telefone'),
                              Text(widget.contact.phone!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Email'),
                                  Text(widget.contact.email!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                                ],
                              ),
                              IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.email)
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.share),
                      Text('Editar')
                    ],
                  ),
                ),
                InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.share),
                      Text('Compartilhar')
                    ],
                  ),
                ),
                InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.share),
                      Text('Excluir')
                    ],
                  ),
                )
              ],
            ),
          )
          
        ],
      ),
    );
  }
}
