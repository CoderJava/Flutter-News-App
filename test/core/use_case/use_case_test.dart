import 'package:flutter_news_app/core/use_case/use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Make sure the output of props function NoParams',
    () async {
      // assert
      expect(
        NoParams().props,
        [],
      );
    },
  );
}
