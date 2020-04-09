import 'package:test/test.dart';


String _timeGreeting(int hour) {
    String greeting = "";

    if (0 <= hour && hour < 6) greeting = "night";
    else if (6 <= hour && hour < 12) greeting = "morning";
    else if (12 <= hour && hour < 18) greeting = "afternoon";
    else if (18 <= hour && hour < 23) greeting = "night";
    else return  "Hello";

    return "Good " + greeting;
  }

main() {
  test('Testing time function', () {
    var expected = "Good morning";

    var acual = _timeGreeting(6);
    expect(acual, expected);
  });
}