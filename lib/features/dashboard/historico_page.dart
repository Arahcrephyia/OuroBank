import 'package:flutter/material.dart';
import 'package:ourobank_aplication/banco.dart';
import 'package:ourobank_aplication/historico.dart';

class HistoricoPage extends StatelessWidget {
  final int usuarioId;

  const HistoricoPage({
    super.key,
    required this.usuarioId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1D22),

      appBar: AppBar(
        backgroundColor: const Color(0xff1F1D22),
        elevation: 0,
        title: const Text(
          "Histórico",
          style: TextStyle(
            color: Color(0xffD9B300),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xffD9B300),
        ),
      ),

      body: FutureBuilder<List<Historico>>(
        future: BancoHelper.instancia.listarHistorico(usuarioId),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xffD9B300),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Erro ao carregar histórico",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }

          final historico = snapshot.data ?? [];

          if (historico.isEmpty) {
            return const Center(
              child: Text(
                "Nenhuma movimentação ainda",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: historico.length,

            itemBuilder: (context, index) {
              final item = historico[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.pix,
                      color: Color(0xffD9B300),
                      size: 35,
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.tipo,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            item.descricao,
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      "R\$ ${item.valor.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Color(0xffD9B300),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}