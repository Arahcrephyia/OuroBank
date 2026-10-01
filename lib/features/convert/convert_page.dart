import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ourobank_aplication/commons/constants/app_colors.dart';
import 'package:share_plus/share_plus.dart';

class ConvertPage extends StatefulWidget {
  const ConvertPage({super.key});

  @override
  State<ConvertPage> createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final bitcoinController = TextEditingController();


  double dolar = 0.0;
  double euro = 0.0;
  double bitcoin = 0.0;


  void compartilhar() {
    String mensagem =
        'Conversão atual:\n\n'
        'Real: R\$ ${realController.text}\n'
        'Dólar: US\$ ${dolarController.text}\n'
        'Euro: € ${euroController.text}\n'
        'Bitcoin: BTC ${bitcoinController.text}';

    SharePlus.instance.share(
      ShareParams(
        text: mensagem,
      ),
    );
  }

  Future<Map> getData() async {
    var url = Uri.parse(
      'https://api.hgbrasil.com/finance?format=json-cors&key=dc96f366',
    );

    http.Response response = await http.get(url);

    return json.decode(response.body);
  }

  void _realChanged(String text) {
    if (text.isEmpty) {

      realController.clear();
      dolarController.clear();
      euroController.clear();
      bitcoinController.clear();

      return;
    }

    double real = double.parse(text);

    dolarController.text =
        (real / dolar).toStringAsFixed(2);

    euroController.text =
        (real / euro).toStringAsFixed(2);

    bitcoinController.text =
        (real / bitcoin).toStringAsFixed(6);
  }


  void _dolarChanged(String text) {

    if (text.isEmpty) {

      realController.clear();
      dolarController.clear();
      euroController.clear();
      bitcoinController.clear();

      return;
    }

    double dolarDigitado = double.parse(text);

    realController.text =
        (dolarDigitado * dolar).toStringAsFixed(2);

    euroController.text =
        (dolarDigitado * dolar / euro)
            .toStringAsFixed(2);

    bitcoinController.text =
        ((dolarDigitado * dolar) / bitcoin)
            .toStringAsFixed(6);
  }

  void _euroChanged(String text) {

    if (text.isEmpty) {

      realController.clear();
      dolarController.clear();
      euroController.clear();
      bitcoinController.clear();

      return;
    }

    double euroDigitado = double.parse(text);

    realController.text =
        (euroDigitado * euro).toStringAsFixed(2);

    dolarController.text =
        (euroDigitado * euro / dolar)
            .toStringAsFixed(2);

    bitcoinController.text =
        ((euroDigitado * euro) / bitcoin)
            .toStringAsFixed(6);
  }

  void _bitcoinChanged(String text) {

    if (text.isEmpty) {

      realController.clear();
      dolarController.clear();
      euroController.clear();
      bitcoinController.clear();

      return;
    }

    double bitcoinDigitado = double.parse(text);

    realController.text =
        (bitcoinDigitado * bitcoin).toStringAsFixed(2);

    dolarController.text =
        ((bitcoinDigitado * bitcoin) / dolar)
            .toStringAsFixed(2);

    euroController.text =
        ((bitcoinDigitado * bitcoin) / euro)
            .toStringAsFixed(2);
  }

  @override
    void dispose() {
      realController.dispose();
      dolarController.dispose();
      euroController.dispose();
      bitcoinController.dispose();
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff1F1D22),

      appBar: AppBar(
        backgroundColor: const Color(0xff1F1D22),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xffD9B300),
        ),

        title: const Text(
          "Cotação OuroBank",
          style: TextStyle(
            color: Color(0xffD9B300),
          ),
        ),
      ),

      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {

            case ConnectionState.none:
            case ConnectionState.waiting:

              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xffD9B300),
                ),
              );

            default:

              if (snapshot.hasError) {

                return const Center(

                  child: Text(
                    "Erro ao carregar dados",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                );

              } else {
                dolar = snapshot.data!["results"]
                    ["currencies"]["USD"]["buy"];

                euro = snapshot.data!["results"]
                    ["currencies"]["EUR"]["buy"];

                bitcoin = snapshot.data!["results"]
                    ["currencies"]["BTC"]["buy"];

                return SingleChildScrollView(
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
                          "Cotação OuroBank",
                          style: TextStyle(
                            color: Color(0xffD9B300),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "o ourinho ta analisando o mercado",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 20),

                        campoTexto(
                          "Reais",
                          "R\$ ",

                          Icons.attach_money,
                          realController,
                          _realChanged,
                        ),

                        const SizedBox(height: 18),

                        campoTexto(
                          "Dólar",
                          "US\$ ",

                          Icons.attach_money,
                          dolarController,
                          _dolarChanged,
                        ),

                        const SizedBox(height: 18),

                        campoTexto(
                          "Euro",
                          "€ ",

                          Icons.euro,
                          euroController,
                          _euroChanged,
                        ),

                        const SizedBox(height: 18),


                        campoTexto(
                          "Bitcoin",
                          "BTC ",

                          Icons.currency_bitcoin,
                          bitcoinController,
                          _bitcoinChanged,
                        ),

                        const SizedBox(height: 20),

                        Row(

                          children: [
                            Expanded(

                              child: ElevatedButton(

                                onPressed: () {

                                  realController.clear();
                                  dolarController.clear();
                                  euroController.clear();
                                  bitcoinController.clear();

                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xffD9B300),

                                  padding:
                                      const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),

                                  shape: RoundedRectangleBorder(

                                    borderRadius:
                                        BorderRadius.circular(14),
                                  ),
                                ),

                                child: const Text(
                                  "Limpar",

                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 15),

                            Expanded(

                              child: ElevatedButton(
                                onPressed: () {
                                  compartilhar();
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.white,

                                  padding:
                                      const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),

                                  shape: RoundedRectangleBorder(

                                    borderRadius:
                                        BorderRadius.circular(14),
                                  ),
                                ),

                                child: const Text(
                                  "Compartilhar",

                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }

  Widget campoTexto(

    String label,
    String prefix,
    IconData icon,

    TextEditingController controller,

    Function(String) onChanged,
  ) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[850],

        borderRadius: BorderRadius.circular(14),
      ),

      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),

        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),

        onChanged: onChanged,

        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white70,
          ),

          prefixText: prefix,
          prefixStyle: const TextStyle(
            color: Color(0xffD9B300),
            fontSize: 20,
          ),

          icon: Icon(
            icon,
            color: const Color(0xffD9B300),
            size: 24,
          ),
        ),
      ),
    );
  }
}