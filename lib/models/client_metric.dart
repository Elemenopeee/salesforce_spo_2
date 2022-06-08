class ClientMetric {
  final String key;
  final double value;

  ClientMetric._({
    required this.key,
    required this.value,
  });

  factory ClientMetric.fromPair(String key, dynamic value) {
    return ClientMetric._(
      key: key,
      value: double.tryParse(value) ?? 0,
    );
  }
}
