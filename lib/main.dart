import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muroappmod/pages/WrapWidget.dart';
import 'package:muroappmod/pages/information_page.dart';
import 'package:muroappmod/pages/welcome.dart';
import 'package:muroappmod/preferencias_usuario/preferencias_usuario.dart';
import 'package:provider/provider.dart';
import 'pages/fullscreenmap.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/splash_page.dart';
import 'stores/login_store.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();
  
  runApp(App());
  
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black
    ));

    return Provider<LoginStore>(
      create: (_) => LoginStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'welcome',
        routes: {
          'wrap' : (BuildContext context) => WrapWidgetDemo(),
          'welcome' : (BuildContext context) => const WelcomePage(),
          'splash' : (BuildContext context) => const SplashPage(),
          'login' : (BuildContext context) => const LogintoPage(),
          'home' : (BuildContext context) => const HomePage(),
          'mapa' : (BuildContext context) => FullScreenMap(),
          'information' : (BuildContext context) => const InformationPage(),
        },
        theme: ThemeData(
        cursorColor: Color.fromRGBO(27, 94, 32, 1.0),
        primaryColor: Color.fromRGBO(27, 94, 32, 1.0),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Color.fromRGBO(27, 94, 32, 1.0)),
          labelStyle: TextStyle(color: Color.fromRGBO(27, 94, 32, 1.0)),
        )
      ),
      ),
    );
  }
}