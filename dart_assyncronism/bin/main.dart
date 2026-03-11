import 'package:http/http.dart';
import 'dart:convert';
import '../lib/api_key.dart';

void main() {
  print('Hello, World!');
  sendDataAsync({
    "id": "NEW001",
    "name": "Marcos",
    "lastName": "Souza",
    "balance": 350,
  });
  //requestLivros();
}

void requestData() {
  String url =
      "https://gist.githubusercontent.com/MVNSouza/6bfdfa496b5dae5a395c318ae9a4189d/raw/243aacc930bc646dfb8d597eb18145bedfe886e4/account.json";
  Future<Response> futureResponse = get(Uri.parse(url));
  futureResponse.then((Response response) {
    print(response);
    print(response.body);

    List<dynamic> listRecipes = json.decode(response.body);
    Map<String, dynamic> mapCarla = listRecipes.firstWhere(
      (element) => element["name"] == "Carla",
    );
    print(mapCarla["balance"]);
  });

  print(
    'Última coisa a acontecer',
  ); //Não é a última coisa a acontecer em tempo de execução
}

Future<List<dynamic>> requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/MVNSouza/6bfdfa496b5dae5a395c318ae9a4189d/raw/243aacc930bc646dfb8d597eb18145bedfe886e4/account.json";
  Response response = await get(Uri.parse(url));
  return json.decode(response.body);
}

void requestLivros() async {
  String url =
      'https://raw.githubusercontent.com/alura-cursos/dart_assincronismo_api/aula05/.json/books.json';

  Response response = await get(Uri.parse(url));
  List<dynamic> listResponse = json.decode(response.body);
  for (dynamic livro in listResponse) {
    Map<String, dynamic> atual = livro as Map<String, dynamic>;
    if (atual["author"] == "Jorge Amado") {
      print(atual["title"]);
    }
  }
}

void sendDataAsync(Map<String, dynamic> mapAccont) async {
  List<dynamic> listAcconts = await requestDataAsync();
  listAcconts.add(mapAccont);
  String content = json.encode(listAcconts);

  String url = "https://api.github.com/gists/6bfdfa496b5dae5a395c318ae9a4189d";
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
  print(response.statusCode);
}
