import 'package:flutter/material.dart';
import './VIT_login_material.dart';

void main() {
  runApp(VITHome());
}

class VITHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.wifi)),
              Tab(icon: Icon(Icons.account_box)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
            labelColor: Colors.deepPurpleAccent,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.deepOrangeAccent,
          ),
          body: TabBarView(
            children: [
              VITLoginMaterial(),
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}