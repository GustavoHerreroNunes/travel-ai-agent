import 'package:flutter/material.dart';

class Breakpoints {
  static final List<double> _compact = [599];
  static final List<double> _medium = [600, 839];
  static final List<double> _expanded = [840];

  static double getWindowWidth(BuildContext context){
    return MediaQuery.sizeOf(context).width;
  }

  static double getWindowHeight(BuildContext context){
    return MediaQuery.sizeOf(context).height;
  }

  static Options getDeviceBreakpoint(BuildContext context){
    final double windowWidth = getWindowWidth(context);
    if(windowWidth <= _compact[0]){
      return Options.compact;
    }else if(windowWidth >= _medium[0] && windowWidth <= _medium[1]){
      return Options.medium;
    }
    return Options.expanded;
  }
}
enum Options{
  compact,
  medium,
  expanded
}