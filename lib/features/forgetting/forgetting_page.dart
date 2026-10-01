import 'package:flutter/material.dart';

class ForgettingPage extends StatelessWidget {
  const ForgettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1D22),
      appBar: AppBar(
        backgroundColor: const Color(0xff1F1D22),
        elevation: 0,

        leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Color(0xffD9B300),
        ),

    onPressed: () {

      Navigator.pushReplacementNamed(
        context,
        '/login',
      );

    },
  ),
),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              
              const SizedBox(height: 20),
              
              Image.asset(
                'assets/images/Mascot.png',
                height: 130,
              ),

              const SizedBox(height: 25),
              
              const Text(
                "Esqueceu foi?",
                style: TextStyle(
                  color: Color(0xffD9B300),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),
              
              const Text(
                "Relaxa,\no ourinho vai buscar sua senha",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),
              
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration: InputDecoration(
                  hintText: "Digite usuário ou email",
                  hintStyle: const TextStyle(
                    color: Colors.white54,
                  ),

                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color(0xffD9B300),
                  ),

                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffD9B300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "O ourinho foi atrás da sua senha 😉",
                        ),
                      ),
                    );
                  },
                  
                  child: const Text(
                    "Recuperar",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
