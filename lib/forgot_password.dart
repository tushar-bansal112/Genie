import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectss/util.dart';
class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Forgot Password',
          style:  TextStyle(
            fontSize: 20,
            height: 1.5,
            color:  Color.fromRGBO(19, 61, 95, 1),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Container(
                  width: size.width * 0.8,
                  child: const Text(
                    'Enter your email we will send instruction to reset your password',
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.5,
                      color:  Color.fromRGBO(19, 61, 95, 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                      onPressed: forget,
                      child: const Text(
                        'Send',
                        style: TextStyle(
                          fontSize: 22,
                          height: 1.5,
                          color:  Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Future forget() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailTextController.text.trim(),
      ).then((value){
        final snackBar = Utils().errorMessage('We have sent you email to recover password, please check email');
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } on FirebaseAuthException catch(e){
      final snackBar = Utils().errorMessage(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }
}
