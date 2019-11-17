import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/src/models/user.dart';
import 'package:wanderlust/src/repository/login_provider.dart';

class LoginBloc {
  final _userFetcher = PublishSubject<User>();
  final _credentialsSavedFetcher = PublishSubject<bool>();
  bool keyStored = false;
  bool emailStored = false;
  bool passwordStored = false;
  Observable<User> get authenticatedUser => _userFetcher.stream;
  Observable<bool> get credentialsStored => _credentialsSavedFetcher.stream;

  authenticate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('Key') != null && prefs.getString('Key').isNotEmpty) {
      final cryptor = new PlatformStringCryptor();
      final key = prefs.getString('Key');
      String encryptedPassword = prefs.getString('Password');
      String email = prefs.getString('Email');
      final String decryptedPassword = await cryptor.decrypt(encryptedPassword, key);

      LoginProvider loginProvider = new LoginProvider(email, decryptedPassword);
      User user = await loginProvider.authenticate();
      _userFetcher.sink.add(user);
    } else {
      print('Sin credenciales almacenadas');
      _userFetcher.sink.add(new User('', ''));
    }
  }

  dispose() {
    _userFetcher.close();
    _credentialsSavedFetcher.close();
  }

  saveCredential(String credentialName, String credential, bool isPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isPassword) {
      final cryptor = new PlatformStringCryptor();
      final String salt = await cryptor.generateSalt();
      final String key = await cryptor.generateKeyFromPassword(credential, salt);
      final String encryptedPassword = await cryptor.encrypt(credential, key);

      passwordStored = await prefs.setString(credentialName, encryptedPassword);
      keyStored = await prefs.setString('Key', key);
    } else {
      emailStored = await prefs.setString(credentialName, credential);
    }

    if(keyStored && emailStored && passwordStored) _credentialsSavedFetcher.sink.add(true);
    else _credentialsSavedFetcher.sink.add(false);
  }

  logout() {
    print(
        'LoginBloc: La funcionalidad de logout estará disponible próximamente');
  }
}