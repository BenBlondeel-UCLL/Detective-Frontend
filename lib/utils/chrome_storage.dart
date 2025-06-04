import 'dart:js_interop';

@JS('window.receivedData')
external JSAny? get receivedData;

@JS('window.onExtensionDataReceived')
external set onExtensionDataReceived(JSFunction f);

void listenForChromeMessage() {
  // Register the JS-to-Dart callback
  print(receivedData);
  onExtensionDataReceived = () {
    final data = receivedData?.dartify(); // Converts JS object to Dart Map
    if (data != null) {
      print("✅ Received data from extension: $data");
      // Use this data in your app (pass to state, etc.)
    } else {
      print("❌ Callback triggered but data is still null.");
    }
  }.toJS;

  print("i ran the listenForChromeMessage function");

}
