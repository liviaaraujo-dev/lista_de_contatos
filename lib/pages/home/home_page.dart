import 'package:flutter/material.dart';
import 'package:lista_de_contatos/models/contact_model.dart';
import 'package:lista_de_contatos/pages/home/widgets/contact_item.dart';
import 'package:lista_de_contatos/repositorys/contact_repository.dart';
import 'package:lista_de_contatos/shared/helpers/size_extensions.dart';
import 'package:lista_de_contatos/shared/theme/app_colors.dart';
import '../create_contact/create_contact_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContactModel> filteredItems = [];

  ContactRepository contactRepository = ContactRepository();
  late List<ContactModel> _contacts;


  @override
  void initState() {
    _getContacts();
    super.initState();
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = _contacts
          .where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _getContacts() async {
    _contacts = await contactRepository.getContacts();
    filteredItems = _contacts;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: context.percentWidth(.9),
                    child: TextField(
                      style: TextStyle(color: AppColors.text),
                      onChanged: _filterItems,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(color: AppColors.text),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.text,
                          size: 20,
                        ),
                        filled: true,
                        fillColor: AppColors.backgroundPurple,
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: context.percentHeight(.8),
                  width: context.percentWidth(.9),
                  margin: EdgeInsets.only(top: 25),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: filteredItems.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ContactItem(contact: filteredItems[index],);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateContactPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
