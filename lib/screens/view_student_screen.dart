import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflitestudent/screens/update_student_screen.dart';

import '../db/database_helper.dart';
import '../models/student.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({Key? key}) : super(key: key);

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {

  List<Student> students = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Students"),
      ),
      body: FutureBuilder<List<Student>>(
        future: DatabaseHelper.helper.getAllStudents(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          else{
            if(snapshot.data!.isEmpty){
              return const Center(child: Text("No record found"),);
            }
            else{
              students = snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(20),
                child: ListView.builder(
                  itemCount: students == null? 0 : students.length,
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.orange[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.pink[100],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${students[index].id}"),
                                  Text(students[index].name),
                                  Text(students[index].course),
                                  Text("${students[index].mobile}"),
                                  Text("${students[index].totalFee}"),
                                  Text("${students[index].paidFee}"),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () async{
                                    String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                      return UpdateStudent(student:students[index]);
                                    }));

                                    if(result.toString() == 'done'){
                                      setState(() {

                                      });
                                    }
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: (){
                                    showDialog(
                                      barrierDismissible: false,
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            title: Text("Confirmation"),
                                            content: Text("Do you want to delete?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("No"),
                                              ),
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                    int result = await DatabaseHelper.helper.deleteStudent(students[index].id!);
                                                    if(result > 0){
                                                      Fluttertoast.showToast(msg: "Student Deleted");
                                                      setState(() {

                                                      });
                                                    }
                                                  },
                                                  child: Text("Yes"),
                                              ),
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
