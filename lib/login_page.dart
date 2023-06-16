import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectss/util.dart';
class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children:  [
          Container(
            margin: const EdgeInsets.only(top: 100.0),
            child: const Center(
              child: Text(
                'Genie',
                style: TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 60,
                    color:  Color.fromRGBO(19, 61, 95, 1),
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            height: 123,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                      'assets/image/login_page.jpg',
                    )
                )
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0,bottom: 10),
                child: Center(
                  child: Container(
                    height: size.height*0.08,
                    width: size.width*0.8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:  TextField(
                      controller: _emailTextController,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Icon(
                            Icons.email,
                            size: 26,
                            color: Colors.black,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Email',
                        helperStyle: TextStyle(
                          fontSize: 22,
                          height: 1.5,
                          color: Colors.black,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 22,
                        height: 1.5,
                        color:  Color.fromRGBO(19, 61, 95, 1),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                  child: Container(
                    height: size.height*0.08,
                    width: size.width*0.8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:  TextField(
                      controller: _passwordTextController,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Icon(
                            Icons.lock,
                            size: 26,
                            color: Colors.black,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Password',
                        helperStyle: TextStyle(
                          fontSize: 22,
                          height: 1.5,
                          color: Colors.black,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 22,
                        height: 1.5,
                        color:  Color.fromRGBO(19, 61, 95, 1),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'ForgotPassword'),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child:  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color:  Color.fromRGBO(19, 61, 95, 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: size.height*0.08,
                  width: size.width*0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue.shade300,
                  ),
                  child: TextButton(
                    onPressed: signin,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 22,
                        height: 1.5,
                        color:  Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'CreateNewAccount'),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(19, 61, 95, 1),
                      ),
                  ),
              ),
              child:  const Text(
                'Create New Account',
                style: TextStyle(
                  fontSize: 20,
                  height: 1.5,
                  color:  Color.fromRGBO(19, 61, 95, 1),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future signin() async {

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
      ).then((value){
        Timer(
            const Duration(milliseconds: 800),
            ()=>Navigator.pushNamed(context, 'HomePage')
        );
      });
    } on FirebaseAuthException catch(e){
      final snackBar = Utils().errorMessage(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
