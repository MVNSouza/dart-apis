import 'package:dart_assyncronism/screens/account_screen.dart';

void main() {
  AccountScreen accountScreen = AccountScreen();

  accountScreen.initializeSteam();
  accountScreen.runChatBot();
}
