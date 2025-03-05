import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_ai_agent/features/components/all/logo_responsive.dart';
import 'package:travel_ai_agent/features/components/floating_form/default_button.dart';
import 'package:travel_ai_agent/tools/breakpoints.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color bgColor = Color.fromRGBO(166, 38, 38, 1);
  late Breakpoint breakpoint;
  late Size windowSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    breakpoint = MediaQueryController.getDeviceBreakpoint(context);
    windowSize = MediaQueryController.getWindowSize(context);
  }

  @override
  void initState() {
    super.initState();
    if(FirebaseAuth.instance.currentUser != null){
      print("User logged in");
    }else{
      print("No session running...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _getExpandedMedia(context),
            if(breakpoint != Breakpoint.compact && breakpoint != Breakpoint.medium)
              Text(
                  "Copyright (c) 2025 - Gustavo Herrero Nunes",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.ltr,
                ),
          ],
        ),
      ),
    );
  }

  Widget _getExpandedMedia(BuildContext context) {
    final double width = (breakpoint == Breakpoint.compact) ? windowSize.width
      : (breakpoint == Breakpoint.medium) ? windowSize.width / 1.5
      : 450;
    final double height = (breakpoint == Breakpoint.compact || breakpoint == Breakpoint.medium) ? windowSize.height
      : windowSize.height / 1.2;

    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LogoResponsive(breakpoint: breakpoint, maxWidth: width/3),

              _getSpacer(),

              Text(
                "Travel AI Agent",
                style: TextStyle(
                  fontSize: 25,
                  color: bgColor,
                  fontWeight: FontWeight.w600
                ),
                textDirection: TextDirection.ltr,
              ),
              
              _getSpacer(),
              
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Let's discover the amazing today?",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
              Expanded(flex: 1, child: SizedBox()),
              
              _getActionButtons(context, width),
              
              _getSpacer(),

              if(breakpoint == Breakpoint.compact || breakpoint == Breakpoint.medium)
                Text("Copyright (c) 2025 - Gustavo Herrero Nunes"),            
            ],
          )
        )
      )
    );
  }

  Widget _getActionButtons(BuildContext context, double parentWidth){
    if(breakpoint != Breakpoint.compact){
      return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DefaultButton(
                    buttonData: FormButtonData(
                      label: "Create an Account", 
                      type: ButtonType.link,
                      onPressed: (v){
                        context.push("/signup");
                      }
                    ),
                    width: parentWidth/2.5,
                  ),
                  DefaultButton(
                    buttonData: FormButtonData(
                      label: "Login", 
                      type: ButtonType.submit,
                      onPressed: (v){
                        context.push("/login");
                      }
                    ),
                    width: parentWidth/2.5,
                  ),
                ],
              );
    }
    return Column(
              children: [
                DefaultButton(
                  buttonData: FormButtonData(
                    label: "Login", 
                    type: ButtonType.submit,
                    onPressed: (v){
                      context.push("/login");
                    }
                  ),
                ),
                _getSpacer(),
                DefaultButton(
                  buttonData: FormButtonData(
                    label: "Create an Account", 
                    type: ButtonType.link,
                    onPressed: (v){
                      context.push("/signup");
                    }
                  ),
                ),
              ],
            );
  }

  Widget _getSpacer() {
    return SizedBox(height: 10);
  }
}
