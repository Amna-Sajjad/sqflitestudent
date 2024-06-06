import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflitestudent/db/database_helper.dart';
import 'package:sqflitestudent/models/student.dart';
import 'package:sqflitestudent/screens/view_student_screen.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  var formKey = GlobalKey<FormState>();
  late String name;
  late String course;
  late int mobile;
  late int totalFee;
  late int paidFee;
  TextEditingController nameController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController paidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: "Name",
                  ),
                  controller: nameController,
                  validator: (String? text){
                    if(text==null || text.isEmpty){
                      return "Provide Name";
                    }
                    else{
                      name = text;
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: "Course",
                  ),
                  controller: courseController,
                  validator: (String? text){
                    if(text==null || text.isEmpty){
                      return "Provide Course";
                    }
                    else{
                      course = text;
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: "Mobile",
                  ),
                  controller: mobileController,
                  validator: (String? text){
                    if(text==null || text.isEmpty){
                      return "Provide Mobile";
                    }
                    else{
                      mobile = int.parse(text);
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: "Total Fee",
                  ),
                  controller: totalController,
                  validator: (String? text){
                    if(text==null || text.isEmpty){
                      return "Provide Total Fee";
                    }
                    else{
                      totalFee = int.parse(text);
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: "Paid Fee",
                  ),
                  controller: paidController,
                  validator: (String? text){
                    if(text==null || text.isEmpty){
                      return "Provide Paid Fee";
                    }
                    else{
                      paidFee = int.parse(text);
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  child: Container(
                    width: double.infinity,
                    child: Text("Save", textAlign: TextAlign.center,),
                  ),
                  onPressed: () async {
                    if(formKey.currentState!.validate()){
                      var student = Student(name, course, mobile, totalFee, paidFee);
                      var dbHelper = DatabaseHelper.helper;
                      int result = await dbHelper.insertStudent(student);
                      if(result > 0){
                        nameController.text = "";
                        courseController.text = "";
                        mobileController.text = "";
                        totalController.text = "";
                        paidController.text = "";
                        Fluttertoast.showToast(msg: "Saved Successfully");
                      }
                    }
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: Container(
                    width: double.infinity,
                    child: Text("View All", textAlign: TextAlign.center,),
                  ),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return ViewStudents();
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
