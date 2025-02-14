import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_ai_agent/features/components/floating_form/default_button.dart';
import 'package:travel_ai_agent/features/components/floating_form/floating_form.dart';
import 'package:travel_ai_agent/template/authentication_page.dart';
import 'package:travel_ai_agent/tools/breakpoints.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  late Breakpoint breakpoint;
  late Size windowSize;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    breakpoint = MediaQueryController.getDeviceBreakpoint(context);
    windowSize = MediaQueryController.getWindowSize(context);
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

    return AuthenticationPage(
      pageContent: FloatingForm(
                    heading: "Login",
                    subHeading: "Welcome back, traveler!",
                    textFields: loginFields,
                    breakpoint: breakpoint,
                    windowSize: windowSize,
                    formButtons: [
                      FormButtonData(
                        label: "Forgot Password?", 
                        type: ButtonType.link, 
                        alignment: Alignment.centerRight, 
                        onPressed: (valid){
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
                      if(breakpoint == Breakpoint.compact || breakpoint == Breakpoint.medium)
                        FormButtonData(
                          label: "Create an Account",
                          type: ButtonType.link, 
                          onPressed: (valid){
                            context.push('/signup');
                          }
                        )
                    ],
                  ), 
      alternativeButton: DefaultButton(
                          buttonData: FormButtonData(
                            label: "Create an Account",
                            type: ButtonType.link, 
                            onPressed: (valid){
                              context.push('/signup');
                            }
                          ), formKey: null), 
      breakpoint: breakpoint, 
      windowSize: windowSize
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