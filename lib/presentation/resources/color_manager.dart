import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#4A8AC4");
  static Color darkGrey = HexColor.fromHex("#393D3f");
  static Color loginButton = HexColor.fromHex("#E5F3FF");
  static Color grey = HexColor.fromHex("#A6A6A6");
  static Color textFieldColor = HexColor.fromHex("#FAFAFA");
  static Color primaryOpacity70 = HexColor.fromHex("#F9A825");
  static Color signInBorder = HexColor.fromHex("#E8E8E8");
  static Color textFieldlabelColor = HexColor.fromHex("#B8B8B8");
  static Color increaseDescreseContColor = HexColor.fromHex("#E5F3FF");

  static Color promo1BgColor = HexColor.fromHex("#4D4472").withOpacity(1);

  static Color selectedPackageBorderColor =
      HexColor.fromHex("#E8E2FF").withOpacity(1);

  static Color loginPrivacyColor1 = HexColor.fromHex("#6E777C");
  static Color loginPrivacyColor2 = HexColor.fromHex("#3D4951");

  //text color
  static Color textColor = HexColor.fromHex("#3D4951");

  static Color logOutButtonBackgroundColor = HexColor.fromHex("#FFF6F6");
  static Color logoutButtonTextColor = HexColor.fromHex("#F85353");

  static Color dateTabColorTextinChat = HexColor.fromHex("#9EA4A8");

  static Color containerColor = HexColor.fromHex("#E8F4FA");
  static Color containerBorder = HexColor.fromHex("#D2E9F6");

  //New Colors
  static Color cancelButtonTextColor = HexColor.fromHex("#CFD2D3");
  static Color black = HexColor.fromHex('#000000');
  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color tabColor = HexColor.fromHex("#1E93D1");
  static Color tabBarColor = HexColor.fromHex("#D2E9F6");
  static Color elevatedButtonColor = HexColor.fromHex("#1E93D1");
  static Color logOutButtonColor = HexColor.fromHex("#F85353");
  // static Color textFieldColor = HexColor.fromHex("#E8F4FA");
  static Color textFieldBorderColor = HexColor.fromHex("#1E93D1");
  static Color tabBarBorder = HexColor.fromHex('#D2E9F6');

  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xff0ed0cf), Color(0xff01d0b3)],
    stops: [0.25, 0.75],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Color backgroundBottomNavigation = HexColor.fromHex('#FAFAFA');
  static Color bottomNavigationSelectionColor = HexColor.fromHex('#4A8AC4');
  static Color homeContainerBookOfferBackgorund = HexColor.fromHex('#FAF9FD');
  static Color lightGrey = HexColor.fromHex('#A6A6A6');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString =
          "FF$hexColorString"; //Appending characters for opacity of 100% at start of HexCode
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
