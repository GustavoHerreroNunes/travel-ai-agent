import 'package:flutter/material.dart';
import 'package:travel_ai_agent/constants/routes_const.dart';

void main() {
  runApp(const TravelAIAgent());
}

class TravelAIAgent extends StatelessWidget {
  const TravelAIAgent({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Travel AI Agent',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)
      ),
      routerConfig: routerConfig,
    );
  }
}