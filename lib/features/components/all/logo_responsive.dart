import 'package:flutter/material.dart';
import 'package:travel_ai_agent/tools/breakpoints.dart';

class LogoResponsive extends StatelessWidget {
  const LogoResponsive({
    super.key, 
    required this.breakpoint, 
    required this.maxWidth
  });

  final Breakpoint breakpoint;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    Image logo = (breakpoint != Breakpoint.compact && breakpoint != Breakpoint.medium)
                    ? Image(
                      image: AssetImage("logo-desktop.png"),
                      width: maxWidth
                    ) 
                    : Image(
                        image: AssetImage("logo-mobile.png"),
                      );
              
    return logo;
  }
}