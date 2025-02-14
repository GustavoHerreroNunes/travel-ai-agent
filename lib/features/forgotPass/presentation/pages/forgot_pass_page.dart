import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_ai_agent/features/components/floating_form/default_button.dart';
import 'package:travel_ai_agent/features/components/floating_form/floating_form.dart';
import 'package:travel_ai_agent/template/authentication_page.dart';
import 'package:travel_ai_agent/tools/breakpoints.dart';

class ForgotPassPage extends StatefulWidget {
  ForgotPassPage({super.key});

  @override
  ForgotPassPageState createState() => ForgotPassPageState();
}

class ForgotPassPageState extends State<ForgotPassPage> {
  final TextEditingController _emailController = TextEditingController();
  late Breakpoint breakpoint;
  late Size windowSize;

  @override
  void dispose() {
    _emailController.dispose();
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
    final forgotPassFields = [
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
    ];

    return AuthenticationPage(
      pageContent: FloatingForm(
                    heading: "Forgot Password",
                    subHeading: "Enter your email to receive a verification link",
                    textFields: forgotPassFields,
                    breakpoint: breakpoint,
                    windowSize: windowSize,
                    formButtons: [
                      FormButtonData(
                        label: "Send Verification E-mail",
                        validateForm: true,
                        onPressed: (isFormValid) async {
                          if (isFormValid!) {
                            await _resetPassword(_emailController.text, context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Error: Form has invalid fields.")),
                            );
                          }
                        },
                      ),
                      if(breakpoint == Breakpoint.compact || breakpoint == Breakpoint.medium)
                        FormButtonData(
                          label: "Back to Login",
                          type: ButtonType.link,
                          onPressed: (valid) {
                            if(context.canPop()){
                              context.pop();
                            }else{
                              context.go('/');
                            }
                          },
                        )
                    ],
                  ), 
      alternativeButton: DefaultButton(
                          buttonData: FormButtonData(
                            label: "Back to Login",
                            type: ButtonType.link,
                            onPressed: (valid) {
                              if(context.canPop()){
                                context.pop();
                              }else{
                                context.go('/');
                              }
                            },
                          ),
                          formKey: null
                        ),
      breakpoint: breakpoint, 
      windowSize: windowSize);
  }

  Future<void> _resetPassword(String email, BuildContext context) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Verification email sent!")),
      );
    } on FirebaseAuthException catch (e){
      
      String errorMessage = "An error occurred while reseting your password. Please try again later";

      print("Error '${e.code}' - ${e.message}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage))
      );
    }
  }
}