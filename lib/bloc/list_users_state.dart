part of 'list_users_bloc.dart';

abstract class ListUsersState extends Equatable {
  const ListUsersState();
  @override
  List<Object> get props => [];
}

class ListUsersLoading extends ListUsersState {}

class ListUsersMoreLoading extends ListUsersState {}

class ListUsersLoaded extends ListUsersState {
  final List<UserModel> data;
  final int count;
  final int page;

  ListUsersLoaded({@required this.data, @required this.count, @required this.page});
  @override
  List<Object> get props => [data, count, page];
}

class ListUsersError extends ListUsersState {
  final String message;

  ListUsersError({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ListUsersError(message: $message)';
}
