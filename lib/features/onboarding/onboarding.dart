import 'package:flutter/material.dart';
import 'package:ourobank_aplication/commons/constants/app_colors.dart';
import 'package:ourobank_aplication/commons/constants/app_text.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.38,
                  width: double.infinity,
                  child: Center(
                    child: Image.asset(
                      'assets/images/barraOuro.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Aqui seu dinheiro",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.mochaChoco.copyWith(
                          color: AppColors.yellow,
                        ),
                      ),

                      Text(
                        "Vale ouro",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.mochaChoco.copyWith(
                          color: AppColors.yellow,
                        ),
                      ),

                      const SizedBox(height: 35),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/cadastrar',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Vamos começar!',
                          style: AppTextStyle.poppinblack.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}