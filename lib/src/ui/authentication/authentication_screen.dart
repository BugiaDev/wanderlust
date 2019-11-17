import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanderlust/src/blocs/LoginBloc.dart';
import 'package:wanderlust/src/ui/themes/themes.dart';
import 'package:wanderlust/src/ui/widgets/mixed_widgets.dart';
import 'package:wanderlust/src/utils/constants.dart';
import 'package:wanderlust/src/utils/validators.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<AuthenticationScreen> {
  bool _obscureTextAPPPassword = true;
  bool _loading = false;
  final _formLoginAPPKey = GlobalKey<FormState>();
  LoginBloc bloc = new LoginBloc();

  Widget _emailField() {
    return TextFormField(
      style: TextStyle(
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        icon: Icon(
          FontAwesomeIcons.user,
          size: 22.0,
        ),
        labelText: Constants.of(context).email,
        border: UnderlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      initialValue: 'enjobugia@gmail.com', // TODO: Remember to delete this
      validator: (value) => InputFieldValidator.validateEmail(value),
      onSaved: (String value) {
        bloc.saveCredential(Constants.of(context).email, value, false);
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      style: TextStyle(
        fontSize: 14.0,
      ),
      obscureText: _obscureTextAPPPassword,
      decoration: InputDecoration(
        icon: Icon(
          FontAwesomeIcons.lock,
          size: 22.0,
        ),
        labelText: Constants.of(context).password,
        border: UnderlineInputBorder(),
        suffixIcon: GestureDetector(
          onTap: _changePasswordVisibility,
          child: Icon(
            FontAwesomeIcons.eye,
            size: 15.0,
          ),
        ),
      ),
      keyboardType: TextInputType.text,
      validator: (value) => InputFieldValidator.validatePassword(value),
      initialValue: 'test01', // TODO: Remember to delete this
      onSaved: (String value) {
        bloc.saveCredential(Constants.of(context).password, value, true);
      },
    );
  }

  Widget _cretateAccountButton() {
    return InkWell(
      child: Text(
        'Or create an account',
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: _openRegistrationScreen,
    );
  }

  Widget _appLoginButton() {
    return StreamBuilder(
        stream: bloc.credentialsStored,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              bloc.authenticate();
            }
          }
          return RaisedButton(
            color: WanderlustColors.darkLoginColor,
            textColor: Colors.white,
            child: setUpButtonChild(),
            onPressed: () {
              if (_formLoginAPPKey.currentState.validate()) {
                _formLoginAPPKey.currentState.save();

                setState(() {
                  _loading = true;
                });
              }
            },
          );
        });
  }

  Widget setUpButtonChild() {
    if (!_loading) {
      return Text(Constants.of(context).login);
    } else {
      return Text(Constants.of(context).loading);
    }
  }

  void _changePasswordVisibility() {
    setState(() {
      _obscureTextAPPPassword = !_obscureTextAPPPassword;
    });
  }

  void _openRegistrationScreen() {
    print('dentro de nada abrimos la registration');
  }

  @override
  Widget build(BuildContext context) {
    bloc.authenticatedUser.listen((data) {
      if (data.isActivatedUser)
        Navigator.pushReplacementNamed(
            context, Constants.of(context).homeRoute);
    });
    return new Scaffold(
        body: Form(
      key: _formLoginAPPKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                  left: kHorizontalGlobalMargin,
                  right: kHorizontalGlobalMargin,
                  top: 10.0),
              child: Column(
                children: <Widget>[
                  MainTitle(title: Constants.of(context).login),
                  Separator(height: 20.0),
                  _emailField(),
                  _passwordField(),
                ],
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                  left: kHorizontalGlobalMargin,
                  right: kHorizontalGlobalMargin,
                  top: 40.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: _appLoginButton(),
                  ),
                ],
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                  left: kHorizontalGlobalMargin,
                  right: kHorizontalGlobalMargin,
                  top: 10.0),
              alignment: Alignment.center,
              child: _cretateAccountButton(),
            )
          ],
        ),
      ),
    ));
  }
}