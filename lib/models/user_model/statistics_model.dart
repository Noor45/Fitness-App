
class Statistics {
  int activeUsers ;
  int userCount;

  Statistics({
    this.activeUsers,
    this.userCount,
  });

  Map<String, dynamic> toMap() {
    return {
      StatisticsModel.ACTIVE_USERS: this.activeUsers,
      StatisticsModel.USER_COUNT: this.userCount,
    };
  }

  Statistics.fromMap(Map<String, dynamic> map) {
    if(map != null){
      this.activeUsers = map[StatisticsModel.ACTIVE_USERS];
      this.userCount = map[StatisticsModel.USER_COUNT];
    }
  }

  @override
  String toString() {
    return 'Statistics{active_users: $activeUsers, user_count: $userCount} ';
  }
}

class StatisticsModel {
  static const String ACTIVE_USERS = "active_users";
  static const String USER_COUNT = "user_count";
}

