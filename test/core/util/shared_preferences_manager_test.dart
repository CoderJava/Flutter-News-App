import 'package:flutter_news_app/core/util/shared_preferences_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/mock_helper.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late SharedPreferencesManager sharedPreferencesManager;
  const tKey = 'testKey';

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    sharedPreferencesManager = SharedPreferencesManager.getInstance(mockSharedPreferences);
  });

  test(
    'Make sure isKeyExists can check availability a value from SharedPreferences',
    () async {
      // arrange
      when(mockSharedPreferences.containsKey(any)).thenReturn(true);

      // act
      final result = sharedPreferencesManager.isKeyExists(tKey);

      // assert
      expect(result, true);
      verify(mockSharedPreferences.containsKey(tKey)).called(1);
    },
  );

  test(
    'Make sure clearKey can remove a value from SharedPreferences',
    () async {
      // arrange
      when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);

      // act
      final result = await sharedPreferencesManager.clearKey(tKey);

      // assert
      expect(result, true);
      verify(mockSharedPreferences.remove(tKey)).called(1);
    },
  );

  test(
    'Make sure clearAll can remove all values from SharedPreferences',
    () async {
      // arrange
      when(mockSharedPreferences.clear()).thenAnswer((_) async => true);

      // act
      final result = await sharedPreferencesManager.clearAll();

      // assert
      expect(result, true);
      verify(mockSharedPreferences.clear()).called(1);
    },
  );

  group('bool', () {
    const tValue = true;

    test(
      'Make sure putBool can save a boolean value to SharedPreferences',
      () async {
        // arrange
        when(mockSharedPreferences.setBool(any, any)).thenAnswer((_) async => true);

        // act
        final result = await sharedPreferencesManager.putBool(tKey, tValue);

        // assert
        expect(result, true);
        verify(mockSharedPreferences.setBool(tKey, tValue)).called(1);
      },
    );

    test(
      'Make sure getBool can return a boolean value from SharedPreferences',
      () async {
        // arrange
        when(mockSharedPreferences.containsKey(any)).thenReturn(true);
        when(mockSharedPreferences.getBool(any)).thenReturn(tValue);

        // act
        final result = sharedPreferencesManager.getBool(tKey);

        // assert
        expect(result, tValue);
        verify(mockSharedPreferences.containsKey(tKey)).called(1);
        verify(mockSharedPreferences.getBool(tKey)).called(1);
      },
    );
  });

  group('double', () {
    const tValue = 0.0;

    test(
      'Make sure putDouble can save a double value to SharedPreferences',
      () async {
        // arrange
        when(mockSharedPreferences.setDouble(any, any)).thenAnswer((_) async => true);

        // act
        final result = await sharedPreferencesManager.putDouble(tKey, tValue);

        // assert
        expect(result, true);
        verify(mockSharedPreferences.setDouble(tKey, tValue));
      },
    );

    test(
      'Make sure getDouble can return a double value from SharedPreferences',
      () async {
        // arrange
        when(mockSharedPreferences.containsKey(any)).thenReturn(true);
        when(mockSharedPreferences.getDouble(any)).thenReturn(tValue);

        // act
        final result = sharedPreferencesManager.getDouble(tKey);

        // assert
        expect(result, tValue);
        verify(mockSharedPreferences.containsKey(tKey)).called(1);
        verify(mockSharedPreferences.getDouble(tKey)).called(1);
      },
    );
  });

  group('int', () {
    const tValue = 0;

    test(
      'Make sure putInt can save a integer value to SharedPreferences',
      () async {
        // arrange
        when(mockSharedPreferences.setInt(any, any)).thenAnswer((_) async => true);

        // act
        final result = await sharedPreferencesManager.putInt(tKey, tValue);

        // assert
        expect(result, true);
        verify(mockSharedPreferences.setInt(tKey, tValue)).called(1);
      },
    );

    test(
      'Make sure getInt can return a integer value from SharedPreferences',
      () async {
        // arrange
        when(mockSharedPreferences.containsKey(any)).thenReturn(true);
        when(mockSharedPreferences.getInt(any)).thenReturn(tValue);

        // act
        final result = sharedPreferencesManager.getInt(tKey);

        // assert
        expect(result, tValue);
        verify(mockSharedPreferences.containsKey(tKey)).called(1);
        verify(mockSharedPreferences.getInt(tKey)).called(1);
      },
    );
  });

  group('string', () {
    const tValue = 'string';

    test(
      'Make sure putString can save a string value to SharedPreferences',
      () async {
        // arrange
        when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);

        // act
        final result = await sharedPreferencesManager.putString(tKey, tValue);

        // assert
        expect(result, true);
        verify(mockSharedPreferences.setString(tKey, tValue)).called(1);
      },
    );

    test(
      'Make sure getString can return a string value from SharedPreferences',
      () async {
        // arrange
        when(mockSharedPreferences.containsKey(any)).thenReturn(true);
        when(mockSharedPreferences.getString(any)).thenReturn(tValue);

        // act
        final result = sharedPreferencesManager.getString(tKey);

        // assert
        expect(result, tValue);
        verify(mockSharedPreferences.containsKey(tKey)).called(1);
        verify(mockSharedPreferences.getString(tKey)).called(1);
      },
    );
  });

  group('list string', () {
    const tValue = <String>['string'];

    test(
      'Make sure putStringList can save a list string value to SharedPreferences',
      () async {
        // arrange
        when(mockSharedPreferences.setStringList(any, any)).thenAnswer((_) async => true);

        // act
        final result = await sharedPreferencesManager.putStringList(tKey, tValue);

        // assert
        expect(result, true);
        verify(mockSharedPreferences.setStringList(tKey, tValue)).called(1);
      },
    );

    test(
      'Make sure getStringList can return a string list value from SharedPreferences',
      () async {
        // arrange
        when(mockSharedPreferences.containsKey(any)).thenReturn(true);
        when(mockSharedPreferences.getStringList(any)).thenReturn(tValue);

        // act
        final result = sharedPreferencesManager.getStringList(tKey);

        // assert
        expect(result, tValue);
        verify(mockSharedPreferences.containsKey(tKey)).called(1);
        verify(mockSharedPreferences.getStringList(tKey)).called(1);
      },
    );
  });
}
