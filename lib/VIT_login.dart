import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VITLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VITLogin();
  }
}

class _VITLogin extends State<VITLogin> {
  TextEditingController _textController;
  final _scaffoldKey = new GlobalKey<_VITLogin>();
  final _formKey = new GlobalKey<FormState>();

  String _username = "sfewf";
  String _password;

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initialiseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
        key: _scaffoldKey,
//        navigationBar: CupertinoNavigationBar(
//          middle: const Text(
//            'Volsbb Login',
//            textScaleFactor: 1.2,
//            style: TextStyle(color:CupertinoColors.white),
//          ),
//          backgroundColor: CupertinoColors.darkBackgroundGray,
//        ),
        child: SafeArea(
            child: Container(
                padding: const EdgeInsets.fromLTRB(36.0,0,36.0,0),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 150.0,
                            child: Image.asset(
                              'assets/images/VITLogo.png',
                              fit: BoxFit.contain,
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                          ),
                          CupertinoTextField(
                            controller: _userNameController,
                            padding: const EdgeInsets.all(20.0),
                            placeholder: 'User Name',
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: CupertinoColors.activeBlue,
                                ),
                                borderRadius: BorderRadius.circular(22.0)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                          ),
                          CupertinoTextField(
                            controller: _passwordController,
                            padding: const EdgeInsets.all(20.0),
                            placeholder: 'Password',
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: CupertinoColors.activeBlue,
                                ),
                                borderRadius: BorderRadius.circular(22.0)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                          ),
                          CupertinoButton(
                            child: Text('Login'),
                            color: CupertinoColors.activeBlue,
                            minSize: MediaQuery.of(context).size.aspectRatio,
                            borderRadius: BorderRadius.circular(20.0),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _showDialog();
                              }
                            },
                          )
                        ]
                    )
                )
            )
        )
    );
  }

  _initialiseData() async{
    final prefs = await SharedPreferences.getInstance();
    final String username = 'username';
    final String password = 'password';

    _userNameController.text = prefs.getString(username) ?? '';
    _passwordController.text = prefs.getString(password) ?? '';

  }

  _showDialog() async{
    CupertinoActivityIndicator(

    );
    _username = _userNameController.text;
    _password = _passwordController.text;
    String _message = '';
    String _alreadyLoggedIn = '<html><head><meta http-equiv="refresh" content="0;url=http://www.msftconnecttest.com/redirect"></head></html>';

    Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
      return CupertinoPageScaffold(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }));
    // set up POST request arguments
    String url = 'http://phc.prontonetworks.com/cgi-bin/authlogin?URI=http://www.msftconnecttest.com/redirect';
    Map<String, String> headers = {"Content-type": "application/json"};
    // make POST request
    Response response_login = await post(url,
        body: {'userId': _username,
          'password': _password,
          'serviceName': 'ProntoAuthentication'
        });

    Navigator.pop(context);

    // check the status code for the result
    int statusCode = response_login.statusCode;
    if(statusCode != 200){
      _message = "Not connected to VITWiFi";
    }
    else{
      String body = response_login.body;
      if(body.contains("Congratulations !!!")){
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('username', _username);
        prefs.setString('password', _password);
        _message = "Successfully connected to VITWifi";
      }
      else if(body.contains(_alreadyLoggedIn)){
        _message = "Already Logged In";
      }
      else{
        _message = "Incorrect User Name/Password";
      }
    }

    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text("Status"),
          content: Text(_message),
          actions: [
            CupertinoDialogAction(
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.pop(context, 'Dismiss');
              },
            )
          ],
        ));
  }
}
