import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lista_de_contatos/models/contact_model.dart';
import 'package:lista_de_contatos/pages/contact/contact_page.dart';
import 'package:lista_de_contatos/pages/create_contact/create_contact_page.dart';
import 'package:lista_de_contatos/shared/helpers/size_extensions.dart';
import 'package:lista_de_contatos/shared/theme/app_colors.dart';

class ContactItem extends StatefulWidget {
  final ContactModel contact;
  const ContactItem({super.key, required this.contact});

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ContactPage(contact: widget.contact,)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 50,
        width: context.percentWidth(.8),
        decoration: BoxDecoration(
            color: AppColors.background2,
            borderRadius: BorderRadius.circular(40)),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            widget.contact.img!.length > 1 ?
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.file(
                    File(widget.contact.img!), 
                    height: 40,
                    width: 40, 
                    fit: BoxFit.cover,
                  )
                )
              :
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: Icon(Icons.person, color: Colors.white, size: 36,)
              ),
            const SizedBox(
              width: 20,
            ),
            Text(
              widget.contact.name.toString(),
              style: TextStyle(
                  color: AppColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
