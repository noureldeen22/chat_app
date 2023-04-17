import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});
  static String id = 'RegisterPage';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;
  String? password;
  dynamic phoneNumber;

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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  children:
                  [
                    Image.asset('lib/assets/images/chat-app-logo-design-templa'
                        'te-can-be-used-icon-chat-application-logo_605910-1724.jpg',height: 205,),
                    const Text('Register',
                      style: TextStyle(
                          color: Color(0xFF03455C),
                          fontFamily: 'Pacifico',
                          fontSize: 25
                      ),),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
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
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
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
                        obscureText: true,
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
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (value)
                      {
                        if (value!.isEmpty)
                        {
                          return 'phone number must not be empty';
                        }
                        return null;
                      },
                        onChanged: (data)
                        {
                          phoneNumber = data;
                        },
                        decoration:
                        InputDecoration(
                          focusColor: const Color(0xFF03455C),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                          label: const Text('phone number'),
                          hoverColor: Colors.blue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
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
                             await registerUser();
                             Navigator.pushNamed(context, ChatPage.id,arguments: email);
                           } on FirebaseAuthException catch (e) {
                             if (e.code == 'weak-password') {
                               showSnackBar(context, 'weak password');
                             } else if (e.code == 'email-already-in-use') {
                               showSnackBar(context, 'email already exists');
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
                        const Text('Already have an account?',
                          style: TextStyle(
                            color: Color(0xFF03455C),
                            fontSize: 13,
                          ),),
                        TextButton(
                            onPressed: ()
                            {
                              Navigator.pop(context);
                            },
                            child: const Text('Login',
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
         SnackBar(content: Text(message)));
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email!,
        password: password!);
  }
}
