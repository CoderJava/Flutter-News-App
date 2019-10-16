import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_news_app/src/api/api_repository.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';

abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataSuccess extends DataState {
  final ResponseTopHeadlinesNews data;

  DataSuccess(this.data);
}

class DataFailed extends DataState {
  final String errorMessage;

  DataFailed(this.errorMessage);
}

class DataEvent {
  final String category;

  DataEvent(this.category);
}

class HomeBloc extends Bloc<DataEvent, DataState> {
  @override
  DataState get initialState => DataInitial();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    yield DataLoading();
    final apiRepository = ApiRepository();
    final categoryLowerCase = event.category.toLowerCase();
    switch (categoryLowerCase) {
      case 'all':
        final data = await apiRepository.fetchTopHeadlinesNews();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Failed to fetch data');
        }
        break;
      case 'business':
        // TODO: do something in here
        break;
      case 'entertainment':
        // TODO: do something in here
        break;
      case 'health':
        // TODO: do something in here
        break;
      case 'science':
        // TODO: do something in here
        break;
      case 'sport':
        // TODO: do something in here
        break;
      case 'technology':
        // TODO: do something in here
        break;
      default:
        yield DataFailed('Unknown category');
    }
  }
}
