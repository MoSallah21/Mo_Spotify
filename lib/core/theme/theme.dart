import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mospotify/core/theme/app_pallete.dart';

class AppTheme{
  static OutlineInputBorder _border({required Color color})=> OutlineInputBorder(
    borderSide: BorderSide(
        color: color,
        width: 3
    ),
    borderRadius: BorderRadius.circular(10),
  );
  static final dartThemeMode=ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme:  InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      enabledBorder: _border(color: Pallete.borderColor),
      focusedBorder: _border(color:Pallete.gradient2,)
    )
  );
}