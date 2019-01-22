import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/model/utils.dart';
import 'package:udemy_course/scoped-models/main.dart';

enum AuthMode { Signup, Login }

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'terms': false
  };

  bool _acceptTermsValue = false;

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthMode _authMode = AuthMode.Login;

  DecorationImage _buildBackgroundImage(String path) {
    return DecorationImage(
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
        image: AssetImage('assets/images/background.jpg'),
        fit: BoxFit.cover);
  }

  TextStyle _getTextStyle(BuildContext context) {
    return TextStyle(color: Theme.of(context).primaryColor);
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'E-Mail',
        icon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      style: _getTextStyle(context),
      validator: (String newValue) {
        if (newValue.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(newValue)) {
          return "Please enter a valid email!";
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
          labelText: 'Password', icon: Icon(Icons.vpn_key)),
      obscureText: true,
      style: _getTextStyle(context),
      validator: (String newValue) {
        if (newValue.isEmpty || newValue.length < 6) {
          return "Please enter a valid password, 6+ characters long";
        }
      },
      onSaved: (String value) {
        _formData['password'] = value.trim();
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Password', icon: Icon(Icons.vpn_key)),
      obscureText: true,
      style: _getTextStyle(context),
      validator: (String newValue) {
        if (_passwordController.text != newValue) {
          return "Password do not match";
        }
      },
      onSaved: (String value) {
        _formData['password'] = value.trim();
      },
    );
  }

  Widget _buildAccetptSwitch() {
    return SwitchListTile(
      title: Text(
        'Accept Terms',
        style: TextStyle(color: Colors.white),
      ),
      value: _formData['terms'],
      onChanged: (bool value) {
        _formData['terms'] = value;
      },
    );
  }

  void _submitForm(Function login, Function signup) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    if (_authMode == AuthMode.Login) {
      login(_formData['email'], _formData['password']);
      Navigator.pushReplacementNamed(context, '/products');
    } else {
      // final Map<String, dynamic> successInformation =
        final MyHttpResponse successInformation =
          await signup(_formData['email'], _formData['password']);

      if (successInformation.result) {
        Navigator.pushReplacementNamed(context, '/products');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error occurred'),
            content: Text('contenuto'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage('assets/images/background.jpg'),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _authMode == AuthMode.Signup
                        ? _buildPasswordConfirmTextField()
                        : Container(),
                    _buildAccetptSwitch(),
                    SizedBox(
                      height: 10.0,
                    ),
                    FlatButton(
                      child: Text(
                          'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}'),
                      onPressed: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.Login
                              ? AuthMode.Signup
                              : AuthMode.Login;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (context, widget, MainModel userModel) {
                        return RaisedButton(
                            textColor: Colors.white,
                            child: Text('Login'),
                            onPressed: () =>
                                _submitForm(userModel.login, userModel.signup));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
