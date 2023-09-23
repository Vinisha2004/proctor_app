import 'package:flutter/material.dart';
import 'package:foss/pages/basic_info.dart';
import 'package:foss/pages/home_page.dart';
import 'package:foss/pages/login_page.dart';
import 'package:foss/pages/my_profile.dart';
import 'package:foss/pages/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:foss/db.dart';
import 'package:foss/pages/message_page.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://eqoojbpbidscikuorsbd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVxb29qYnBiaWRzY2lrdW9yc2JkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ5MTkzMDMsImV4cCI6MjAxMDQ5NTMwM30.irXm-ijqDE6mZhcdjed-4AVX0n1VhP1WaJCts0JF2gE',
    //authFlowType: AuthFlowType.pkce,
  );
  runApp(const MyApp());
}

final sb = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PROCTOR APP',
      debugShowCheckedModeBanner: false,
      // theme: ThemeDatColor.fromARGB(255, 4, 16, 87),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/basicinfo': (context) => const RegisterPage(),
        '/message': (context) => const ComplaintForm(),
        '/profile': (context) => const MyProfileScreen(),
      },
    );
  }
}
