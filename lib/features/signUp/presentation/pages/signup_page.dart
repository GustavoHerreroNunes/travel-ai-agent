import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_ai_agent/features/components/floating_form/default_button.dart';
import 'package:travel_ai_agent/features/components/floating_form/floating_form.dart';
import 'package:travel_ai_agent/template/authentication_page.dart';
import 'package:travel_ai_agent/tools/breakpoints.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Breakpoint breakpoint;
  late Size windowSize;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
        label: "Name",
        controller: _nameController,
        validator: (value) {
          if (value != null && value.isNotEmpty) {
            return null;
          }
          return "Please, fill in this field";
        },
      ),
      TextFormFieldData(
        label: "Email",
        hint: "example@email.com",
        controller: _emailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please, fill in this field";
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
            return "Please, fill in this field";
          } else if (value.length < 8) {
            return "Password must have at least 8 characters";
          }
          return null;
        },
      ),
    ];

    return AuthenticationPage(
      pageContent: FloatingForm(
                  heading: "Sign Up",
                  subHeading: "Please, fill in the next fields to get started",
                  textFields: loginFields,
                  breakpoint: breakpoint,
                  windowSize: windowSize,
                  formButtons: [
                    FormButtonData(label: "Get Started", validateForm: true, onPressed: (isFormValid) async {
                      if(isFormValid!){
                        await _signUp(
                          _nameController.text,
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
                        label: 'Back to Login',
                        type: ButtonType.link, 
                        onPressed: (valid){
                          if(context.canPop()){
                            context.pop();
                          }else{
                            context.go('/');
                          }
                        }
                      )
                  ],
                ),
      alternativeButton: DefaultButton(buttonData: FormButtonData(
                          label: 'Back to Login',
                          type: ButtonType.link, 
                          onPressed: (valid){
                            if(context.canPop()){
                              context.pop();
                            }else{
                              context.go('/');
                            }
                          }
                        ), formKey: null),
      breakpoint: breakpoint,
      windowSize: windowSize,
    );
  }

  Future<void> _signUp(String name, String email, String password, BuildContext context) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign Up Successful!\n\nWelcome abord, Traveler!"))
      );

    } on FirebaseAuthException catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error trying to sign up. Please, try again later"))
      );
      print("Error ${e.code}: ${e.message}");
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error trying to sign up. Please, try again later"))
      );
      print("Invalid condition reached: $e");
    }
  }
}
