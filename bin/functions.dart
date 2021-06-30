Future<String> printOrderMessage(hint, duration) async {
  print('Awaiting user order...');
  var order = await fetchUserOrder(hint, duration);
  print('Your order is: $order');
  return '$order :)';
}

Future<String> fetchUserOrder(hint, duration) {
  return Future.delayed(Duration(seconds: duration), () => '$hint. Have a nice meal.');
}


Future<String> orderLatte({required String hint, required int duration})  {
  return Future((){
    countSeconds(hint, duration);
    return printOrderMessage(hint, duration);
  });
}

void countSeconds(String hint, int s) {
  for (var i = 1; i <= s; i++) {
    Future.delayed(Duration(seconds: i), () => print('$hint: $i/$s'));
  }
}