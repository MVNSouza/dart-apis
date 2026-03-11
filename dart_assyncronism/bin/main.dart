import 'package:http/http.dart';
import 'dart:convert';

void main() {
  print('Hello, World!');
  requestLivros();
}

void requestData() {
  String url =
      "https://gist.githubusercontent.com/MVNSouza/6bfdfa496b5dae5a395c318ae9a4189d/raw/803ff5bcdf8e57f2effcc26f91d4dbc227bf6cc0/gistfile1.txt";
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

void requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/MVNSouza/6bfdfa496b5dae5a395c318ae9a4189d/raw/803ff5bcdf8e57f2effcc26f91d4dbc227bf6cc0/gistfile1.txt";
  Response response = await get(Uri.parse(url));
  List<dynamic> listResponse = json.decode(response.body);
  List<String> nomeSelecionados = [];
  for (dynamic pessoa in listResponse) {
    Map<String, dynamic> selecionada = pessoa as Map<String, dynamic>;
    if (selecionada["balance"] <= 200) {
      nomeSelecionados.add(selecionada["name"]);
    }
  }

  print(nomeSelecionados);
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
