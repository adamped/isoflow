import 'view.dart';
import '../services/api.dart' as api;
import '../services/navigation.dart' as navigation;
import '../framework/base.dart';

void initialize(LoginView loginView) {

  Flow(loginView, api.instance)
      .fromSource<LoginMessage>(loginPressed)
      .fromDestination<api.ApiResponseMessage>(loginApiResponse);

  Flow(api.instance, navigation.instance)
      .fromSource<api.ApiResponseMessage>(navigateOnLogin);

}

api.ApiPostMessage loginPressed(LoginMessage message) {
  return api.ApiPostMessage(body: message.username, url: '/oauth/login');
}

LoginResult loginApiResponse(api.ApiResponseMessage message) {
  return LoginResult(success: true);
}

Message navigateOnLogin(api.ApiResponseMessage message) {
  return navigation.LoginSuccess();
}