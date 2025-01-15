import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_ai_agent/features/components/floating_form/default_button.dart';
import 'package:travel_ai_agent/features/components/floating_form/floating_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFields = [
      TextFormFieldData(label: "Name", validator: (value){
        if(value != null && value.isNotEmpty){
          return null;
        }
        return "Please, fill in this field";
      }),
      TextFormFieldData(label: "Email", hint: "example@email.com", validator: (value) {
        if(value == null || value.isEmpty){
          return "Please, fill in this field";
        }else if (!value.contains("@")){
          return "Please, enter a valid email address";
        }
        return null;
      }),
      TextFormFieldData(label: "Password", hint: "********", validator: (value) {
        if(value == null || value.isEmpty){
          return "Please, fill in this field";
        }else if(value.length < 8){
          return "Password must to have at least 8 characters";
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
                  heading: "Sign Up",
                  subHeading: "Please, fill in the next fields to get started",
                  textFields: loginFields,
                  formButtons: [
                    FormButtonData(label: "Get Started", onPressed: (isFormValid) {
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
                    label: 'Back to Login',
                    type: ButtonType.link, 
                    onPressed: (valid){
                      if(context.canPop()){
                        context.pop();
                      }else{
                        context.go('/');
                      }
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