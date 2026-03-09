import 'package:http/http.dart';

void main() {
  print('Hello, World!');
  requestData();
}

void requestData() {
  String url =
      "https://gist.githubusercontent.com/MVNSouza/6bfdfa496b5dae5a395c318ae9a4189d/raw/803ff5bcdf8e57f2effcc26f91d4dbc227bf6cc0/gistfile1.txt";
  Future<Response> futureResponse = get(Uri.parse(url));
  futureResponse.then((value) {
    print(value);
    print(value.body);
  });
}
