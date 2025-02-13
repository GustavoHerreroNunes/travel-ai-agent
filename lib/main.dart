import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:travel_ai_agent/constants/routes_const.dart';
import 'package:travel_ai_agent/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  usePathUrlStrategy();
  runApp(const TravelAIAgent());
}

class TravelAIAgent extends StatelessWidget {
  const TravelAIAgent({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Travel AI Agent',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true
      ),
      routerConfig: routerConfig,
    );
  }
}