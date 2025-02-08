import 'package:flutter/material.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/config/config.dart';


//Apis
const String userAPIBaseURL = '${Config.prodBaseUrl}/auth';
const String mattressAPIBaseUrl = '${Config.prodBaseUrl}/mattress';
const String dashboardAPIBaseUrl = '${Config.prodBaseUrl}/dashboard';
const String organizationBaseUrl = '${Config.prodBaseUrl}/Organisation';
const String typeBaseUrl = '${Config.prodBaseUrl}/mattresstype';
const String mattressBaseUrl = '${Config.prodBaseUrl}/mattress';
const String groupBaseUrl = '${Config.prodBaseUrl}/groups';

// UI
const double matcronTextFieldBorderRadius = 50;
Color matcronPrimaryColor = HexColor("#50C2C9");
const progressBarLabels = ["Select", "Tap RFID", "Finished"];

//status
const mattressStatus = [
  {"Text": "Production", "Color": Colors.orange},
  {"Text": "Inventory", "Color": Colors.green},
  {"Text": "Assigned", "Color": Colors.green},
  {"Text": "Use", "Color": Colors.green},
  {"Text": "Washing", "Color": Colors.red},
  {"Text": "Decommissioned", "Color": Colors.red},
  {"Text": "Transit", "Color": Colors.orange},
];

const groupStatus = [ "Active", "Archived"];

const transferOutPurposes = [
  "Maintainence",
  "Delivery",
  "Emergency",
  "End of Life Cycle"
];




/// margin
double kMargin = 14.0;

/// bottom bar height
double kHeight = 62.0;

/// notch circle circle radius
const double kCircleRadius = 30.0;

/// margin between notch and circle
const double kCircleMargin = 8.0;

/// top radius
double kTopRadius = 10.0;

/// top margin
const double kTopMargin = 10.0;

/// bottom radius
double kBottomRadius = 28.0;

/// bottom bar item size
const double kIconSize = 24.0;

/// Pi value
const double kPi = 3.1415926535897932;