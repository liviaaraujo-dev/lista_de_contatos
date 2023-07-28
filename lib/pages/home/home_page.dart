
import 'package:flutter/material.dart';
import 'package:lista_de_contatos/pages/home/widgets/contact_item.dart';
import 'package:lista_de_contatos/shared/helpers/size_extensions.dart';
import 'package:lista_de_contatos/shared/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    final List<String> items = [
    'Item 1',
    'Ana Lívia',
    'Levy',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
    'Item 11',
    'Item 12',
    'Item 13',
  ];

  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = items;
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
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
                SizedBox(height: 10,),
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
                        prefixIcon: Icon(Icons.search,color: AppColors.text, size: 20,),
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
                    child:
                        ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: filteredItems.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ContactItem(name: filteredItems[index]);
                          },
                        ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                //   child: TextField(
                //     decoration: InputDecoration(
                //       hintText: "Search...",
                //       hintStyle: TextStyle(color: Colors.grey),
                //       prefixIcon: Icon(Icons.search,color: AppColors.text, size: 20,),
                //       filled: true,
                //       fillColor: AppColors.background3,
                //       contentPadding: EdgeInsets.all(8),
                //       enabledBorder: OutlineInputBorder(
                        
                //           borderRadius: BorderRadius.all(Radius.circular(20)),
                          
                //       ),
                //     ),
                //   ),
                // ),
                // ContactItem(name: 'Ana Livia Alves')
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
