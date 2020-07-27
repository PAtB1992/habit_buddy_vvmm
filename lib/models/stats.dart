import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Statistics {
  final String pageViewName;
  final timestamp;

  Statistics({
    @required this.pageViewName,
    @required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'pageViewName': pageViewName,
      'timestamp': timestamp,
    };
  }
}
