import 'package:firebase_project/utils/validate_email.dart';
import 'package:flutter/material.dart';
import 'package:firebase_project/utils/auth_service.dart';

enum FormType { login, register }

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FormType _formType = FormType.login;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerPassword2 = TextEditingController();
  AuthService _authService = AuthService();
  String _errorMsg = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _errorMsg = '';
    _formType = FormType.login;
  }

  _switchForm() {
    setState(() {
      _errorMsg = '';
      _formType =
          _formType == FormType.login ? FormType.register : FormType.login;
    });
  }

  _handleBtn() async {
    setState(() {
      _errorMsg = '';
      _isLoading = true;
    });
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        if (_formType == FormType.login) {
          await _authService.signUp(
              _controllerEmail.text, _controllerPassword.text);
          var user = await _authService.getCurrentUser();
          if (user != null) {
            _formKey.currentState.reset();
            Navigator.of(context).pushNamed('/profile');
          }
        } else {
          await _authService.createUser(
              _controllerEmail.text, _controllerPassword.text);
          var user = await _authService.getCurrentUser();
          if (user != null) {
            setState(() {
              _formType = FormType.login;
            });
            _formKey.currentState.reset();
            Navigator.of(context).pushNamed('/profile');
          }
        }
      } catch (ex) {
        setState(() {
          _errorMsg = ex.message;
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          key: Key('fieldEmail'),
                          controller: _controllerEmail,
                          validator: (value) {
                            if (value == '') return 'Enter email';
                            if (!validateEmail(value)) return 'Wrong email';
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        TextFormField(
                          key: Key('fieldPasswd'),
                          controller: _controllerPassword,
                          validator: (value) {
                            if (value == '') return 'Enter password';
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        if (_formType == FormType.register)
                          TextFormField(
                            key: Key('fieldPasswd2'),
                            controller: _controllerPassword2,
                            validator: (value) {
                              if (value == '')
                                return 'Need your password again';
                              if (value != _controllerPassword.text)
                                return 'Not the same password';
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: 'Password again'),
                          ),
                        _isLoading
                            ? CircularProgressIndicator()
                            : RaisedButton(
                                child: Text(_formType == FormType.login
                                    ? 'Log in'
                                    : 'Register'),
                                onPressed: _handleBtn,
                              ),
                        if (_errorMsg != '')
                          Text(
                            _errorMsg,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formType == FormType.login
                          ? 'Еще нет аккаунта? '
                          : 'Уже есть аккаунт?',
                    ),
                    FlatButton(
                      key: Key('swichBtn'),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: _formType == FormType.login
                                ? 'Регистрация'
                                : 'Войти',
                          )
                        ], style: Theme.of(context).textTheme.bodyText1),
                      ),
                      onPressed: _switchForm,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
