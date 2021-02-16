part of 'list_users_bloc.dart';

abstract class ListUsersEvent extends Equatable {
  const ListUsersEvent();

  @override
  List<Object> get props => [];
}

class GetListUsers extends ListUsersEvent {

}

class GetMoreListUsers extends ListUsersEvent {
  final int page;

  GetMoreListUsers({@required this.page});

  @override
  List<Object> get props => [page];
}
