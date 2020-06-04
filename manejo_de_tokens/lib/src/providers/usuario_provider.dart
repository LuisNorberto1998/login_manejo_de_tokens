import 'package:http/http.dart' as http;
import 'dart:convert';

class UsuarioProvider {
  final _firebaseToken = 'AIzaSyB6txCnbhbp4F8dGPCsnDucoHTt3bkOPF8';

  //Inicio de sesión
  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData),
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      //TODO: Salvar el token
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': true, 'mensaje': decodeResp['error']['menssage']};
    }
  }

  //Nuevo usuario
  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData),
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      //TODO: Salvar el token
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': true, 'mensaje': decodeResp['error']['menssage']};
    }
  }
}
