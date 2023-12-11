# nfc_manager_felica

A Flutter package providing a FeliCa abstraction built on top of [`nfc_manager`](https://pub.dev/packages/nfc_manager).

## Setup

See the `nfc_manager` plugin's [Setup](https://pub.dev/packages/nfc_manager#setup) section.

## Usage

```dart
import 'package:nfc_manager_felica/nfc_manager_felica.dart';

final FeliCa felica = FeliCa.from(tag);

if (felica == null) {
  print('This tag is not compatible with FeliCa.');
  return;
}

// Do something with a FeliCa instance ...
print(felica);
```
