class Result {
  String? number;
  String? uparentuservicetype;
  String? upreferredschedulebycustomer;
  String? ucustomersatisfaction;
  String? state;

  Result({
    this.number,
    this.uparentuservicetype,
    this.upreferredschedulebycustomer,
    this.ucustomersatisfaction,
    this.state,
  });

  Result.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    uparentuservicetype = json['u_parent.u_service_type'];
    upreferredschedulebycustomer = json['u_preferred_schedule_by_customer'];
    ucustomersatisfaction = json['u_customer_satisfaction'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['u_parent.u_service_type'] = uparentuservicetype;
    data['u_preferred_schedule_by_customer'] = upreferredschedulebycustomer;
    data['u_customer_satisfaction'] = ucustomersatisfaction;
    data['state'] = state;
    return data;
  }
}

class DashboardResult {
  List<Result?>? result;

  DashboardResult({this.result});

  DashboardResult.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    } else {
      result = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result != null ? result!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}
