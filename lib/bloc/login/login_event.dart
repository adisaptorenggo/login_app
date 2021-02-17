part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({
    @required this.username,
    @required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginButtonPressed &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password;

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}

class LoggedIn extends LoginEvent {}

// abstract class LoginEvent extends Equatable {
//   const LoginEvent();

//   @override
//   List<Object> get props => [];
// }

// class LoginUsernameChanged extends LoginEvent {
//   const LoginUsernameChanged(this.username);

//   final String username;

//   @override
//   List<Object> get props => [username];
// }

// class LoginPasswordChanged extends LoginEvent {
//   const LoginPasswordChanged(this.password);

//   final String password;

//   @override
//   List<Object> get props => [password];
// }

// class LoginSubmitted extends LoginEvent {
//   const LoginSubmitted();
// }
