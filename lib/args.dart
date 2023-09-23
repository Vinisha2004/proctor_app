class args {
  final String fname;
  final String lname;
  final String yos;
  final String regNo;
  final String rollNo;
  final String email;
  final int phone;

  args(this.fname, this.lname, this.yos, this.regNo, this.rollNo, this.email,
      this.phone);

  String findClass() {
    if (regNo.contains('C')) {
      return "CSE";
    }
    return "";
  }
}
