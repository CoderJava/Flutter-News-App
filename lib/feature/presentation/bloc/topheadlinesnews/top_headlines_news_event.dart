import 'package:equatable/equatable.dart';

abstract class TopHeadlinesNewsEvent extends Equatable {
  const TopHeadlinesNewsEvent();

  @override
  List<Object> get props => [];
}

class LoadTopHeadlinesNewsEvent extends TopHeadlinesNewsEvent {}