import 'dart:async';
import 'package:foss/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  Future<Map<String, dynamic>> fetchStudentData() async {
    Map<String, dynamic> l = {};
    try {
      final data =
          await sb.from('student').select().eq('uid', sb.auth.currentUser!.id);
      print(data[0]);
      l['fname'] = data[0]['first_name'];
      l['lname'] = data[0]['last_name'];
      l['regNo'] = "9177 ${data[0]['register_number']}";
      l['rollNo'] = data[0]['roll_number'];
      l['phone'] = data[0]['phone_number'];
      l['email'] = data[0]['email'];

      int a = int.parse(data[0]['register_number'].substring(0, 2));
      l['yos'] = '20$a - 20${a + 4}';
      print('data fetched');

      return l;
    } catch (e) {
      print(e.toString());
      return l;
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
