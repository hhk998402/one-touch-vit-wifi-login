import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

import './models/vit_login.dart';

class VITLoginMaterial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VITLoginMaterial();
  }
}

class _VITLoginMaterial extends State<VITLoginMaterial> {
  final _formKey = GlobalKey<FormState>();
  final _vitlogin = VIT_Login_Data();

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialiseData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //Controllers for the two input fields
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Theme(
        data: new ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          primaryColorDark: Colors.deepPurple,
        ),
        child: Container(
            padding: const EdgeInsets.fromLTRB(36.0, 0, 36.0, 0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 30.0),
                          ),
                          SizedBox(
                              height: 150.0,
                              child: Image.asset(
                                'assets/images/VITLogo.png',
                                fit: BoxFit.contain,
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                          ),
                          TextFormField(
                            controller: _userNameController,
                            decoration: InputDecoration(
                                labelText: 'User Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )
                            ),
                            cursorColor: Colors.deepOrangeAccent,
                            validator: (value){
                              if(value.isEmpty){
                                return 'Please enter your username';
                              }
                            },
                            onSaved: (val) => setState(() {
                              _vitlogin.username = val;
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            cursorColor: Colors.deepOrangeAccent,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                      color: Colors.deepPurpleAccent,
                                    )
                                )
                            ),
                            validator: (value){
                              if(value.isEmpty){
                                return 'Please enter your password';
                              }
                            },
                            onSaved: (val) => setState(() {
                              _vitlogin.password = val;
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                          ),
                          RaisedButton(
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.deepPurple,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Colors.deepPurpleAccent,
                                  )
                              ),
                              onPressed: () {
                                final form = _formKey.currentState;
                                if(form.validate()){
                                  form.save();
                                  _vitlogin.context = context;
                                  _vitlogin.save();
                                }
                              }),
                        ],
                      )
                    )
                )
            )
      )
    );
  }

  void _initialiseData() async{
    final prefs = await SharedPreferences.getInstance();
    final String username = 'username';
    final String password = 'password';

    _userNameController.text = prefs.getString(username) ?? '';
    _passwordController.text = prefs.getString(password) ?? '';
  }
}
