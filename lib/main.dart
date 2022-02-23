import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fanpage_flutter/providers/user_provider.dart';
import 'package:fanpage_flutter/responsive/mobile_screen_layout.dart';
import 'package:fanpage_flutter/responsive/responsive_layout_screen.dart';
import 'package:fanpage_flutter/responsive/web_screen_layout.dart';
import 'package:fanpage_flutter/screens/login_screen.dart';
import 'package:fanpage_flutter/screens/signup_screen.dart';
import 'package:fanpage_flutter/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCCpfMCJ7V8RLbyljHvk_qhb4bwUGAMM-k", // Your apiKey
        appId: "1:673777223173:web:423e8921e53b74aaaabe6c", // Your appId
        messagingSenderId: "673777223173", // Your messagingSenderId
        projectId: "fanpage-app-cced6", // Your projectId
        storageBucket:
            "fanpage-app-cced6.appspot.com", //This is to store the firebase database
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
        child: MaterialApp(
          title: 'My FanPage App',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
          ),
          //home: const ResponsiveLayout(
          //  mobileScreenLayout: MobileScreenLayout(),
          //  webScreenLayout: WebScreenLayout(),
          //),
          home: AnimatedSplashScreen(
            splash: 'assets/yellow_duck.jfif',
            duration: 3000,
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: primaryColor,
            nextScreen: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }
                return const LoginScreen();
              },
            ),
          ),
        ));
  }
}
