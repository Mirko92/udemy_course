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
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.darken),
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover),
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
              child: SingleChildScrollView(
            child: Column(children: <Widget>[
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'E-Mail', icon: Icon(Icons.email), ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Theme.of(context).primaryColor),
                onChanged: (String value) {
                  setState(() {
                    _emailValue = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Password', icon: Icon(Icons.vpn_key)),
                obscureText: true,
                style: TextStyle(color: Theme.of(context).primaryColor),
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
          )),
        ));
  }
}
