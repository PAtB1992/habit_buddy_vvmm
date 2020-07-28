class Statistics {
  final String userID;
  final String pageViewName;
  final timestamp;

  Statistics({
    this.userID,
    this.pageViewName,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'pageViewName': pageViewName,
      'timestamp': timestamp,
    };
  }
}
