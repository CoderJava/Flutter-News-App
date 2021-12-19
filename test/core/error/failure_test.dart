import 'package:flutter_news_app/core/error/failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tErrorMessage = 'testErrorMessage';

  group('ServerFailure', () {
    final tFailure = ServerFailure(tErrorMessage);

    test(
      'Make sure the output of props function',
      () async {
        // arrange
        expect(
          tFailure.props,
          [
            tFailure.errorMessage,
          ],
        );
      },
    );

    test(
      'Make sure the output of toString function',
      () async {
        // assert
        expect(
          tFailure.toString(),
          'ServerFailure{errorMessage: ${tFailure.errorMessage}}',
        );
      },
    );
  });

  group('ConnectionFailure', () {
    final tFailure = ConnectionFailure();

    test(
      'Make sure the output of props function',
      () async {
        // assert
        expect(
          tFailure.props,
          [
            tFailure.errorMessage,
          ],
        );
      },
    );

    test(
      'Make sure the output of toString function',
      () async {
        // assert
        expect(
          tFailure.toString(),
          'ConnectionFailure{errorMessage: ${tFailure.errorMessage}}',
        );
      },
    );
  });

  group('ParsingFailure', () {
    final tFailure = ParsingFailure(tErrorMessage);

    test(
      'Make sure the output of props function',
      () async {
        // assert
        expect(
          tFailure.props,
          [
            tFailure.errorMessage,
          ],
        );
      },
    );

    test(
      'Make sure the output of toString function',
      () async {
        // assert
        expect(
          tFailure.toString(),
          'ParsingFailure{errorMessage: ${tFailure.errorMessage}}',
        );
      },
    );
  });
}
