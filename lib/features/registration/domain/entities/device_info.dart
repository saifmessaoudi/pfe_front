class DeviceInfoModel {
  final String deviceUUID;
  final String deviceName;
  final String deviceModel;

  DeviceInfoModel({
    required this.deviceUUID,
    required this.deviceName,
    required this.deviceModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'deviceUUID': deviceUUID,
      'deviceName': deviceName,
      'deviceModel': deviceModel,
    };
  }

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) {
    return DeviceInfoModel(
      deviceUUID: json['deviceUUID'],
      deviceName: json['deviceName'],
      deviceModel: json['deviceModel'],
    );
  }
}
