# OuroBank

Aplicativo móvel de **banco digital fictício** desenvolvido em Flutter. Reúne saldo, transferências (Pix e cartão de crédito), histórico, poupança e cotação de moedas e Bitcoin em uma única interface.

> Projeto acadêmico usado como estudo de caso na atividade de **Revisão Arquitetural** da disciplina de Arquitetura de Software e Computação em Nuvem (UNAMA).

## Integrantes

| Nome | Matrícula |
|---|---|
| Eduarda Yohana Reis Farias | 04181866 |
| Safira Sales Silva Barreto | 04177290 |
| Lucas Arthur Silva Farias | 04187948 |
| Hugo Gabriel Alencar Da Silva | 04186328 |

## Funcionalidades

- Splash e onboarding
- Cadastro (conta criada com saldo de R$ 1.000,00 e limite de R$ 500,00)
- Login por e-mail/senha ou biometria
- Recuperação de senha (apenas interface)
- Dashboard com saldo, limite e fatura
- Transferência por **Pix** (debita saldo) ou **cartão** (debita limite)
- Histórico de transações
- Poupança
- Conversor de cotação (dólar, euro e Bitcoin) com compartilhamento

## Tecnologias e dependências

| Tecnologia | Uso |
|---|---|
| Flutter / Dart (SDK ^3.11.5) | Aplicativo móvel |
| `sqflite` + `path` | Banco SQLite local (`ourobank.db`) |
| `shared_preferences` | Preferências locais (biometria, e-mail salvo) |
| `local_auth` | Autenticação biométrica |
| `http` | Consumo da API HG Brasil Finance (cotações) |
| `share_plus` | Compartilhamento de cotações |
| `cupertino_icons` | Ícones |

## Como executar

Pré-requisitos: [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e um emulador ou dispositivo Android/iOS.

```bash
cd ourobank_aplication
flutter pub get
flutter run
```

Para gerar o APK: `flutter build apk`.

> A tela de cotação precisa de internet (API HG Brasil). O restante funciona offline.

## Organização atual do sistema

```
lib/
 ├─ main.dart              Inicializa o banco e executa o app
 ├─ app.dart               MaterialApp, rotas nomeadas e tema
 ├─ banco.dart             BancoHelper (singleton SQLite): esquema e CRUD
 ├─ historico.dart         Modelo Historico
 ├─ commons/constants/     AppColors, AppText
 └─ features/
     ├─ splash/  onboarding/  sign_in/  sign_up/  forgetting/
     ├─ dashboard/         dashboard, payment, historico, poupanca
     └─ convert/           cotação e conversor
```

**Dados:** SQLite com as tabelas `usuarios` (id, nome, email, senha, saldo, limite) e `historico` (id, usuario_id, tipo, valor, descricao).
**Integrações:** API HG Brasil Finance, biometria do aparelho e compartilhamento do sistema.

## Evolução arquitetural proposta

Separar as regras de negócio das telas em camadas **Apresentação → Serviços → Repositórios → Fontes de dados**, com modelos tipados, transferência atômica e senhas com hash. A análise completa, o diagrama e os trade-offs estão no relatório da atividade.

```
features/ (telas)  →  services/ (Auth, Transfer, Cotacao)  →  data/repositories/  →  SQLite · SharedPreferences · API HG Brasil
```
