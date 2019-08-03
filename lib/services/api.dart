import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../framework/base.dart';

final Api instance = Api();

class Api extends Base<_ApiModel, Request> {
  Api()
      : super(
            initial: _ApiModel(null),
            update: state,
            platform: platform,
            connector: connector);
}

@immutable
class _ApiModel {
  const _ApiModel(this.request);
  final http.Request request;
  final String baseUrl = 'https://sample.com';
  // Could put Auth credential e.g. AccessToken in here
}

_ApiModel state(_ApiModel model, Message message) {
  if (message is ApiPostMessage)
    return _ApiModel(
        http.Request('POST', Uri.parse(model.baseUrl + message.url)));

  return _ApiModel(null);
}

Request platform(_ApiModel model, Send send) {
  if (model.request == null) return null;

  // Build request
  return Request(model.request, (response) {
    // Ideally some kind of message hook to determine the right message response
    send(ApiResponseMessage(status: response.statusCode));
  });
}

void connector(Request request) {
  if (request == null) return;

  // Sample delay
  Future.delayed(Duration(seconds: 1)).then((t) {
    request.callback(http.Response('', 200));
  });

  // This is just a sample
  // More work to deal with POST, GET, PUT, DELETE etc would be needed
  // http.post(request.request).then((response) {
  //   request.callback(response);
  // });
}

typedef void Callback(http.Response response);

@immutable
class Request {
  const Request(this.request, this.callback);
  final http.Request request;
  final Callback callback;
}

@immutable
class ApiPostMessage implements Message {
  const ApiPostMessage({this.url, this.body});
  final String url;
  final String body;
}

@immutable
class ApiResponseMessage implements Message {
  const ApiResponseMessage({this.status});
  final int status;
}
