import 'package:flutter/material.dart';
import 'app.dart';

import 'banco.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await BancoHelper.instancia.database;

  runApp(
    const App());
}