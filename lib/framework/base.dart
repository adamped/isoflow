import 'dart:async';
import 'dart:collection';

abstract class Message {}
typedef void Send(Message message);
typedef Model Update<Model>(Model model, Message message);
typedef PlatformModel BuildView<Model, PlatformModel>(Model model, Send update);
typedef void UpdateMessage(Message message);
typedef void Process<PlatformModel>(PlatformModel model);

abstract class Base<Model, PlatformModel> {
  Base({Model initial, this.update, this.platform, this.connector})
  {
    input.onAdd((msg) { _process(msg); });
    _model = initial;
  }

  final StreamController<Message> output = StreamController<Message>.broadcast();
  void dispose() =>  output.close();
  final Update<Model> update;
  final BuildView<Model, PlatformModel> platform;
  final InboundQueue input = InboundQueue();
  final Process<PlatformModel> connector;

  Model _model;

  void _process(Message message) {
    _model = update(_model, message);
    var result = platform(_model, (msg) { output.sink.add(msg); });
    connector(result); 
  }
}

class InboundQueue {
  var _queue = ListQueue<Message>();
  UpdateMessage _update;
  bool _isRunning = false;

  void add(Message message)
  {
    _queue.add(message);

    if (_isRunning)
      return;

    _isRunning = true;

    while (_queue.length > 0)
    {
      _update(_queue.removeFirst());
    }

    _isRunning = false;
  }

  void onAdd(UpdateMessage update) => _update = update;
}