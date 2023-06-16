import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectss/util.dart';
class CreateNewAccount extends StatefulWidget {

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _confirmpasswordTextController = TextEditingController();
  final _name = TextEditingController();
  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _name.dispose();
    _confirmpasswordTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.width * 0.1,
            ),
            Stack(
              children: [
                Center(
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: CircleAvatar(
                        radius: size.width * 0.14,
                        backgroundColor: Colors.grey[400]!.withOpacity(
                          0.4,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: size.width * 0.1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.width * 0.1,
            ),
            Column(
              children: [
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
                        controller: _name,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 26,
                              color: Colors.black,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: 'User',
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
                        keyboardType: TextInputType.name,
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
                        controller: _confirmpasswordTextController,
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
                          hintText: 'Confirm Password',
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
                const SizedBox(
                  height: 25,
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
                      onPressed: signup,
                      child: const Text(
                        'Register',
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
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style:  TextStyle(
                        fontSize: 22,
                        height: 1.5,
                        color:  Color.fromRGBO(19, 61, 95, 1),
                      ),
                    ),
                    GestureDetector(


                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text(
                        'Login',
                        style: const TextStyle(
                          fontSize: 22,
                          height: 1.5,
                          color:  Colors.black,
                        ).copyWith(
                            color: Colors.blue.shade300, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  bool passwordConfirmed(){
    if(_passwordTextController.text.trim()==_confirmpasswordTextController.text.trim()){
      return true;
    }else{
      return false;
    }
  }
  Future signup() async {
    if(passwordConfirmed()){
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailTextController.text.trim(),
          password: _passwordTextController.text.trim(),
        ).then((value) {
          Timer(
              const Duration(seconds: 1),
                  ()=>Navigator.pushNamed(context, '/')
          );
        });
        addUser(_name.text.trim(), _emailTextController.text.trim());
      }on FirebaseAuthException catch (e){
        final snackBar = Utils().errorMessage(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future addUser(String name,String email) async{
    await FirebaseFirestore.instance.collection('users').add({
      'name' : name,
      'e-mail': email,
    });
  }
}
