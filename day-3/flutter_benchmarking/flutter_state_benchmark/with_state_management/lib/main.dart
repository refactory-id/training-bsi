import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:with_state_management/viewmodels/theme_view_model.dart';
import 'package:with_state_management/widgets/switch_widget.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ThemeViewModel())],
    child: MyApp(),
  ));
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("App State"),
      ),
      body: Consumer<ThemeViewModel>(
          builder: (context, theme, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProviderSwitchWidget(),
                  Expanded(
                      child: Container(
                    color: theme.isDarkMode ? Colors.black : Colors.white,
                  ))
                ],
              )),
    );
  }
}
