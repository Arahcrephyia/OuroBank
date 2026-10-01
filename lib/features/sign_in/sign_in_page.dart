import 'package:flutter/material.dart';
import 'package:ourobank_aplication/commons/constants/app_colors.dart';
import 'package:ourobank_aplication/commons/constants/app_text.dart';
import 'package:ourobank_aplication/banco.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool up = false;
  bool biometriaLiberada = false;

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    verificarBiometriaLiberada();

    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        setState(() {
          up = true;
        });
      },
    );
  }

  Future<void> verificarBiometriaLiberada() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      biometriaLiberada = prefs.getBool('biometriaLiberada') ?? false;
    });
  }

  Future<void> autenticarComBiometria() async {
    final LocalAuthentication auth = LocalAuthentication();

    try {
      bool autenticado = await auth.authenticate(
        localizedReason: 'Use sua biometria ou senha do celular para entrar',
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );

      if (autenticado) {
        final prefs = await SharedPreferences.getInstance();

        final emailSalvo = prefs.getString('email');

        if (emailSalvo == null || emailSalvo.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Faça login com e-mail e senha primeiro.'),
            ),
          );
          return;
        }

        final usuario = await BancoHelper.instancia.buscarPorEmail(emailSalvo);

        if (usuario != null) {
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: usuario,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuário não encontrado. Faça login novamente.'),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao tentar autenticar: $e'),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                const SizedBox(height: 10),

                AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  transform: Matrix4.translationValues(
                    0,
                    up ? -8 : 8,
                    0,
                  ),
                  child: Image.asset(
                    'assets/images/Mascot.png',
                    height: 120,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Entre na sua",
                  style: AppTextStyle.mochaChoco.copyWith(
                    color: AppColors.yellow,
                  ),
                ),

                Text(
                  "Conta",
                  style: AppTextStyle.mochaChoco.copyWith(
                    color: AppColors.yellow,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Seu ouro, sua segurança",
                  style: AppTextStyle.smallText.copyWith(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 20),

                Form(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: emailController,
                        labelText: "Seu e-mail",
                        hintText: "Digite seu e-mail",
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 12,
                        ),
                      ),

                      CustomTextFormField(
                        controller: senhaController,
                        labelText: "Sua senha",
                        hintText: "Digite sua senha",
                        icon: Icons.lock,
                        isPassword: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/esqueciSenha',
                      );
                    },
                    child: Text(
                      "Esqueci minha senha",
                      style: AppTextStyle.smallText.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),

                if (biometriaLiberada) ...[
                  const SizedBox(height: 15),

                  IconButton(
                    onPressed: autenticarComBiometria,
                    icon: const Icon(
                      Icons.fingerprint,
                      color: AppColors.yellow,
                      size: 45,
                    ),
                  ),

                  Text(
                    'Entrar com biometria',
                    style: AppTextStyle.smallText.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      String email = emailController.text.trim();
                      String senha = senhaController.text.trim();

                      if (email.isEmpty || senha.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Preencha todos os campos!'),
                          ),
                        );
                        return;
                      }

                      final usuario = await BancoHelper.instancia.buscarUsuario(
                        email,
                        senha,
                      );

                      if (usuario != null) {
                        final prefs = await SharedPreferences.getInstance();

                        await prefs.setBool('biometriaLiberada', true);
                        await prefs.setString(
                          'email',
                          usuario['email'].toString(),
                        );

                        emailController.clear();
                        senhaController.clear();

                        Navigator.pushReplacementNamed(
                          context,
                          '/home',
                          arguments: usuario,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Email ou senha inválidos'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Entrar",
                      style: AppTextStyle.poppinblack.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const Divider(
                  color: Colors.white24,
                ),

                const SizedBox(height: 25),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      '/cadastrar',
                    );
                  },
                  child: Text(
                    "Ainda não tem uma conta?\n Cadastre-se",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.smallText.copyWith(
                      color: AppColors.yellow,
                    ),
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

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final IconData icon;
  final EdgeInsetsGeometry padding;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextFormField({
    super.key,
    this.controller,
    required this.labelText,
    required this.hintText,
    required this.icon,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    ),
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscurePassword = true;

  final defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? obscurePassword : false,
        obscuringCharacter: "*",
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.white54,
          ),
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.yellow,
          ),
          filled: true,
          fillColor: Colors.grey[850],
          border: defaultBorder,
          focusedBorder: defaultBorder.copyWith(
            borderSide: const BorderSide(
              color: Colors.yellow,
            ),
          ),
          errorBorder: defaultBorder,
          focusedErrorBorder: defaultBorder,
          enabledBorder: defaultBorder,
          disabledBorder: defaultBorder,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}