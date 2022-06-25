import 'package:flutter/material.dart';
import 'package:flutter_app2/helper/databasehelper.dart';
import 'package:flutter_app2/screen/detailpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBHelper dbHelper = DBHelper();
  String? email;
  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('email') ?? 0;
    setState(() {
      print(value);
      email = prefs.getString('email');
      print(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            dbHelper.getData();
          });
        },
        child: FutureBuilder<List>(
          future: dbHelper.getData(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ItemList(list: snapshot.data)
                : CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  List? list;
  ItemList({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            //detail
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return DetailPage(list: list, index: index);
                },
              ),
            );
          },
          child: Card(
            child: ListTile(
              title: Text(list![index]['nmproduct'].toString()),
              leading: Icon(Icons.precision_manufacturing),
            ),
          ),
        );
      },
    );
  }
}
