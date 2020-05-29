import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TopHeadlinesNewsEvent extends Equatable {
  const TopHeadlinesNewsEvent();
}

class LoadTopHeadlinesNewsEvent extends TopHeadlinesNewsEvent {
  final String category;

  LoadTopHeadlinesNewsEvent({@required this.category});

  @override
  List<Object> get props => [category];

  @override
  String toString() {
    return 'LoadTopHeadlinesNewsEvent{category: $category}';
  }
}

class ChangeCategoryTopHeadlinesNewsEvent extends TopHeadlinesNewsEvent {
  final int indexCategorySelected;

  ChangeCategoryTopHeadlinesNewsEvent({@required this.indexCategorySelected});

  @override
  List<Object> get props => [indexCategorySelected];

  @override
  String toString() {
    return 'ChangeCategoryTopHeadlinesNewsEvent{indexCategorySelected: $indexCategorySelected}';
  }
}

class SearchTopHeadlinesNewsEvent extends TopHeadlinesNewsEvent {
  final String keyword;

  SearchTopHeadlinesNewsEvent({@required this.keyword});

  @override
  List<Object> get props => [keyword];

  @override
  String toString() {
    return 'SearchTopHeadlinesNewsEvent{keyword: $keyword}';
  }
}