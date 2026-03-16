import 'dart:io';
import 'package:dart_assyncronism/services/account_service.dart';
import 'package:dart_assyncronism/models/account.dart';

class AccountScreen {
  final AccountService _accountService = AccountService();

  void initializeSteam() {}

  void runChatBot() async {
    print("Bom dia! Eu sou o Lewis, assistente do Banco d'Ouro!");
    print("Que bom te ter aqui com a gente.");

    bool isRunning = true;
    while (isRunning) {
      print("Como posso te ajudar? (Digite o número desejado)");
      print("1 - Ver todas as contas");
      print("2 - Adicionar nova conta");
      print("3 - Sair\n");

      String? input = stdin.readLineSync();
      if (input != null) {
        switch (input) {
          case "1":
            {
              _getAllAccounts();
              break;
            }
          case "2":
            {
              _addExampleAccount();
              break;
            }
          case "3":
            {
              isRunning = false;
              print("Te vejo na próxima!");
              break;
            }
          default:
            {
              print("Não entendi. Tente novamente");
            }
        }
      }
    }
  }

  _getAllAccounts() async {
    List<Account> listAccounts = await _accountService.getAll();
  }

  _addExampleAccount() async {
    Account example = Account(
      id: "ID555",
      name: "Haley",
      lastName: "Chirivia",
      balance: 8001,
    );

    _accountService.addAccount(example);
  }
}
