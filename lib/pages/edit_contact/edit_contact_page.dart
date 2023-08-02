import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_de_contatos/repositorys/contact_repository.dart';
import 'package:lista_de_contatos/shared/helpers/size_extensions.dart';
import 'package:lista_de_contatos/shared/theme/app_colors.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import '../../models/contact_model.dart';


class EditContactPage extends StatefulWidget {
  final ContactModel contactModel;
  const EditContactPage({super.key, required this.contactModel});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  final MaskedTextController _phone = MaskedTextController(mask: '(00) 00000-0000');

  ContactRepository contactRepository = ContactRepository();

  XFile? _photo;
  final _picker = ImagePicker();

  Future<void> _loadPicker(ImageSource source, BuildContext context) async {
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
      }
    } on PlatformException catch (e) {
      print("Falha ao carregar imagem: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getValues();
    super.initState();
  }

  void getValues(){
    setState(() {
      _email.text = widget.contactModel.email!;
      _name.text = widget.contactModel.name!;
      _phone.text = widget.contactModel.phone!;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar contato', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.text),),
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
                  widget.contactModel.img!.length > 1 || _photo != null ?
                  Center(
                    child: GestureDetector(
                    onTap: (){
                      _modalPhoto(context);
                    },
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Builder(
                      builder: (context) {
                        if(_photo != null){
                          return Image.file(
                              File(_photo!.path), 
                              height: 90,
                              width: 90, 
                              fit: BoxFit.cover,
                            );
                        }
                        return Image.file(
                          File(widget.contactModel.img.toString()), 
                          height: 90,
                          width: 90, 
                          fit: BoxFit.cover,
                        ); 
                      }
                    )
                    ),
                  ),
                )
                :  
                Center(
                  child: GestureDetector(
                    onTap: (){
                      _modalPhoto(context);
                    },
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
                    height: 60,
                    child: TextFormField(
                      controller: _name,
                      style: TextStyle(color: AppColors.text),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: AppColors.primary,),
                        hintText: 'Nome',
                        hintStyle: TextStyle(color: AppColors.text, fontSize: 18),
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
                    height: 60,
                    child: TextFormField(
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: AppColors.text),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone, color: AppColors.primary,),
                        hintText: 'Telefone',
                        hintStyle: TextStyle(color: AppColors.text, fontSize: 18),
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
                    height: 60,
                    child: TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: AppColors.text),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: AppColors.primary,),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: AppColors.text, fontSize: 18),
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
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
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
                          onPressed: () async {
                            if(_email.text.length > 0 && _phone.text.length > 0 && _name.text.length > 0) {
                              await contactRepository.updateContact(ContactModel(
                                email: _email.text,
                                createdAt: widget.contactModel.createdAt,
                                objectId: widget.contactModel.objectId,
                                updatedAt: widget.contactModel.updatedAt,
                                phone: _phone.text,
                                name: _name.text,
                                img: _photo != null ? _photo!.path : widget.contactModel.img,
                              ));
                              _contactUpdate(context, 'Contato Atualizado!');
                            }
                          }, 
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

  _contactUpdate(BuildContext context, String _msg){
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
                Text(_msg, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,color: AppColors.text),),
                SizedBox(height: 15,),
                ElevatedButton(onPressed: (){
                  Phoenix.rebirth(context);
                }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                      elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                child: Text('Voltar', style: TextStyle(fontSize: 16, color: Colors.white),),)
              ],
            ),
          )
        );
      }
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
                  onPressed: () async {
                    await _loadPicker(ImageSource.gallery, context);
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
                  onPressed: () async {
                    await _loadPicker(ImageSource.camera, context);
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
