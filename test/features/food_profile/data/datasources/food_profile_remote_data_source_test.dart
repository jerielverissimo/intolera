import '../../../../fixtures/fixture_reader.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:intolera/features/text_recognition/data/datasources/food_profile_remote_data_source.dart';
import 'package:intolera/features/text_recognition/data/transforms/food_profile_transform.dart';
import 'package:intolera/features/text_recognition/data/models/food_profile_model.dart';
import 'package:intolera/core/error/exceptions.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  FoodProfileRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('food_profiles_cached.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong!', 404));
  }

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = FoodProfileRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getFoodProfiles', () {
    final jsonDecoded = json.decode(fixture('food_profiles_cached.json'));
    final tProfiles = FoodProfileTransform.fromListJson(jsonDecoded);

    test('''should perfrom a GET request on a URL 
          being the endpoint and with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSource.getFoodProfiles();
      // assert
      verify(mockHttpClient.get('http://134.209.41.142/profiles',
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return a profile list when the response code is 200 (success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSource.getFoodProfiles();
      // assert
      expect(result, equals(tProfiles));
    });

    test(
        'should throw a ServiceException when the response code is 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getFoodProfiles;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getFoodProfileFrom', () {
    final tCategory = 'trigo';
    final tFoodProfile =
        FoodProfileModel.fromJson(json.decode(fixture('food_profile.json')));

    test('''should perfrom a GET request on a URL with category 
          being the endpoint and with application/json header''', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('food_profile.json'), 200));
      // act
      dataSource.getFoodProfileFrom(tCategory);
      // assert
      verify(mockHttpClient.get('http://134.209.41.142/$tCategory',
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return a profile when the response code is 200 (success)',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('food_profile.json'), 200));
      // act
      final result = await dataSource.getFoodProfileFrom(tCategory);
      // assert
      expect(result, equals(tFoodProfile));
    });
    test(
        'should throw a ServiceException when the response code is 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getFoodProfileFrom;
      // assert
      expect(() => call(tCategory), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
