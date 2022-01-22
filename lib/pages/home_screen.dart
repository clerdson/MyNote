import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mynote/main.dart';
import 'package:mynote/pages/edit_note.dart';
import 'package:mynote/pages/new_note.dart';
import 'db/sqlHelper.dart' as sql;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  DateTime date = DateTime.now();
  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await sql.sqlHelper.noteList();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    var rng = Random();
    String dateFormat = DateFormat('EEEE').format(date);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'Calendar',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            width: 600,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daysInMonth(date),
              itemBuilder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Center(
                      child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: snapshot == date.day
                              ? Colors.white
                              : Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 150,
                        height: 150,
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                dateFormat,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: snapshot == date.day
                                        ? Colors.black
                                        : Colors.black),
                              ),
                              Text(
                                snapshot.toString(),
                                style: TextStyle(
                                    fontSize: 30,
                                    color: snapshot == date.day
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
                );
              },
            ),
          ),
          Text('MyNote',style: TextStyle(fontSize:20 ),),
          Container(
            width: 400,
            height: 500,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _journals.length,
              itemBuilder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color((rng.nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                      ),
                      width: 400,
                      height: 200,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                   Text(
                                    _journals[snapshot]['title'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Edit(id: _journals[snapshot]['id'],)));
                                      },
                                      child: Icon(Icons.edit),),
                                  GestureDetector(
                                    onTap: () {
                                      sql.sqlHelper.deleteNote(_journals[snapshot]['id']);
                                      _refreshJournals();
                                    },
                                    child: Icon(Icons.delete),),
                                ],
                              ),
                               Text(
                                _journals[snapshot]['note'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ]),
                      )),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => New()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }


}
