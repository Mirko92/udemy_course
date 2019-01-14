import 'package:flutter/material.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      decoration:
          InputDecoration(labelText: 'Password', icon: Icon(Icons.vpn_key)),
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

  Widget _buildAccetptSwitch() {
    return SwitchListTile(
      title: Text(
        'Accept Terms',
        style: TextStyle(color: Colors.white),
      ),
      value: _formData['terms'],
      onChanged: (bool value) {
        // setState(() {
          _formData['terms'] = value;
        // });
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    print('Email    : ${_formData['email']}');
    print('Password : ${_formData['password']}');
    Navigator.pushReplacementNamed(context, '/products');
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
                    _buildPasswordTextField(),
                    _buildAccetptSwitch(),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                        textColor: Colors.white,
                        child: Text('Login'),
                        onPressed: _submitForm),
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
