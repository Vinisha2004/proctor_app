import 'package:flutter/material.dart';
import 'package:foss/db.dart';
import 'dart:async';
import 'package:foss/main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //create the controllers
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController regController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PERSONAL INFO'),
      ),
      //for the form to be in center
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: fnameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'First Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: lnameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Last Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: regController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Register Number',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: rollController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Roll Number',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone Number',
                ),
              ),
              //some space between name and email
              const SizedBox(
                height: 40,
              ),

              //create button for register
              ElevatedButton(
                onPressed: () async {
                  await DatabaseService().createStudentData(
                    fname: fnameController.text,
                    lname: lnameController.text,
                    regNo: regController.text,
                    rollNo: rollController.text,
                    phone: int.parse(phoneController.text),
                  );
                  //we will trying to print input
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
