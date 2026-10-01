import 'package:flutter/material.dart';
import 'package:ourobank_aplication/historico.dart';
import 'package:ourobank_aplication/features/dashboard/historico_page.dart';
import 'package:ourobank_aplication/banco.dart';

class PaymentPage extends StatefulWidget {

  final Map<String, dynamic> usuario;

  const PaymentPage({
    super.key,
    required this.usuario,
  });

  @override
  State<PaymentPage> createState() =>
      _PaymentPageState();
}

class _PaymentPageState
    extends State<PaymentPage> {

  final emailController =
      TextEditingController();

  final valorController =
      TextEditingController();

  late double saldo;
  late double limite;


  String metodoSelecionado = 'pix';

  @override
  void initState() {

    super.initState();

    saldo = widget.usuario['saldo'] ?? 1000.0;
    limite = widget.usuario['limite'] ?? 500.0;
  }
  
  @override
  void dispose() {
    emailController.dispose();
    valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff1F1D22),
      
      appBar: AppBar(
        backgroundColor:
            const Color(0xff1F1D22),

            leading: IconButton(

              icon: const Icon(
              Icons.arrow_back,
              color: Color(0xffD9B300),
          ),

          onPressed: () =>
              Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(

            children: [


              Container(              
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius:
                      BorderRadius.circular(15),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Saldo disponível",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "R\$ ${saldo.toStringAsFixed(2)}",

                      style: const TextStyle(
                        color: Color(0xffD9B300),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),


              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
        
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius:
                      BorderRadius.circular(15),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Limite do cartão",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "R\$ ${limite.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Color(0xffD9B300),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),


              TextField(

                controller: emailController,
                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration: InputDecoration(
                  hintText:
                      "E-mail destinatário",

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

                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 20),


              TextField(
                controller: valorController,
                keyboardType:
                    TextInputType.number,

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration: InputDecoration(
                  hintText:
                      "Valor da transferência",

                  hintStyle: const TextStyle(
                    color: Colors.white54,
                  ),

                  prefixIcon: const Icon(
                    Icons.attach_money,
                    color: Color(0xffD9B300),
                  ),

                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(

                  style:
                      ElevatedButton.styleFrom(
                      backgroundColor:
                        const Color(0xffD9B300),
                  ),

                  onPressed: () async {
                    String email =
                        emailController.text.trim();

                    double valor =
                        double.tryParse(
                              valorController.text,
                            ) ??
                            0;

                    if (
                        email.isEmpty ||
                        valor <= 0
                    ) {

                      ScaffoldMessenger.of(context)
                        .showSnackBar(
                          const SnackBar(
                            content: Text(
                            'Preencha os campos corretamente!',
                          ),
                        ),
                      );

                      return;
                    }
                   

                    if (
                        metodoSelecionado == 'pix'
                            ? valor > saldo
                            : valor > limite
                    ) {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                            const SnackBar(
                              content: Text(
                            'Saldo/Limite insuficiente!',
                          ),
                        ),
                      );

                      return;
                    }


                    final destinatario =
                        await BancoHelper.instancia
                            .buscarPorEmail(email);

                    if (destinatario == null) {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        const SnackBar(

                          content: Text(
                            'Usuário não encontrado!',
                          ),
                        ),
                      );

                      return;
                    }
                    if (destinatario['id'] == widget.usuario['id']) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Você não pode transferir para si mesmo!',
                            ),
                          ),
                       );

                      return;
                    }

                    double novoSaldoRemetente =
                        saldo;

                    double novoLimite =
                        limite;

                    if (
                        metodoSelecionado == 'pix'
                    ) {

                      novoSaldoRemetente =
                          saldo - valor;

                    } else {

                      novoLimite =
                          limite - valor;
                    }

                    double novoSaldoDestinatario =
                        destinatario['saldo'] +
                            valor;
                    await BancoHelper.instancia.atualizarSaldo(
                    destinatario['id'],
                    novoSaldoDestinatario,
                    );


                    await BancoHelper.instancia
                        .atualizarSaldo(
                      widget.usuario['id'],
                      novoSaldoRemetente,
                    );

                    await BancoHelper.instancia
                        .atualizarLimite(
                      widget.usuario['id'],
                      novoLimite,
                    );


                    await BancoHelper.instancia.salvarHistorico(
                        Historico(
                          usuarioId: widget.usuario['id'],
                          tipo: metodoSelecionado == 'pix' ? 'Pix' : 'Cartão',
                          valor: valor,
                          descricao: 'Transferência para $email',
                          ),
                        );


                    setState(() {
                      saldo =
                          novoSaldoRemetente;

                      limite =
                          novoLimite;
                    });


                    emailController.clear();
                    valorController.clear();


                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      SnackBar(
                        content: Text(
                          'Transferência de R\$ ${valor.toStringAsFixed(2)} realizada!',
                        ),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.pix,
                    color: Colors.black,
                  ),

                  label: const Text(
                    "Transferir",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),


              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HistoricoPage(
                          usuarioId: widget.usuario['id'],
                        ),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.history,
                    color: Color(0xffD9B300),
                  ),
                  label: const Text(
                    "Ver Histórico",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(

                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,

                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        metodoSelecionado =
                            'pix';
                      });
                    },

                    child: _box(
                      "Pix",
                      Icons.pix,
                      metodoSelecionado ==
                        'pix',
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        metodoSelecionado =
                         'cartao';
                      });
                    },

                    child: _box(
                      "Cartão",
                      Icons.credit_card,
                      metodoSelecionado ==
                        'cartao',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _box(
    String text,
    IconData icon,
    bool selecionado,
  ) {

    return AnimatedContainer(

      duration: const Duration(
        milliseconds: 200,
      ),

      width: 140,
      height: 160,

      decoration: BoxDecoration(

        color: selecionado
            ? const Color(0xff2B2B2B)
            : Colors.transparent,

        border: Border.all(

          color: selecionado
              ? const Color(0xffD9B300)
              : Colors.white24,

          width: 2,
        ),

        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Text(
            text,
            style: TextStyle(
              color: selecionado
                  ? const Color(0xffD9B300)
                  : Colors.white,

              fontSize: 22,
            ),
          ),

          const SizedBox(height: 18),

          Icon(
            icon,
            color: selecionado
                ? const Color(0xffD9B300)
                : Colors.white54,

            size: 60,
          ),
        ],
      ),
    );
  }
}

