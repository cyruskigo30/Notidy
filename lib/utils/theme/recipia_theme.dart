import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/constants.dart';
import 'colors.dart';

class RecipiaTheme {
  static TextTheme lightTextTheme = const TextTheme(
    bodySmall: TextStyle(
      color: kLightTextColor,
      fontSize: 10,
      fontFamily: 'Poppins',
    ),
    bodyMedium: TextStyle(
      color: kLightTextColor,
      fontSize: 12,
      fontFamily: 'Poppins',
    ),
    bodyLarge: TextStyle(
      color: kLightTextColor,
      fontSize: 14,
      fontFamily: 'Poppins',
    ),
    titleSmall: TextStyle(
      color: kLightTextColor,
      fontSize: 16,
      fontFamily: 'Poppins',
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      color: kLightTextColor,
      fontSize: 18,
      fontFamily: 'Poppins',
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w500,
      color: kLightTextColor,
      fontSize: 20,
      fontFamily: 'Poppins',
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w500,
      color: kLightTextColor,
      fontSize: 22,
      fontFamily: 'Poppins',
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w500,
      color: kLightTextColor,
      fontSize: 24,
      fontFamily: 'Poppins',
    ),
    displayLarge: TextStyle(
      fontWeight: FontWeight.w500,
      color: kLightTextColor,
      fontSize: 26,
      fontFamily: 'Poppins',
    ),
  );
  static TextTheme darkTextTheme = const TextTheme(
    bodySmall: TextStyle(
      color: kDarkTextColor,
      fontSize: 10,
      fontFamily: 'Poppins',
    ),
    bodyMedium: TextStyle(
      color: kDarkTextColor,
      fontSize: 12,
      fontFamily: 'Poppins',
    ),
    bodyLarge: TextStyle(
      color: kDarkTextColor,
      fontSize: 14,
      fontFamily: 'Poppins',
    ),
    titleSmall: TextStyle(
      color: kDarkTextColor,
      fontSize: 16,
      fontFamily: 'Poppins',
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      color: kDarkTextColor,
      fontSize: 18,
      fontFamily: 'Poppins',
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w500,
      color: kDarkTextColor,
      fontSize: 20,
      fontFamily: 'Poppins',
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w500,
      color: kDarkTextColor,
      fontSize: 22,
      fontFamily: 'Poppins',
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w500,
      color: kDarkTextColor,
      fontSize: 24,
      fontFamily: 'Poppins',
    ),
    displayLarge: TextStyle(
      fontWeight: FontWeight.w500,
      color: kDarkTextColor,
      fontSize: 26,
      fontFamily: 'Poppins',
    ),
  );

  ///Define a static method light which returns the color tones for a light theme
  ///using the light text theme already created
  static ThemeData light() {
    return ThemeData(
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: kLightScaffoldBackgroundColor,
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
      ),
      appBarTheme: const AppBarTheme(
        elevation: kDefaultElevation,
        centerTitle: false,
        toolbarHeight: 80.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        foregroundColor: kLightTextColor,
        backgroundColor: kLightScaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: kLightTextColor,
          size: 22,
        ),
        titleTextStyle: TextStyle(
          color: kLightTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        toolbarTextStyle: TextStyle(
          color: kLightTextColor,
        ),
      ),
      iconTheme: const IconThemeData(
        color: kLightTextColor,
        size: 22,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: kDarkTextColor,
        backgroundColor: kPrimaryColor,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: kCardLightColor,
        unselectedItemColor: kCardLightColor,
        backgroundColor: kCardDarkColor,
        elevation: kDefaultElevation,
      ),
      cardColor: kCardLightColor,
      textTheme: lightTextTheme,
      chipTheme: ChipThemeData(
        selectedColor: kPrimaryColor,
        showCheckmark: true,
        backgroundColor: kLightTextColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: kLargeHeight),
        prefixIconColor: kLightTextColor,
        labelStyle: TextStyle(
          color: kLightTextColor,
          fontSize: 15,
        ),
        hintStyle: TextStyle(fontSize: 14),
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: kLightTextColor,
          ),
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            style: BorderStyle.solid,
            color: kLightTextColor,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: kPrimaryColor,
        contentTextStyle: const TextStyle(
          color: kDarkTextColor,
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: kLDarkScaffoldBackgroundColor,
      appBarTheme: const AppBarTheme(
        elevation: kDefaultElevation,
        centerTitle: false,
        toolbarHeight: 80.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        foregroundColor: kDarkTextColor,
        backgroundColor: kLDarkScaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: kDarkTextColor,
          size: 22,
        ),
        titleTextStyle: TextStyle(
          color: kDarkTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconTheme: const IconThemeData(
        color: kDarkTextColor,
        size: 22,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: kDarkTextColor,
        backgroundColor: kPrimaryColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kDarkTextColor,
        backgroundColor: kLDarkScaffoldBackgroundColor,
      ),
      cardColor: kCardDarkColor,
      chipTheme: ChipThemeData(
        selectedColor: kPrimaryColor,
        showCheckmark: true,
        backgroundColor: kCardDarkColor,
        deleteIconColor: kDarkTextColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(vertical: kLargeHeight),
        prefixIconColor: kDarkTextColor,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: const TextStyle(
          color: kDarkTextColor,
          fontSize: 15,
        ),
        // floatingLabelStyle: TextStyle(),
        hintStyle: const TextStyle(fontSize: 14),
        alignLabelWithHint: true,
        focusColor: kPrimaryColor,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: kCardLightColor,
          ),
        ),
        border: const OutlineInputBorder(),

        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            style: BorderStyle.solid,
            color: kCardLightColor,
          ),
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: kLightTextColor,
        scrimColor: kLightTextColor.withOpacity(.8),
      ),
      textTheme: darkTextTheme,
    );
  }
}
