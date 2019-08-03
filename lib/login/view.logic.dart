import 'view.dart' as login;
import '../services/api.dart' as api;

void initialize(login.LoginView instance) {

  // From LoginView
  instance.output.stream.listen((msg) {
    if (msg is login.LoginMessage) loginPressed(msg, api.instance);
  });

  // From Other Services
  api.instance.output.stream.listen((msg) {
    if (msg is api.ApiResponseMessage) loginResponseReceived(msg, instance);
  });
}

void loginPressed(login.LoginMessage message, api.Api apiService) {
  var msg = api.ApiPostMessage(body: message.username, url: '/oauth/login');

  apiService.input.add(msg);
}

void loginResponseReceived(
    api.ApiResponseMessage message, login.LoginView view) {

  var msg = login.LoginResult(success: true);

  view.input.add(msg);
}