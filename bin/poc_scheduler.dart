import 'dart:async';
import 'package:pedantic/pedantic.dart';
import 'functions.dart';
import 'scheduler.dart';

Future<void> main() async {
  await exampleScheduler3();
}

//Choose one from the examples below to run in the main function.

final firstOrder = '1st order - 1L Bottle';
final bigDuration = 10;

final secondOrder = '2nd order - 500mL glass';
final mediumDuration = 5;

final thirdOrder = '3rd order - 200mL cup';
final shortDuration = 2;

Future<void> exampleScheduler1() async {
  //this example runs as a FIFO.
  await orderLatte(hint: firstOrder, duration: bigDuration);
  await orderLatte(hint: secondOrder, duration: mediumDuration);
  await orderLatte(hint:thirdOrder, duration: shortDuration);
}

void exampleScheduler2() {
  //this example synchronously.
  //The shortDuration order will arrive first, since they all are asked at
  //the same time.
  unawaited(orderLatte(hint: firstOrder, duration: bigDuration));
  unawaited(orderLatte(hint: secondOrder, duration: mediumDuration));
  unawaited(orderLatte(hint: thirdOrder, duration: shortDuration));
}

Future<void> exampleScheduler3() async {
  final latteScheduler = Scheduler();
  // controller.stream.listen((event) async { await event.call();});
  Future orderA() async => await orderLatte(hint: firstOrder, duration: bigDuration);
  Future orderB() async => await orderLatte(hint: secondOrder, duration: mediumDuration);
  Future orderC() async => await orderLatte(hint: thirdOrder, duration: shortDuration);
  latteScheduler.schedule(orderA);
  latteScheduler.schedule(orderB);
  latteScheduler.schedule(orderC);
}

