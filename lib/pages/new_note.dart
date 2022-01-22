import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mynote/pages/home_screen.dart';
import 'package:mynote/pages/note.dart';
import 'db/sqlHelper.dart' as sql;

class New extends StatefulWidget {
  const New({Key? key}) : super(key: key);

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<New> {
  final controllerTitle = TextEditingController();
  final controllerNote = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          SizedBox(height: 100,),
          Text('MyNote',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),),
        SizedBox(height: 10,),
        Card(
            color: Colors.black,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: controllerTitle,
                style: TextStyle(color: Colors.white),
                maxLines: 4,
                decoration:
                    InputDecoration.collapsed(hintText: "Enter your text here"),
              ),
            )),
        Card(
            color: Colors.black,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: controllerNote,
                 style: TextStyle(color: Colors.white),
                maxLines: 8,
                decoration:
                    InputDecoration.collapsed(hintText: "Enter your text here"),
              ),
            ))
      ]),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        var idRandom = Random();
        int id = idRandom.nextInt(100);
        sql.sqlHelper.insertNote(Note( title: controllerTitle.text, note: controllerNote.text, id:id ));
        
        
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
        },
      backgroundColor: Colors.black,
      child: Icon(Icons.arrow_back),
    ),
    );
  }
}
