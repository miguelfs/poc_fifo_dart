import 'dart:async';
import 'package:pedantic/pedantic.dart';
import 'functions.dart';

Future<void> main() async {
  await exampleStream3();
}

//Choose one from the examples below to run in the main function.

final firstOrder = '1st order - 1L Bottle';
final bigDuration = 10;

final secondOrder = '2nd order - 500mL glass';
final mediumDuration = 5;

final thirdOrder = '3rd order - 200mL cup';
final shortDuration = 2;

Future<void> exampleStream1() async {
  //this example runs as a FIFO.
  await orderLatte(hint: firstOrder, duration: bigDuration);
  await orderLatte(hint: secondOrder, duration: mediumDuration);
  await orderLatte(hint:thirdOrder, duration: shortDuration);
}

void exampleStream2() {
  //this example synchronously.
  //The shortDuration order will arrive first, since they all are asked at
  //the same time.
  unawaited(orderLatte(hint: firstOrder, duration: bigDuration));
  unawaited(orderLatte(hint: secondOrder, duration: mediumDuration));
  unawaited(orderLatte(hint: thirdOrder, duration: shortDuration));
}

Future<void> exampleStream3() async {
  final controller = StreamController<Function>();

  controller.stream.listen((event) async {
    print('just a second...');
    await Future.delayed(Duration(seconds: 1));
    print('here we go:');
    await event.call();
  });

  Future<String> orderA() async => await orderLatte(hint: firstOrder, duration: bigDuration);
  Future<String> orderB() async => await orderLatte(hint: secondOrder, duration: mediumDuration);
  Future<String> orderC() async => await orderLatte(hint: thirdOrder, duration: shortDuration);
  controller.add(()=>orderA());
  controller.add(()=>orderB());
  controller.add(()=>orderC());
  await Future.delayed(Duration(seconds: 2));
  print('this is a test, to check when the orders are ordered.');
}

