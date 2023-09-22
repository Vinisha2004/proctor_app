import 'dart:async';
import 'package:foss/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  late final String fname;
  late final String lname;
  late final String regNo;
  late final String rollNo;
  late final int phone;
  late final String email;
  late final String yos;

  Future<bool> fetchStudentData() async {
    try {
      final data =
          await sb.from('student').select().eq('uid', sb.auth.currentUser!.id);
      print(data[0]);
      fname = data[0]['first_name'];
      lname = data[0]['last_name'];
      regNo = "9177 ${data[0]['register_number']}";
      rollNo = data[0]['roll_number'];
      phone = data[0]['phone_number'];
      email = data[0]['email'];

      int a = int.parse(data[0]['register_number'].substring(0, 2));
      yos = '20$a - 20${a + 4}';

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future createStudentData({
    required String fname,
    required String lname,
    required String regNo,
    required String rollNo,
    required int phone,
  }) async {
    try {
      PostgrestResponse? response = await sb.from('student').insert({
        'first_name': fname,
        'last_name': lname,
        'register_number': regNo,
        'roll_number': rollNo,
        'phone_number': phone,
        'email': sb.auth.currentUser!.email,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
