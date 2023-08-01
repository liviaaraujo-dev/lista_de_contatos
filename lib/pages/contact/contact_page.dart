
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_de_contatos/models/contact_model.dart';
import 'package:lista_de_contatos/pages/edit_contact/edit_contact_page.dart';
import 'package:lista_de_contatos/repositorys/contact_repository.dart';
import 'package:lista_de_contatos/shared/helpers/size_extensions.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared/theme/app_colors.dart';

class ContactPage extends StatefulWidget {
  final ContactModel contact;
  const ContactPage({super.key, required this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactRepository _contactRepository = ContactRepository();

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
    .map((MapEntry<String, String> e) =>
        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
    .join('&');
  }

  Future<void> _shareText(String text) async {
    await Share.share(text);
  }
  
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
                  const SizedBox(height: 25),
                  Container(
                    height: context.percentHeight(.32),
                    width: context.percentWidth(.9),
                    decoration: BoxDecoration(
                      color: AppColors.background2,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.contact.img!.length > 1 ?
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                              File(widget.contact.img!), 
                              height: 90,
                              width: 90, 
                              fit: BoxFit.cover,
                            )
                          )
                        :
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
                              Text('Telefone', style: TextStyle(color: AppColors.text)),
                              Text(widget.contact.phone!, style: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.w500),)
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
                                  Text('Email', style: TextStyle(color: AppColors.text)),
                                  Text(widget.contact.email!, style: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.w500))
                                ],
                              ),
                              IconButton(
                                onPressed: (){
                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: widget.contact.email,
                                    // query: encodeQueryParameters(<String, String>{}),
                                  );
                                  launchUrl(emailLaunchUri);
                                },
                                icon: Icon(Icons.email, color: AppColors.primary,)
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
                  onTap: (){
                     Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditContactPage(contactModel: widget.contact,)));
                  },
                  child: Column(
                    children: [
                      Icon(Icons.edit, color: AppColors.text,),
                      Text('Editar', style: TextStyle(color: AppColors.text),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _shareText(widget.contact.name! + '\nTelefone: ' + widget.contact.phone.toString() + '\nEmail: ' + widget.contact.email.toString());
                  },
                  child: Column(
                    children: [
                      Icon(Icons.share, color: AppColors.text,),
                      Text('Compartilhar', style: TextStyle(color: AppColors.text),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    _deleteContact(context);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.delete, color: AppColors.text,),
                      Text('Excluir', style: TextStyle(color: AppColors.text))
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

  _deleteContact(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.background2,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            height: context.percentHeight(.20),
            width: context.percentWidth(.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Desejar Excluir?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,color: AppColors.text),),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                      await _contactRepository.deleteContact(widget.contact.objectId!);
                      Phoenix.rebirth(context);
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                          elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    child: Text('Sim', style: TextStyle(fontSize: 16, color: Colors.white),),),
                    SizedBox(width: 20,),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                          elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    child: Text('Não', style: TextStyle(fontSize: 16, color: Colors.white),),),
                  ],
                )
              ],
            ),
          )
        );
      }
    );
  }
  
}
