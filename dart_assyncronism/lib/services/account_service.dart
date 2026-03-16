import 'dart:async';
import 'package:dart_assyncronism/models/account.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:dart_assyncronism/api_key.dart';

class AccountService {
  final StreamController<String> _streamController = StreamController<String>();
  Stream<String> get streamInfos => _streamController.stream;

  // Url da API
  String url = "https://api.github.com/gists/6bfdfa496b5dae5a395c318ae9a4189d";

  Future<List<Account>> getAll() async {
    Response response = await get(Uri.parse(url));
    _streamController.add("${DateTime.now()} | Requisição de leitura");

    Map<String, dynamic> mapResponse = json.decode(response.body);
    List<dynamic> listDynamic = json.decode(
      mapResponse["files"]["account.json"]["content"],
    );
    List<Account> listAccounts = [];

    for (dynamic dyn in listDynamic) {
      Map<String, dynamic> mapAccount = dyn as Map<String, dynamic>;
      Account account = Account.fromMap(mapAccount);
      listAccounts.add(account);
    }

    return listAccounts;
  }

  void addAccount(Account account) async {
    List<Account> listAcconts = await getAll();
    listAcconts.add(account);

    List<Map<String, dynamic>> listContent = [];
    for (Account account in listAcconts) {
      listContent.add(account.toMap());
    }

    String content = json.encode(listContent);

    Response response = await post(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $githubApiKey"},
      body: json.encode({
        "description": "account.json",
        "public": true,
        "files": {
          "account.json": {"content": content},
        },
      }),
    );

    if (response.statusCode.toString()[0] == "2") {
      _streamController.add(
        "${DateTime.now()} | Requisição de adição bem sucedida (${account.name})",
      );
    } else {
      _streamController.add(
        "${DateTime.now()} | Requisição de adição falhou (${account.name})",
      );
    }
  }

  Future<Account> getAccountById(String id) async {
    List<Account> listAccount = await getAll();

    for (Account account in listAccount) {
      if (account.id == id) {
        _streamController.add(
          "${DateTime.now()} | Requisição de busca bem sucedida (${account.name})",
        );
        return account;
      }
    }
    _streamController.add(
      "${DateTime.now()} | Requisição de busca falhou. ID não encontrado.",
    );
    return Account(id: "", name: "", lastName: "", balance: 0.0);
  }
}
