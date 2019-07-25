class VIT_Login_Data{
  String username = '';
  String password = '';

  save(){
    _validateFormEntry();

  }

  //Function to send POST Request to Login Route
  _sendPostRequest(String username, String password) async{
    String url = 'http://phc.prontonetworks.com/cgi-bin/authlogin?URI=http://www.msftconnecttest.com/redirect';

    Response response_login = await post(url,
        body: {'userId': _username,
          'password': _password,
          'serviceName': 'ProntoAuthentication'
        });
    return(response_login);
  }

  _validateFormEntry() async{

  }
}