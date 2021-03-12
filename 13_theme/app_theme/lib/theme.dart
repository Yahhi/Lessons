import 'package:flutter/material.dart';

//Colors.black54 и Colors.deepOrange[100].

ThemeData _themeLight = ThemeData.light();

ThemeData themeLight = _themeLight.copyWith(
  textTheme: _textLight(_themeLight.textTheme),
  appBarTheme: _appBarTheme(_themeLight.appBarTheme),
  bottomNavigationBarTheme: _bottomNavigationBarTheme(),
  cardTheme: _cardTheme(),
  buttonTheme: _buttonTheme(),
  chipTheme: _chipTheme(),
);

TextTheme _textLight(TextTheme base) {
  return base.copyWith(bodyText1: TextStyle(color: Colors.green));
}

AppBarTheme _appBarTheme(AppBarTheme base) => base.copyWith(
      color: Colors.black54,
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.deepOrange[100],
        ),
        bodyText2: TextStyle(
          color: Colors.deepOrange[100],
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.deepOrange[100],
      ),
    );

BottomNavigationBarThemeData _bottomNavigationBarTheme() {
  return BottomNavigationBarThemeData(
    backgroundColor: Colors.black54,
    selectedLabelStyle: TextStyle(
      color: Colors.deepOrange[100],
    ),
    unselectedLabelStyle: TextStyle(
      color: Colors.black,
    ),
    selectedItemColor: Colors.deepOrange[100],
    unselectedItemColor: Colors.black,
    showUnselectedLabels: true,
  );
}

CardTheme _cardTheme() {
  return CardTheme(
    color: Colors.deepOrange[100],
    elevation: 10.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
  );
}

ButtonThemeData _buttonTheme() {
  return ButtonThemeData(
    buttonColor: Colors.deepOrange[100],
    disabledColor: Colors.grey,
  );
}

ChipThemeData _chipTheme() {
  return ChipThemeData.fromDefaults(
    primaryColor: Colors.white,
    secondaryColor: Colors.grey,
    labelStyle: TextStyle(),
  ).copyWith(
    backgroundColor: Colors.black54,
    disabledColor: Colors.black54,
    selectedColor: Colors.deepOrange[100],
    checkmarkColor: Colors.deepOrange[100],
  );
}
