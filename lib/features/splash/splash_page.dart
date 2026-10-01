import 'dart:async';
import 'package:flutter/material.dart';
import '../../commons/constants/app_colors.dart';
import '../../commons/constants/app_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {

    super.initState();
  
    Timer(
      const Duration(seconds: 2),

    () {

      if (mounted) {

      Navigator.pushReplacementNamed(
        context,
        '/onboarding',
         );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.blackgray,
              AppColors.black,
            ],
          ),
        ),

        child: Text(
          'OuroBank',
          style: AppTextStyle.bigText.copyWith(
            color: AppColors.yellow,
          ),
        ),
      ),
    );
  }
}