# Neurone
An extremely small library for emitting local events in dart , built with streams . It's mirrorless , so you can also use it to trigger custom events in flutter . You can also pass data with neurone . But neurone is extremely basic and small . It can only emit , listen and kill a stream . If you are looking for something more advanced , neurone is not for you .

## Example
```dart
import 'package:neurone/neurone.dart';
import 'dart:async';

main() async {
  Neurone neurone = Neurone();
  neurone.listen("event1", (a) {
    print(a); // returns "valueXYZ"
  });
  neurone.listen("event2", (a) {
    print(a); // won't execute as "event2" was never triggered
  });
  await Future.delayed(Duration(seconds: 2)).then((v) {
    neurone.emit("event1", "valueXYZ");
  });
}
```

It's that simple to fire and react to an event ! .
You can also create multiple event buses .

## Multiple
```dart
import 'package:neurone/neurone.dart';
import 'dart:async';

main() async {
  Neurone neuroneX = Neurone();
  Neurone neuroneY = Neurone();
}
```
## Synchronus neurone
It's false by default however you can create synchronus neurones like this .
```dart
Neurone neuroneX = Neurone(synchronize: true);
```


>> Created and maintained by Adib Mohsin