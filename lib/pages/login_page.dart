import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foss/args.dart';
import 'package:foss/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:foss/db.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final DatabaseService db = DatabaseService();
  bool passToggle = true;
  bool isLoading = false;
  bool isCompleted = false;
  late final StreamSubscription<AuthState> _authsubscription;

  @override
  void initState() {
    super.initState();
    _authsubscription = sb.auth.onAuthStateChange.listen((event) async {
      final session = event.session;
      if (session != null) {
        setState(() {
          isLoading = false;
          isCompleted = true;
        });
        if (await db.fetchStudentData()) {
          Navigator.pushNamed(context, '/home',
              arguments: args(db.fname, db.yos, db.regNo, db.rollNo));
        } else {
          Navigator.of(context).pushReplacementNamed('/basicinfo');
        }
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _authsubscription.cancel();
    super.dispose();
  }

  Future<void> _logIn() async {
    final email = _emailController.text;
    final password = _passController.text;
    try {
      final response = await sb.auth.signInWithPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Logged In Successfully')));

      debugPrint(response.user.toString());
    } on AuthException catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
    } catch (error) {
      setState(() {
        isLoading = false;
        isCompleted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PROCTOR"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/graduated.png",
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 50),
                TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passController,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                InkWell(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    _logIn();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: isLoading || isCompleted
                          ? Colors.white
                          : Colors.indigo,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : isCompleted
                            ? const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.green,
                                size: 45.0,
                              )
                            : const Center(
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/signup');
                        },
                        child: const Text(
                          "Create an account?",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
