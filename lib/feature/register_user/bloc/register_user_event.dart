import 'package:audio_books/models/user.dart';
import 'package:equatable/equatable.dart';

class RegisterUserEvent extends Equatable {
  final User user;

  RegisterUserEvent({required this.user});

  @override
  List<Object?> get props => [this.user];
}
