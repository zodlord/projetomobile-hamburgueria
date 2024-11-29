import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jacksonsburger/data/profit_data.dart';
import 'package:jacksonsburger/firebase_options.dart';
import 'package:jacksonsburger/pages/auth_page.dart';
import 'package:jacksonsburger/pages/lucro_page.dart';
import 'package:jacksonsburger/pages/pedidos_page.dart';
import 'package:jacksonsburger/pages/home_page.dart';
import 'package:jacksonsburger/pages/calculadora_page.dart';
import 'package:jacksonsburger/pages/profile_page.dart';
import 'package:jacksonsburger/pages/splash_page.dart';
import 'package:provider/provider.dart';


Future<void> main() async {

  await Hive.initFlutter();

  await Hive.openBox("profit_database");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // setUrlStrategy(PathUrlStrategy()); // to remove the '#' in the URL
  runApp(const JacksonsBurger());
}

class JacksonsBurger extends StatelessWidget {
  const JacksonsBurger({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfitData(),
      builder: (context, child) => MaterialApp(
        title: "Jackson's Burger",
        home: AuthPage(),
        routes: {
          SplashPage.id: (context) => SplashPage(),
          HomePage.id: (context) => HomePage(),
          CalculadoraPage.id: (context) => CalculadoraPage(),
          PedidosPage.id: (context) => PedidosPage(),
          LucroPage.id: (context) => LucroPage(),
          ProfilePage.id: (context) => ProfilePage(),
        },
      ),
    );
  }
}