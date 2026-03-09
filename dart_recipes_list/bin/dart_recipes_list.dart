import 'package:http/http.dart';

void main() {
  print('Lista de receitas');
  requestReceitas();
}

void requestReceitas() {
  String url =
      "https://gist.githubusercontent.com/MVNSouza/694d6b2ab905d122592b0e29c35f0215/raw/d776aab3dd0b32fe17618cdd4342d296d193e249/recipes.json";
  Future<Response> futureReceitas = get(Uri.parse(url));
  futureReceitas.then((value) {
    print(value.body);
  });
}
