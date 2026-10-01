import 'package:flutter/material.dart';
import 'package:ourobank_aplication/banco.dart';
import 'package:ourobank_aplication/features/convert/convert_page.dart';
import 'package:ourobank_aplication/features/dashboard/payment_page.dart';
import 'package:ourobank_aplication/features/dashboard/poupanca_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Map<String, dynamic> usuario;

bool usuarioCarregado = false;

@override
void didChangeDependencies() {
  super.didChangeDependencies();

  if (!usuarioCarregado) {
    usuario =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    usuarioCarregado = true;
  }
}

  Future<void> carregarUsuario() async {
    final usuarioAtualizado =
        await BancoHelper.instancia.buscarPorEmail(usuario['email']);

    if (usuarioAtualizado != null) {
      setState(() {
        usuario = usuarioAtualizado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1D22),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/login',
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Color(0xffD9B300),
            ),
          ),
        ],
        backgroundColor: const Color(0xff1F1D22),
        elevation: 0,
        leading: const Icon(
          Icons.account_circle,
          color: Color(0xffD9B300),
          size: 35,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Olá, ${usuario['nome']}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xffB08C00),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Saldo",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "R\$ ${(double.tryParse(usuario['saldo'].toString()) ?? 0.0).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffD9B300),
                        ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentPage(
                                usuario: usuario,
                              ),
                            ),
                          );

                          await carregarUsuario();
                        },
                        icon: const Icon(Icons.qr_code),
                        label: const Text(
                          "Pagar",
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _card(
                    "Poupança",
                    Icons.savings,
                    const PoupancaPage(),
                    context,
                  ),
                  _card(
                    "Cotação",
                    Icons.attach_money,
                    const ConvertPage(),
                    context,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Divider(
                color: Color(0xffD9B300),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Cartão de crédito",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Fatura atual",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "R\$ 0,00",
                      style: TextStyle(
                        color: Color(0xffD9B300),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Limite disponível de R\$ ${(double.tryParse(usuario['limite'].toString()) ?? 0.0).toStringAsFixed(2)}", 
                                style: const TextStyle(
                                  color: Colors.white,
                                  ),
                                ),
                              SizedBox(height: 8),
                              Text(
                                "Débito automático ativado",
                                style: TextStyle(
                                  color: Color(0xffD9B300),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/Mascot.png',
                          height: 85,
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        minimumSize: const Size(double.infinity, 55),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.credit_card,
                        color: Color(0xffD9B300),
                      ),
                      label: const Text(
                        "Meus Cartõesinhos",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _card(
    String text,
    IconData icon,
    Widget? page,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: page == null
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => page,
                ),
              );
            },
      child: Container(
        width: 140,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 35,
              color: const Color(0xffD9B300),
            ),
            const SizedBox(height: 12),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
