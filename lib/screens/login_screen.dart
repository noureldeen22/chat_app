import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String id = 'loginScreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;

  String? password;

  bool? isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
        inAsyncCall: isLoading,
        blurEffectIntensity: 4,
        progressIndicator: const CircularProgressIndicator(
        color: kPrimaryColor,
    ),
    dismissible: false,
    opacity: 0.4,
    color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  children:
                  [
                    Image.asset('lib/assets/images/chat-app-logo-design-template-can-be-used-icon-chat-application-logo_605910-1724.jpg'),
                    const Text('Login',
                    style: TextStyle(
                      color: Color(0xFF03455C),
                      fontFamily: 'Pacifico',
                      fontSize: 25
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty)
                          {
                            return 'email must not be empty';
                          }
                          return null;
                        },
                        onChanged: (data)
                        {
                          email = data;
                        },
                        decoration:
                        InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                          label: const Text('email address'),
                          hoverColor: Colors.blue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        obscureText: true,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'password must not be empty';
                          }
                          return null;
                        },
                        onChanged: (data)
                        {
                          password = data;
                        },
                        decoration:
                        InputDecoration(
                          focusColor: const Color(0xFF03455C),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                          label: const Text('password'),
                          hoverColor: Colors.blue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: const BoxDecoration(
                        ),
                        height: 45,
                        width: double.infinity,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            onPressed: ()
                              async {
                                if (formKey.currentState!.validate()){
                                  isLoading = true;
                                  setState(() {

                                  });
                                  try
                                  {
                                    await loginUser();
                                    Navigator.pushNamed(context, ChatPage.id,arguments: email);
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      showSnackBar(context, 'No user found for that email.');
                                    } else if (e.code == 'wrong-password') {
                                      showSnackBar(context, 'Wrong password provided for that user.');
                                    }
                                  }
                                  catch(e)
                                  {
                                    showSnackBar(context, 'there was an error');
                                  }
                                  isLoading = false;
                                  setState(() {

                                  });
                                }else
                                {

                                }
                              },
                          color: const Color(0xFF03455C),
                        child: const Text('Login',
                        style: TextStyle(
                          color: Colors.white
                        ),),),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?',
                          style: TextStyle(
                          color: Color(0xFF03455C),
                              fontSize: 13,
      ),),
                        TextButton(
                            onPressed: ()
                            {
                             Navigator.pushNamed(context, 'RegisterPage');
                            },
                            child: const Text('Register now',
                            style: TextStyle(
                              color: Colors.blue
                            ),))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
            content: Text(message),
        ), );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance.
    signInWithEmailAndPassword(
        email: email!,
        password: password!);}
}
