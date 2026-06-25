import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_parcel_app/ui/views/views.dart';
import 'package:flutter_parcel_app/utils/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_parcel_app/auth/auth.dart';

Future<void> main() async {
  await dotenv.load(fileName:'.env');
  print(dotenv.env['API_BASE_URL']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final auth = AuthService();
        auth.loadToken(); //load token on startup
        return auth;
      },
      child: Consumer<AuthService>(
          builder: (context, auth, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ParcelAppTheme.getLightTheme,
              initialRoute: auth.isAuthenticated ? '/home' : '/login',
              routes: {
                '/login': (context) => const LoginScreen(),
                '/register' : (context) => const RegisterScreen(),
                '/home': (context) => const MainScreen(title: 'Laptop Harbor'),
              },
            );
          }
      ),
    );
  }
}
