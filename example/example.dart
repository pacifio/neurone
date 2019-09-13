import 'package:neurone/neurone.dart';
import 'dart:async';

main() async {
  Neurone neurone = Neurone(synchronize: false);
  neurone.listen("event1", (a) {
    print(a);
  });
  neurone.listen("event2", (a) {
    print(a);
  });
  await Future.delayed(Duration(seconds: 2)).then((v) {
    neurone.emit("event1", "valueXYZ");
  });
}
