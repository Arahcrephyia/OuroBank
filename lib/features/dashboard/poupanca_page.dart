import 'package:flutter/material.dart';

class PoupancaPage extends StatelessWidget {
  const PoupancaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1D22),
      appBar: AppBar(
        backgroundColor: const Color(0xff1F1D22),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xffD9B300),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                'assets/images/Mascot.png',
                height: 120,
              ),
              const SizedBox(height: 20),
              const Text(
                "Poupança OuroBank",
                style: TextStyle(
                  color: Color(0xffD9B300),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "o ourinho guardou tuas moedas",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 35),
              _info(
                "Saldo guardado",
                "R\$ 1,17",
                Icons.savings,
              ),
              const SizedBox(height: 18),
              _info(
                "Rendimento do mês",
                "+ R\$ 0,02",
                Icons.trending_up,
              ),
              const SizedBox(height: 18),
              _info(
                "Meta",
                "R\$ 500,00",
                Icons.flag,
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffD9B300),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  label: const Text(
                    "Guardar Dinheiro",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _info(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xffD9B300),
            size: 35,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xffD9B300),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
