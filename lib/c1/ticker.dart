import 'dart:async';


void main() {
  Timer.periodic(const Duration(seconds: 1), (timer) {
    print(DateTime.now().toIso8601String());
  });
}
