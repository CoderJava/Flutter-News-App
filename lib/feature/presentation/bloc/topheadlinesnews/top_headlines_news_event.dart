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