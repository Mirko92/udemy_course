import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTermsValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView(children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(labelText: 'E-Mail'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) {
                setState(() {
                  _emailValue = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (String value) {
                setState(() {
                  _passwordValue = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Accept Terms'),
              value: _acceptTermsValue,
              onChanged: (bool value) {
                setState(() {
                  _acceptTermsValue = value;
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('Login'),
                onPressed: () {
                  print('Email    : $_emailValue');
                  print('Password : $_passwordValue');
                  Navigator.pushReplacementNamed(context, '/products');
                }),
          ]),
        ));
  }
}
