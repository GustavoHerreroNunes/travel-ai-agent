import 'package:flutter/material.dart';
import 'package:travel_ai_agent/constants/routes_const.dart';
import 'package:travel_ai_agent/features/logIn/presentation/pages/login_page.dart';

void main() {
  runApp(const TravelAIAgent());
}

class TravelAIAgent extends StatelessWidget {
  const TravelAIAgent({super.key});

  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      title: 'Travel AI Agent',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)
      ),

      routes: {
        RoutesConst.home : (context) => const Placeholder(),
        RoutesConst.logIn: (context) => LoginPage()
      }
    );
  }
}