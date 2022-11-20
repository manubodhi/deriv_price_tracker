class ForgetRequestModel {
  ForgetRequestModel({
    required this.forget,
  });

  final String forget;

  factory ForgetRequestModel.fromJson(Map<String, dynamic> json) {
    return ForgetRequestModel(
      forget: json["forget"],
    );
  }

  Map<String, dynamic> toJson() => {
        "forget": forget,
      };
}
