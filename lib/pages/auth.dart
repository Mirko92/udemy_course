import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTermsValue = false;

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
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'E-Mail',
        icon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      style: _getTextStyle(context),
      onChanged: (String value) {
        setState(() {
          _emailValue = value;
        });
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      decoration:
          InputDecoration(labelText: 'Password', icon: Icon(Icons.vpn_key)),
      obscureText: true,
      style: _getTextStyle(context),
      onChanged: (String value) {
        setState(() {
          _passwordValue = value;
        });
      },
    );
  }

  Widget _buildAccetptSwitch() {
    return SwitchListTile(
      title: Text(
        'Accept Terms',
        style: TextStyle(color: Colors.white),
      ),
      value: _acceptTermsValue,
      onChanged: (bool value) {
        setState(() {
          _acceptTermsValue = value;
        });
      },
    );
  }

  void _submitForm() {
    print('Email    : $_emailValue');
    print('Password : $_passwordValue');
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    
    final double deviceWidth =  MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth*0.95;   

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
            child: Column(children: <Widget>[
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
            ]),
          ))),
        ));
  }
}
