import 'package:flutter_driver/driver_extension.dart';
import 'performance_profiling_test.dart' as app;

//flutter drive --target=test_driver/app.dart --profile
void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
