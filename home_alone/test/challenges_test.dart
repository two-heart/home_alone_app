import 'package:flutter_test/flutter_test.dart';
import 'package:home_alone/model/challenge.dart';
import 'extension/ext.dart';

void main() {
  test('Can load json fixtures in test', () async {
    final convert = (item) => Challenge.fromJson(item);
    final data = await "mock_challenges.json".toJsonList<Challenge>(convert);
    final challenge = data[0];
    expect(data, isNotNull);
    expect(challenge.id, "67e6a2fa-1c4b-4249-9a13-d725ff2d1e78");
  });
}
