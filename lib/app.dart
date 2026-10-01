import 'package:flutter/material.dart';
import 'package:ourobank_aplication/commons/constants/app_colors.dart';
import 'package:ourobank_aplication/features/onboarding/onboarding.dart';
import 'package:ourobank_aplication/features/sign_in/sign_in_page.dart';
import 'package:ourobank_aplication/features/sign_up/sign_up_page.dart';
import 'package:ourobank_aplication/features/splash/splash_page.dart';
import 'package:ourobank_aplication/features/convert/convert_page.dart';
import 'package:ourobank_aplication/features/dashboard/dashboard_page.dart';
import 'package:ourobank_aplication/features/dashboard/poupanca_page.dart';
import 'package:ourobank_aplication/features/forgetting/forgetting_page.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

     
      initialRoute: '/',

    
      routes: {
        '/': (context) => const SplashPage(),

        '/onboarding': (context) => const OnboardingPage(),

        '/cadastrar': (context) => const SignUpPage(),

        '/convert': (context) => const ConvertPage(),

        '/login': (context) => const SignInPage(),

        '/home': (context) => const DashboardPage(),

        '/poupanca': (context) => const PoupancaPage(),
        
        //'/pagamento': (context) => const PaymentPage(),

        '/esqueciSenha': (context) => const ForgettingPage(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.black,
        primaryColor: AppColors.yellow,
      ),
    );
  }
}