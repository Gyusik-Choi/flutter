import 'package:flutter/material.dart';
import './common_widgets/drawer.dart';

// ignore: use_key_in_widget_constructors
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('울학교'),
          centerTitle: true,
        ),
        body: Container(),
        // https://stackoverflow.com/questions/53300696/how-to-place-drawer-widget-on-the-right
        // https://www.youtube.com/watch?v=BIfufmDiTN0
        drawer: AppDrawer()
      )
    );
  }
}