import 'package:flutter/material.dart';
import 'dart:async';
import 'base.dart';

typedef Model Update<Model>(BuildContext context, Message msg, Model model);
typedef Widget BuildView<Model>(Model model, Send update);
typedef Model Build<Model>();

abstract class View<Model> extends StatefulWidget {
  View({Key key, this.initial, this.update, this.view}): super(key: key);

  final StreamController<Message> output = StreamController<Message>();
  void dispose() =>  output.close();
  final Model initial;
  final Update<Model> update;
  final BuildView<Model> view;
  final InboundQueue input = InboundQueue();

  @override
  _State createState() => _State<View, Model>(initial, update, view, output, input);
}

class _State<PageView extends StatefulWidget, Model> extends State<PageView>
{
  _State(this.model, this._update, this._view, this._output, this._input)
  {
    _input.onAdd((msg) { update(msg); });
  }

  Model model;
  final Update<Model> _update;
  final BuildView<Model> _view;
  final StreamController<Message> _output;
  final InboundQueue _input;

  void _setModel(Build<Model> m) => setState(() { model = m(); });
  
  @override
  Widget build(BuildContext context) {    
    return _view(model, (msg) { update(msg); _output.sink.add(msg); } );
  }

  void update(Message msg) { 
   _setModel(() => _update(context, msg, model));
  }

}