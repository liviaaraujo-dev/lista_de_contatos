import 'package:flutter/material.dart';
import 'package:lista_de_contatos/shared/helpers/size_extensions.dart';
import 'package:lista_de_contatos/shared/theme/colors.dart';

class ContactItem extends StatefulWidget {
  final String name;
  const ContactItem({super.key, required this.name});

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 50,
        width: context.percentWidth(.8),
        decoration: BoxDecoration(
          color: AppColors.background2,
          borderRadius: BorderRadius.circular(40)
        ),
        child: Row(
          children: [
            const SizedBox(width: 20,),
            Icon(Icons.account_circle, color: AppColors.primary, size: 40,),
            const SizedBox(width: 20,),
            Text(widget.name, style: TextStyle(
        color: AppColors.text,
        fontSize: 16,
        fontWeight: FontWeight.w500
      ),)
          ],
        ),
      ),
    );
  }
}
