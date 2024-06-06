import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../db/database_helper.dart';
import '../models/student.dart';

class UpdateStudent extends StatefulWidget {
  final Student student;
  const UpdateStudent({Key? key, required this.student}) : super(key: key);

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {

  var updateFormKey = GlobalKey<FormState>();
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
        title: Text("Student Detail"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: updateFormKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.student.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: "Name",
                  ),
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
                  initialValue: widget.student.course,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: "Course",
                  ),
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
                  initialValue: widget.student.mobile.toString(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: "Mobile",
                  ),
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
                  initialValue: widget.student.totalFee.toString(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: "Total Fee",
                  ),
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
                  initialValue: widget.student.paidFee.toString(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: "Paid Fee",
                  ),
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
                    child: Text("Update", textAlign: TextAlign.center,),
                  ),
                  onPressed: () async {
                    if(updateFormKey.currentState!.validate()){
                      var student = Student.name(widget.student.id, name, course, mobile, totalFee, paidFee);
                      var dbHelper = DatabaseHelper.helper;
                      int result = await dbHelper.updateStudent(student);
                      if(result > 0){
                        nameController.text = "";
                        courseController.text = "";
                        mobileController.text = "";
                        totalController.text = "";
                        paidController.text = "";
                        Fluttertoast.showToast(msg: "Update Successfully");
                        Navigator.pop(context, 'done');
                      }
                    }
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
