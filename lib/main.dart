import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/utils/routes.dart';
import 'package:tree_app/view_models/auth_view_model.dart';
import 'package:tree_app/views/authority_home_screen.dart';
import 'package:tree_app/views/citizen_home_screen.dart';
import 'package:tree_app/views/login_screen.dart';
import 'package:tree_app/views/officer_home_screen.dart';
import 'package:tree_app/views/registration_screen.dart';
import 'package:tree_app/views/role_selection_screen.dart';
import 'package:tree_app/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        title: 'TreeGuard',
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case Routes.splash:
              return MaterialPageRoute(builder: (_) => const SplashScreen());
            case Routes.roleSelection:
              return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());
            case Routes.login:
              return MaterialPageRoute(builder: (_) => const LoginScreen());
            case Routes.register:
              return MaterialPageRoute(builder: (_) => const RegistrationScreen());
            case Routes.citizenHome:
              return MaterialPageRoute(builder: (_) => const CitizenHomeScreen());
            case Routes.officerHome:
              return MaterialPageRoute(builder: (_) => const OfficerHomeScreen());
            case Routes.authorityHome:
              return MaterialPageRoute(builder: (_) => const AuthorityHomeScreen());
            default:
              return MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
