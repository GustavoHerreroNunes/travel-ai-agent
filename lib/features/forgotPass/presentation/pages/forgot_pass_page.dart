import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_ai_agent/features/components/floating_form/default_button.dart';
import 'package:travel_ai_agent/features/components/floating_form/floating_form.dart';

class ForgotPassPage extends StatelessWidget {
  const ForgotPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotPassFields = [
      TextFormFieldData(
        label: "Email",
        hint: "example@email.com",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required field";
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
                children: [
                  FloatingForm(
                    heading: "Forgot Password",
                    subHeading: "Enter your email to receive a verification link",
                    textFields: forgotPassFields,
                    formButtons: [
                      FormButtonData(
                        label: "Send Verification E-mail",
                        validateForm: true,
                        onPressed: (isFormValid) {
                          if (isFormValid!) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Verification email sent!")),
                            );
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
                  getDefaultButton(
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
                    ),
                    null,
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
}