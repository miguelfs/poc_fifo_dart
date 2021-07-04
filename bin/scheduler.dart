import 'dart:async';
import 'dart:collection';

// source: https://stackoverflow.com/questions/55582540/how-to-run-multiple-async-functions-in-order-they-were-called-fifo
class Scheduler {
  bool _scheduled = false;

  final Queue<Future Function()> _queue = Queue<Future Function()>();

  Future<void> schedule(Future Function() task) async {
    _queue.add(task);
    if (!_scheduled) {
      _scheduled = true;
      await _execute();
    }
  }

  Future _execute() async {
    while (true) {
      if (_queue.isEmpty) {
        _scheduled = false;
        return;
      }
      var first = _queue.removeFirst();
      await first();
    }
  }
}