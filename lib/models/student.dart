class Student{
  int? id;
  late String name;
  late String course;
  late int mobile;
  late int totalFee;
  late int paidFee;

  Student(this.name, this.course, this.mobile, this.totalFee, this.paidFee);

  Student.name(this.id, this.name, this.course, this.mobile, this.totalFee,
      this.paidFee);

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
      'course' : course,
      'mobile' : mobile,
      'totalFee' : totalFee,
      'paidFee' : paidFee
    };
  }

  Student.fromMap(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    course = map['course'];
    mobile = map['mobile'];
    totalFee = map['totalFee'];
    paidFee = map['paidFee'];
  }

}