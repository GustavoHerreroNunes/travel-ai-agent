import 'package:flutter/material.dart';

class FloatingForm extends StatefulWidget {
  const FloatingForm({super.key});

  @override
  State<FloatingForm> createState() => _FloatingFormState();
}

class _FloatingFormState extends State<FloatingForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      color: Colors.grey,
      child: Padding(padding: EdgeInsets.only(top: 70, bottom: 70, left: 25, right: 25), child: 
        Column(
          spacing: 24,
          children: [
            Text("Login"),
            Text("Welcome back, Traveler!"),
            SizedBox(height: 18),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "katherin.johnson@email.com"
              ),
              validator: (value) {
                if(value != null && value.isNotEmpty){
                  return null;
                }else{
                  return "Please, fill in this field";
                }
              },
            )
          ],
        ))
    );
  }
}