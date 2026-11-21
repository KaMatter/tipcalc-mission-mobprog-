import 'package:flutter_test/flutter_test.dart';
import 'package:tipcalc/main.dart';

void main() {
  test('computeTip calculates 15% tip and total for 500', () {
    var answer = computeTip(500, 15);
    expect(answer.tip, 75.0);
    expect(answer.total, 575.0);
  });

  test('parseBill returns null for invalid text', () {
    expect(parseBill('abc'), isNull);
    expect(parseBill('500'), 500.0);
  });
}
