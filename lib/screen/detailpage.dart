import 'package:flutter/material.dart';
import 'package:flutter_app2/helper/databasehelper.dart';
import 'package:flutter_app2/screen/editpage.dart';
import 'package:flutter_app2/screen/homepage.dart';
import 'package:flutter_app2/screen/tabberpage.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  List? list;
  int index;
  DetailPage({Key? key, this.list, required this.index}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // function Delete
  DBHelper dbHelper = DBHelper();

  void confirm(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are You Sure'),
            content: const Text('Do you want to delete this item?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  dbHelper.deleteData(widget.list![widget.index]['id']);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TabberPage()));
                },
                child: const Text('Yes, Delete this item'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.list![widget.index]['nmproduct']),
      ),
      body: Container(
        height: 500,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          shadowColor: Colors.black,
          elevation: 4.0,
          margin: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nama Product: ${widget.list![widget.index]['nmproduct']}",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Stock: ${widget.list![widget.index]['stock']}",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => EditPage(
                                  list: widget.list, index: widget.index)),
                        );
                      },
                      child: Text('edit'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () {
                        confirm(context);
                      },
                      child: Text(
                        'Delete',
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
