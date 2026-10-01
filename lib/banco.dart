import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'historico.dart';

class BancoHelper {
  static final BancoHelper instancia = BancoHelper._interno();

  factory BancoHelper() => instancia;

  BancoHelper._interno();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _inicializarBanco();

    return _database!;
  }

  Future<Database> _inicializarBanco() async {
    String caminhoBanco = join(
      await getDatabasesPath(),
      'ourobank.db',
    );

    return await openDatabase(
      caminhoBanco,
      version: 1,
      onCreate: _criarTabelas,
    );
  }

  Future<void> _criarTabelas(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        email TEXT,
        senha TEXT,
        saldo REAL,
        limite REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE historico(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER,
        tipo TEXT,
        valor REAL,
        descricao TEXT
      )
    ''');
  }

  Future<int> cadastrarUsuario(
    Map<String, dynamic> usuario,
  ) async {
    final db = await database;

    return await db.insert(
      'usuarios',
      usuario,
    );
  }

  Future<bool> login(
    String email,
    String senha,
  ) async {
    final db = await database;

    List<Map<String, dynamic>> resultado = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [
        email,
        senha,
      ],
    );

    return resultado.isNotEmpty;
  }

  Future<Map<String, dynamic>?> buscarUsuario(
    String email,
    String senha,
  ) async {
    final db = await database;

    List<Map<String, dynamic>> resultado = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [
        email,
        senha,
      ],
    );

    if (resultado.isNotEmpty) {
      return resultado.first;
    }

    return null;
  }

  Future<Map<String, dynamic>?> buscarPorEmail(
    String email,
  ) async {
    final db = await database;

    List<Map<String, dynamic>> resultado = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (resultado.isNotEmpty) {
      return resultado.first;
    }

    return null;
  }

  Future<int> atualizarSaldo(
    int id,
    double novoSaldo,
  ) async {
    final db = await database;

    return await db.update(
      'usuarios',
      {
        'saldo': novoSaldo,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> atualizarLimite(
    int id,
    double novoLimite,
  ) async {
    final db = await database;

    return await db.update(
      'usuarios',
      {
        'limite': novoLimite,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> salvarHistorico(
    Historico historico,
  ) async {
    final db = await database;

    return await db.insert(
      'historico',
      historico.toMap(),
    );
  }

  Future<List<Historico>> listarHistorico(
    int usuarioId,
  ) async {
    final db = await database;

    final resultado = await db.query(
      'historico',
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
      orderBy: 'id DESC',
    );

    return resultado.map((map) {
      return Historico.fromMap(map);
    }).toList();
  }

  Future<int> limparHistorico(
    int usuarioId,
  ) async {
    final db = await database;

    return await db.delete(
      'historico',
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
    );
  }
}