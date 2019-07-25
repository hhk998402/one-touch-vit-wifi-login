import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';
import 'dart:io';
import 'package:data_connection_checker/data_connection_checker.dart';

class VIT_Login_Data{
  var username = '';
  var password;
  var context;

  save() async{
    final checkWiFi = await _checkWiFiStatus();
    if(!checkWiFi){
      _showDialogBox("Not connected to VITWiFi");
    }
    _handlePostResponse();
  }

  _showDialogBox(String _message){
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

  Future<bool> _checkWiFiStatus() async{
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      var wifiName = await (Connectivity().getWifiName());
      print(wifiName);
      print(connectivityResult);
      if (connectivityResult == ConnectivityResult.mobile) {
        return (false);
      }
    }
    catch(e){
      print("ERROR in Checking WiFi Connectivity");
      print(e.toString());
      return(false);
    }
//    else{
//      bool result = await DataConnectionChecker().hasConnection;
//      print(result);
//      if(result == true) {
//        print('YAY! Free cute dog pics!');
//      } else {
//        print('No internet :( Reason:');
//        print(DataConnectionChecker().lastTryResults);
//      }
//    }
    return(true);
  }

//  Function to send POST Request to Login Route
  _sendPostRequest() async{
    try {
      String url = 'http://phc.prontonetworks.com/cgi-bin/authlogin?URI=http://www.msftconnecttest.com/redirect';

      Response response_login = await post(url,
          body: {'userId': username,
            'password': password,
            'serviceName': 'ProntoAuthentication'
          });
      return ({
        'success': true,
        'statusCode': response_login.statusCode,
        'body': response_login.body
      });
    }
    catch(e){
      print("ERROR in Sending POST Request");
//      print(e.toString());
      return({
        'success': false,
        'statusCode': '',
        'body': '',
      });
    }
  }

  _handlePostResponse() async{
    String _alreadyLoggedIn = '<html><head><meta http-equiv="refresh" content="0;url=http://www.msftconnecttest.com/redirect"></head></html>';

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CupertinoPageScaffold(
        child: Center(
          child: CupertinoActivityIndicator(
            radius: 40.0,
          ),
        ),
      );
    }));

    var response_login = await _sendPostRequest();

    Navigator.pop(context);

    if(response_login['success']) {
      // check the status code for the result
      int statusCode = response_login['statusCode'];
      if (statusCode != 200) {
        _showDialogBox("Not connected to VITWiFi");
      }
      else {
        String body = response_login['body'];
        if (body.contains("Congratulations !!!")) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('username', username);
          prefs.setString('password', password);
          _showDialogBox("Successfully connected to VITWifi");
        }
        else if (body.contains(_alreadyLoggedIn)) {
          _showDialogBox("Already Logged In");
        }
        else {
          _showDialogBox("Incorrect User Name/Password");
        }
      }
    }
    else{
      _showDialogBox("Not able to connect to VITWiFi, is it past 12:30 AM? If not please check WiFi settings");
    }
  }
}