import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'list_users_event.dart';
part 'list_users_state.dart';

class ListUsersBloc extends Bloc<ListUsersEvent, ListUsersState> {
  ListUsersBloc() : super(ListUsersInitial());

  @override
  Stream<ListUsersState> mapEventToState(
    ListUsersEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
