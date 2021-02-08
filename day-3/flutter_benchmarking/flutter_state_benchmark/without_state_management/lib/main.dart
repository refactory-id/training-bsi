import 'package:flutter/material.dart';
import 'package:without_state_management/widgets/switch_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkMode = false;
  set isDarkMode(bool value) => setState(() => _isDarkMode = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Ephemeral State"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EphemeralSwitchWidget(
            callback: (value) => isDarkMode = value,
            isDarkMode: _isDarkMode,
          ),
          Expanded(
              child: Container(
            color: _isDarkMode ? Colors.black : Colors.white,
          ))
        ],
      ),
    );
  }
}
