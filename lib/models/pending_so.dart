class PendingServiceOrder {
  int _id;
  int job_id;
  String attendance_START;
  String arrival_AT_LOCATION;
  String fault_IDENTIFICATION;
  String notes;
  String weather_CONDITION;
  String cause;
  String so_CURRENT_STATUS;

  int get id => _id;

  int get execLabel => job_id;
  set execLabel(int value) => job_id = value;

  String get attendance_start => attendance_START;
  set attendance_start(String value) => attendance_START = value;

  String get arrival_at_location => arrival_AT_LOCATION;
  set arrival_at_location(String value) => arrival_AT_LOCATION = value;

  String get faultidentification => fault_IDENTIFICATION;
  set faultidentification(String value) => fault_IDENTIFICATION = value;

  String get notez => notes;
  set notez(String value) => notes = value;

  String get weather_condition => weather_CONDITION;
  set weather_condition(String value) => weather_CONDITION = value;

  String get causez => cause;
  set causez(String value) => cause = value;

  String get so_CURRENT_STATUz => so_CURRENT_STATUS;
  set so_CURRENT_STATUz(String value) => so_CURRENT_STATUS = value;

  PendingServiceOrder(
      {this.job_id,
      this.attendance_START,
      this.arrival_AT_LOCATION,
      this.fault_IDENTIFICATION,
      this.notes,
      this.weather_CONDITION,
      this.cause,
      this.so_CURRENT_STATUS});
  PendingServiceOrder.withID(
      this._id,
      this.job_id,
      this.attendance_START,
      this.arrival_AT_LOCATION,
      this.fault_IDENTIFICATION,
      this.notes,
      this.weather_CONDITION,
      this.cause,
      this.so_CURRENT_STATUS);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['job_id'] = job_id;
    map['attendance_START'] = attendance_START;
    map['arrival_AT_LOCATION'] = arrival_AT_LOCATION;
    map['fault_IDENTIFICATION'] = fault_IDENTIFICATION;
    map['notes'] = notes;
    map['weather_CONDITION'] = weather_CONDITION;
    map['cause'] = cause;
    map['so_CURRENT_STATUS'] = so_CURRENT_STATUS;

    return map;
  }

  PendingServiceOrder.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this.job_id = map['job_id'];
    this.attendance_START = map['attendance_start'];
    this.arrival_AT_LOCATION = map['arrival_at_location'];
    this.fault_IDENTIFICATION = map['fault_IDENTIFICATION'];
    this.notes = map['notes'];
    this.weather_CONDITION = map['weather_condition'];
    this.cause = map['cause'];
    this.so_CURRENT_STATUS = map['so_CURRENT_STATUS'];
  }
}
