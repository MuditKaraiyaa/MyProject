import 'dart:ffi';

/// Model class representing an unsynchronized API request.
class UnsyncAPI {
  bool? isSync; // Indicates if the API request is synchronized
  String? apiName; // Name of the API
  Map<String, dynamic>? parameters; // Parameters for the API request
  String? apiMethod; // HTTP method used for the API request

  UnsyncAPI({
    this.isSync,
    this.apiName,
    this.parameters,
    this.apiMethod,
  });

  /// Constructs a UnsyncAPI instance from a JSON object.
  UnsyncAPI.fromJson(Map<String, dynamic> json) {
    isSync = json['isSync'];
    apiName = json['apiName'];
    parameters = json['parameters'];
    apiMethod = json['apiMethod'];
  }

  /// Converts the UnsyncAPI instance to a JSON object.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSync'] = isSync;
    data['apiName'] = apiName;
    data['parameters'] = parameters;
    data['apiMethod'] = apiMethod;
    return data;
  }
}
