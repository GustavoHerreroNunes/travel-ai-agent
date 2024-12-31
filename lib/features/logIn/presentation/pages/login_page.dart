import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Center(child: Text("Login Form"))),
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