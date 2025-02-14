import 'package:flutter/material.dart';

class MediaQueryController {
  static final List<double> _compact = [599];
  static final List<double> _medium = [600, 839];
  static final List<double> _expanded = [840];

  static double getWindowWidth(BuildContext context){
    return MediaQuery.sizeOf(context).width;
  }

  static double getWindowHeight(BuildContext context){
    return MediaQuery.sizeOf(context).height;
  }

  static Size getWindowSize(BuildContext context){
    return Size(
      MediaQueryController.getWindowWidth(context),
      MediaQueryController.getWindowHeight(context)
    );
  }

  static Breakpoint getDeviceBreakpoint(BuildContext context){
    final double windowWidth = getWindowWidth(context);
    if(windowWidth <= _compact[0]){
      return Breakpoint.compact;
    }else if(windowWidth >= _medium[0] && windowWidth <= _medium[1]){
      return Breakpoint.medium;
    }
    return Breakpoint.expanded;
  }
}
enum Breakpoint{
  compact,
  medium,
  expanded
}