class TicksStreamRequestModel {
  TicksStreamRequestModel({
    required this.ticks,
    required this.subscribe,
  });

  final String? ticks;
  final int? subscribe;

  factory TicksStreamRequestModel.fromJson(Map<String, dynamic> json) {
    return TicksStreamRequestModel(
      ticks: json["ticks"],
      subscribe: json["subscribe"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ticks": ticks,
        "subscribe": subscribe,
      };
}
