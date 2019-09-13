import 'package:test/test.dart';
import 'package:neurone/neurone.dart';

void main() async {
  Neurone neurone = Neurone(synchronize: false);
  test('testing events', () async {
    neurone.listen("event1", (a) {
      expect(a, "valueXYZ");
    });
    await Future.delayed(Duration(seconds: 2)).then((v) {
      neurone.emit("event1", "valueXYZ");
    });
  });
}
