import 'package:baseflow_plugin_template/baseflow_plugin_template.dart'; // Importing baseflow_plugin_template for creating custom material color
import 'package:flutter/material.dart';

class AppColors {
  // Static colors used throughout the app
  static Color grey = Colors.grey; // Grey color
  static Color lightGrey = Colors.grey.shade300; // Light grey color
  static Color bottomNavUnSelColor =
      const Color.fromRGBO(87, 87, 86, 1); // Bottom navigation unselected color
  static Color feGreenButton =
      const Color.fromRGBO(39, 140, 4, 1); // Field Engineer green button color

  static Color red = const Color(0xFFDE2827); // Red color
  static Color noData = const Color(0xFF575756); // No data color
  static Color placeholderColor = const Color.fromRGBO(51, 51, 51, 1); // Placeholder color
  static Color white = Colors.white; // White color
  static Color lightWhite = const Color(0xFFFFFFFF); // Light white color
  static Color white2 = const Color.fromRGBO(255, 255, 255, 1.1); // Another white color
  static Color black = Colors.black; // Black color
  static Color backgroundColor = Colors.grey; // Background color
  static Color gray = const Color.fromRGBO(145, 146, 147, 0.31); // Gray color with opacity
  static Color selectedColorButtonBackground =
      const Color.fromRGBO(60, 60, 50, 1); // Selected color button background
  static Color unSelectedColorButtonBackground = gray; // Unselected color button background
  static Color textColorWhiteForSelected =
      const Color.fromRGBO(241, 241, 241, 1); // Text color white for selected items
  static Color textColorBlackForNonSelected =
      selectedColorButtonBackground; // Text color black for non-selected items

  static Color navigationBackgroundColor = Colors.white; // Navigation background color
  static Color naviationTextColor = Colors.black; // Navigation text color
  static Color primaryButtonBackgroundColor = red; // Primary button background color
  static Color primaryButtonTitleColor = Colors.black; // Primary button title color
  static Color loaderColor = Colors.red; // Loader color
  static Color geryshade300 = Colors.grey.shade300; // Grey shade 300 color
  static Color boxShadowGrey = Colors.grey.withOpacity(0.5); // Box shadow grey color with opacity
  static Color greyBackground = const Color.fromRGBO(211, 211, 212, 1); // Grey background color

  static Color borderColor = const Color.fromRGBO(145, 146, 147, 1); // Border color
  static Color darkGrey = const Color.fromRGBO(60, 60, 59, 1); // Dark grey color
  static Color btnDisable = const Color(0xFFC3C3C2); // Disabled button color
  static Color iconDisable = const Color(0xff575756); // Disabled icon color
  static Color dark = const Color(0xff3C3C3B); // Dark color
  static Color lightDark = const Color(0xff575756); // Light dark color

  // Theme Material color
  static MaterialColor themeMaterialColor = BaseflowPluginExample.createMaterialColor(
    const Color.fromRGBO(48, 49, 60, 1), // Custom color for creating material color
  );
}
