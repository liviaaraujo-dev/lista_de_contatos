
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  XFile? _photo;
  final _picker = ImagePicker();

  bool _isPhoto = false;

  Future<void> _loadPicker(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(source: source);
      if (file == null) return;
      _photo = XFile(file.path);

      if(_photo != null){
        String path = (await path_provider.getApplicationDocumentsDirectory()).path;
        String name = basename(_photo!.path);
        if(source == ImageSource.camera){
          await _photo!.saveTo("$path/$name");
          await GallerySaver.saveImage(_photo!.path);
        }
        setState(() {
          _isPhoto = true;
        });
      }
    } on PlatformException catch (e) {
      print("Falha ao carregar imagem: $e");
    }
  }

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
                    _contactRepository.deleteContact(widget.contact.objectId!);
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

  _modalPhoto(BuildContext context){
    showModalBottomSheet(
      context: context, 
      backgroundColor: AppColors.background2,
      builder: (context) {
        return Container(
          height: context.percentHeight(.25),
          width: context.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: context.percentWidth(.50),
                margin: EdgeInsets.only(bottom: 10),
                height: 45,
                child: ElevatedButton(
                  onPressed: (){
                    _loadPicker(ImageSource.gallery);
                    Navigator.pop(context);
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: Text('Galeria',style: TextStyle(color: Colors.white,  fontSize: 18))
                ),
              ),
              Container(
                width: context.percentWidth(.50),
                height: 45,
                child: ElevatedButton(
                  onPressed: (){
                    _loadPicker(ImageSource.camera);
                    Navigator.pop(context);
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: Text('Câmera',style: TextStyle(color: Colors.white,  fontSize: 18))
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
