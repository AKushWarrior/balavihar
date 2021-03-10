
/*
 * @Copyright (c) 2017 amazon.com. All rights reserved.
 *
 */

import 'package:flutter/material.dart';

class Screen {
  static double marginX (BuildContext context) => width(context) / 24;

  static double width (BuildContext context) => MediaQuery.of(context).size.width;
  static double height (BuildContext context) => MediaQuery.of(context).size.height;

  static double get borderRadius => 20;
}