import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/services/tree_prefs_service.dart';
import 'package:tree_app/utils/routes.dart';
import 'package:tree_app/view_models/auth_view_model.dart';
import 'package:tree_app/views/authority/authority_home_screen.dart';
import 'package:tree_app/views/citizen/citizen_home_screen.dart';
import 'package:tree_app/views/auth//login_screen.dart';
import 'package:tree_app/views/officer/officer_home_screen.dart';
import 'package:tree_app/views/auth/registration_screen.dart';
import 'package:tree_app/views/common/role_selection_screen.dart';
import 'package:tree_app/views/auth/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set to use local font files instead of downloading from Google Fonts
  GoogleFonts.config.allowRuntimeFetching = false;
  
  // Initialize shared preferences
  await TreePrefsService.initializePrefs();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // recheck karna padega

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
        initialRoute: Routes.splash, // Splash screen route
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

              // main home screens
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
