import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_ai_agent/features/components/floating_form/default_button.dart';
import 'package:travel_ai_agent/features/components/floating_form/floating_form.dart';

class ForgotPassPage extends StatefulWidget {
  ForgotPassPage({super.key});

  @override
  ForgotPassPageState createState() => ForgotPassPageState();
}

class ForgotPassPageState extends State<ForgotPassPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingForm(
                    heading: "Forgot Password",
                    subHeading: "Enter your email to receive a verification link",
                    textFields: forgotPassFields,
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
                    ],
                  ),
                  const SizedBox(height: 10),
                  DefaultButton(
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
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("project_banner.jpg"),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.red),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Travel AI Agent",
                            style: TextStyle(
                              fontSize: 65,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Discover the Amazing!",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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