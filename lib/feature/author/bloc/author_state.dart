import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

class AuthorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdleState extends AuthorState {}

class AuthorsFetchingState extends AuthorState {}

class AuthorsFetchingFailedState extends AuthorState {
  final String errorMessage;

  AuthorsFetchingFailedState({required this.errorMessage});
}

class AuthorsFetchedState extends AuthorState {
  final Author author;

  AuthorsFetchedState({required this.author});
}
