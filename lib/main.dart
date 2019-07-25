import 'package:flutter/cupertino.dart';

import './VIT_login_cupertino.dart';
import './VIT_login_material.dart';
import './VIT_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        primaryColor: Color(0xFFFF2D55),
      ),
//      home: VITLogin(),
//      home: VITLoginMaterial(),
    home: VITHome(),
    );
  }
}
