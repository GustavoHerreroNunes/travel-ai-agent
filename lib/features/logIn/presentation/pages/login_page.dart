import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_ai_agent/features/components/floating_form/default_button.dart';
import 'package:travel_ai_agent/features/components/floating_form/floating_form.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginFields = [
      TextFormFieldData(
        label: "Email",
        hint: "example@email.com",
        focusNode: _emailFocus,
        controller: _emailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required field";
          } else if (!value.contains("@")) {
            return "Please, enter a valid email address";
          }
          return null;
        },
      ),
      TextFormFieldData(
        label: "Password",
        hint: "********",
        isPassword: true,
        controller: _passwordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required field";
          }
          return null;
        },
      ),
    ];

    return Scaffold(
            body: Row(
        children: [
          Expanded(
            child: Padding(padding: EdgeInsets.only(left: 50, right: 50), child: 
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                FloatingForm(
                  heading: "Login",
                  subHeading: "Welcome back, traveler!",
                  textFields: loginFields,
                  formButtons: [
                    FormButtonData(
                      label: "Forgot Password?", 
                      type: ButtonType.link, 
                      alignment: Alignment.centerRight, 
                      onPressed: (valid){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Clicked the link"))
                        );
                        context.push('/forgot_password');
                    }),
                    FormButtonData(label: "Sign In", validateForm: true, onPressed: (isFormValid) async {
                      if(isFormValid!){
                        await _signIn(
                          _emailController.text, 
                          _passwordController.text, 
                          context
                        );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Error: Form has invalid fields."))
                        );
                      }
                    }),
                  ],
                ),
                SizedBox(height: 10),
                DefaultButton(
                  buttonData: FormButtonData(
                    label: "Create an Account",
                    type: ButtonType.link, 
                    onPressed: (valid){
                      context.push('/signup');
                    }
                  ), formKey: null)
              ])
            )),
          Expanded(
            child: Column(
              children: [
                Expanded(flex: 3, child: Container(decoration: 
                                          BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage("project_banner.jpg"),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center)))),
                Expanded(flex: 1, child: 
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.red),
                    
                    child: Padding(padding: EdgeInsets.only(right: 30), child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Travel AI Agent", style: TextStyle(fontSize: 65, fontWeight: FontWeight.w600, color: Colors.white),),
                          Text("Discover the Amazing!", style: TextStyle(fontSize: 20, color: Colors.white))
                        ],
                      )
                    )
                  )
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Future<void> _signIn(String email, String password, BuildContext context) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logged in successfully! Welcome back, Traveler!"))
      );

    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred during sign in. Please try again later";

      if(e.code == 'invalid-credential'){
        errorMessage = 'Email or password are invalid.';
      }

      print("Error '${e.code}' - ${e.message}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage))
      );
      
      _emailFocus.requestFocus();

    }
  }
}