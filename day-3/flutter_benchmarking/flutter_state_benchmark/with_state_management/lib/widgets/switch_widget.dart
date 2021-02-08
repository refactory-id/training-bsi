import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:with_state_management/viewmodels/theme_view_model.dart';
import 'package:provider/provider.dart';

class ProviderSwitchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
        builder: (context, theme, child) => Container(
              color: theme.isDarkMode ? Colors.black : Colors.white,
              padding: EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    theme.isDarkMode ? "Mode gelap" : "Mode terang",
                    style: TextStyle(
                        color: theme.isDarkMode ? Colors.white : Colors.black),
                  )),
                  CupertinoSwitch(
                    value: theme.isDarkMode,
                    onChanged: (value) => theme.isDarkMode = value,
                    activeColor: Colors.white,
                    trackColor: Colors.black,
                  )
                ],
              ),
            ));
  }
}
