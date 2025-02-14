import 'package:flutter/material.dart';
import 'package:travel_ai_agent/features/components/floating_form/default_button.dart';
import 'package:travel_ai_agent/tools/breakpoints.dart';

class AuthenticationPage extends StatefulWidget {
  AuthenticationPage({
    super.key, 
    required this.pageContent,
    required this.alternativeButton,
    required this.breakpoint,
    required this.windowSize
  });

  final Widget pageContent;
  final DefaultButton alternativeButton;
  final Breakpoint breakpoint;
  final Size windowSize;

  @override
  AuthenticationPageState createState() => AuthenticationPageState();
}

class AuthenticationPageState extends State<AuthenticationPage> {
  late double xPadding;


  @override
  Widget build(BuildContext context) {
    print("[breakpoint]: ${widget.breakpoint}");

    xPadding = widget.breakpoint == Breakpoint.compact ? 0 : 50;

    return Scaffold(
      body: SingleChildScrollView(child: 
        Row(
          children: [
            Expanded(
              child: Padding(padding: EdgeInsets.only(left: xPadding, right: xPadding), child: 
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  if(widget.breakpoint == Breakpoint.compact || widget.breakpoint == Breakpoint.medium)
                    _getMediumCompactMedia(),
                  
                  widget.pageContent,

                  SizedBox(height: 10),

                  if(widget.breakpoint == Breakpoint.expanded)
                    widget.alternativeButton
                ])
              )),
            if(widget.breakpoint == Breakpoint.expanded)            
              _getExpandedMedia()
          ],
        )
    ));
  }

  Widget _getExpandedMedia(){
    return SizedBox(
      height: widget.windowSize.height,
      width: widget.windowSize.width/2.3,
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
                    Text("Travel AI Agent", style: TextStyle(fontSize: 45, fontWeight: FontWeight.w600, color: Colors.white),),
                    Text("Discover the Amazing!", style: TextStyle(fontSize: 20, color: Colors.white))
                  ],
                )
              )
            )
          )
        ],
      ),
    );
  }

  Widget _getMediumCompactMedia(){
    return
      Container(height: 100, decoration: 
                  BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("project_banner-small.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topRight)));
  }
}