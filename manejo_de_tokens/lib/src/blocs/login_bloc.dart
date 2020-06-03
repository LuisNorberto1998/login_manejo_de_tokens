import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:formvalidation/src/blocs/validators.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(emailStream, passwordStream, (a, b) => true);

  //Insertar valores al String
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Ultimo valor emitido
  String get email => _emailController.value;
  String get password => _passwordController.value;

  // cerrar
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
