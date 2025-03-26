import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:my_wallet/views/home/home_view.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'views/login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Wallet',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const LoginScreen(),        
        //home: const HomeView(),
      ),
    );
  }
}
