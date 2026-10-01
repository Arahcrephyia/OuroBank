import 'package:flutter/material.dart';
import 'package:ourobank_aplication/commons/constants/app_colors.dart';
import 'package:ourobank_aplication/commons/constants/app_text.dart';
import 'package:ourobank_aplication/banco.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool up = false;

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 100),

      () {

        setState(() {
          up = true;
        });
      },
    );
  }
  @override
    void dispose() {
      nomeController.dispose();
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
                  "Faça o seu",
                  style: AppTextStyle.mochaChoco.copyWith(
                    color: AppColors.yellow,
                  ),
                ),

                Text(
                  "Cadastro",
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

                const SizedBox(height: 45),

                Form(
                  child: Column(
                    children: [
                      
                      CustomTextFormField(
                        controller: nomeController,
                        labelText: "Seu nome",
                        hintText: "Digite seu nome",
                        icon: Icons.person,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 12,
                        ),
                      ),

                      CustomTextFormField(
                        controller: emailController,
                        labelText: "Seu e-mail",
                        hintText: "Digite seu e-mail",
                        icon: Icons.email,
                        keyboardType:
                          
                          TextInputType.emailAddress,
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

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),

                    onPressed: () async {

                      String nome =
                          nomeController.text.trim();

                      String email =
                          emailController.text.trim();

                      String senha =
                          senhaController.text.trim();

                      if (
                          nome.isEmpty ||
                          email.isEmpty ||
                          senha.isEmpty
                      ) {

                        ScaffoldMessenger.of(context)
                            .showSnackBar(

                          const SnackBar(

                            content: Text(
                              'Preencha todos os campos!',
                            ),
                          ),
                        );
                        return;
                      }



                      final usuarioExistente =
                          await BancoHelper.instancia
                              .buscarPorEmail(email);

                              if (usuarioExistente != null) {

                        ScaffoldMessenger.of(context)
                            .showSnackBar(

                          const SnackBar(

                            content: Text(
                              'Esse e-mail já está cadastrado!',
                            ),
                          ),
                        );

                        return;
                      }

                      await BancoHelper.instancia
                          .cadastrarUsuario({
                        'nome': nome,
                        'email': email,
                        'senha': senha,


                        'saldo': 1000.0,
                        'limite': 500.0,
                      });

                      nomeController.clear();
                      emailController.clear();
                      senhaController.clear();

                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        const SnackBar(

                          content: Text(
                            'Cadastro realizado com sucesso!',
                          ),
                        ),
                      );

                      Navigator.pushReplacementNamed(
                        context,
                        '/login',
                      );
                    },

                    child: Text(
                      "Confirmar",
                      style: AppTextStyle.poppinblack.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                const Divider(
                  color: Colors.white24,
                ),

                const SizedBox(height: 25),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      '/login',
                    );
                  },

                  child: Text(
                    "Já possui conta? Fazer Login",

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
  State<CustomTextFormField> createState() =>
      _CustomTextFormFieldState();
}

class _CustomTextFormFieldState
    extends State<CustomTextFormField> {

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
        obscureText:
            widget.isPassword ? obscurePassword : false,

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
                      obscurePassword =
                          !obscurePassword;
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