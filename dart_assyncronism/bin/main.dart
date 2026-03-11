import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
import '../lib/api_key.dart';

StreamController<String> streamController = StreamController<String>();
void main() {
  StreamSubscription streamSubscription = streamController.stream.listen((
    String info,
  ) {
    print(info);
  });
  requestData();
  requestDataAsync();
  sendDataAsync({
    "id": "NEW001",
    "name": "Marcos",
    "lastName": "Souza",
    "balance": 350,
  });
  requestLivros();
}

void requestData() {
  String url =
      "https://gist.githubusercontent.com/MVNSouza/6bfdfa496b5dae5a395c318ae9a4189d/raw/243aacc930bc646dfb8d597eb18145bedfe886e4/account.json";
  Future<Response> futureResponse = get(Uri.parse(url));
  futureResponse.then((Response response) {
    streamController.add(
      "${DateTime.now()} | Requisição de leitura (usando then)",
    );
  });
}

Future<List<dynamic>> requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/MVNSouza/6bfdfa496b5dae5a395c318ae9a4189d/raw/243aacc930bc646dfb8d597eb18145bedfe886e4/account.json";
  Response response = await get(Uri.parse(url));
  streamController.add("${DateTime.now()} | Requisição de leitura");
  return json.decode(response.body);
}

void requestLivros() async {
  String url =
      'https://raw.githubusercontent.com/alura-cursos/dart_assincronismo_api/aula05/.json/books.json';

  Response response = await get(Uri.parse(url));
  streamController.add("${DateTime.now()} | Requisição de leitura de livros");
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

  if (response.statusCode.toString()[0] == "2") {
    streamController.add(
      "${DateTime.now()} | Requisição de adição bem sucedida (${mapAccont["name"]})",
    );
  } else {
    streamController.add(
      "${DateTime.now()} | Requisição de adição falhou (${mapAccont["name"]})",
    );
  }
}
