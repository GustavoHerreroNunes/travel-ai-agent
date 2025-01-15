import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_ai_agent/features/components/floating_form/default_button.dart';
import 'package:travel_ai_agent/features/components/floating_form/floating_form.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFields = [
      TextFormFieldData(label: "Email", hint: "example@email.com", validator: (value){
        if(value == null || value.isEmpty){
          return "Required field";
        }else if (!value.contains("@")){
          return "Please, enter a valid email address";
        }
        return null;
      }),
      TextFormFieldData(label: "Password", hint: "********", validator: (value) {
        if(value == null || value.isEmpty){
          return "Required field";
        }
        return null;
      })
    ];
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(padding: EdgeInsets.only(left: 50, right: 50), child: 
              Column(children: [
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
                    FormButtonData(label: "Sign In", validateForm: true, onPressed: (isFormValid) {
                      if(isFormValid!){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Form is Valid!!!"))
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
                getDefaultButton(FormButtonData(
                    label: "Create an Account",
                    type: ButtonType.link, 
                    onPressed: (valid){
                      context.push('/signup');
                    }
                  ), null)
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
}