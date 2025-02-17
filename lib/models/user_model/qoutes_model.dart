import 'package:cloud_firestore/cloud_firestore.dart';

class Qoutes {
  List qoutesList ;
  Timestamp startDate;

  Qoutes({
    this.qoutesList,
  });

  Map<String, dynamic> toMap() {
    return {
      QoutesModel.QOUTES: this.qoutesList,
      QoutesModel.START_DATE: this.startDate,
    };
  }

  Qoutes.fromMap(Map<String, dynamic> map) {
    if(map != null){
      this.qoutesList = map[QoutesModel.QOUTES];
      this.startDate = map[QoutesModel.START_DATE];
    }
  }

  @override
  String toString() {
    return 'Qoutes{quotes_array: $qoutesList, start_date: $startDate} ';
  }
}

class QoutesModel {
  static const String QOUTES = "quotes_array";
  static const String START_DATE = "start_date";
}

