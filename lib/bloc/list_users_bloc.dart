import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:login_app/model/user_model.dart';
import 'package:login_app/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'list_users_event.dart';
part 'list_users_state.dart';

class ListUsersBloc extends Bloc<ListUsersEvent, ListUsersState> {
  UserRepository _repository = UserRepository();
  List<UserModel> _data = [];
  int _currentLength;
  int _currentPage;
  bool _isLastPage;

  ListUsersBloc() : super(ListUsersLoading());

  @override
  Stream<Transition<ListUsersEvent, ListUsersState>> transformEvents(
      Stream<ListUsersEvent> events,
      TransitionFunction<ListUsersEvent, ListUsersState> transitionFn,
      ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ListUsersState> mapEventToState(
      ListUsersEvent event,
      ) async* {
    if (event is GetListUsers) {
      print('ListUsers');
      yield* _mapEventToStateListUsers(1);
    } else if (event is GetMoreListUsers) {
      print('ListMoreUsers');
      yield* _mapEventToStateListUsers(event.page);
    }
  }

  Stream<ListUsersState> _mapEventToStateListUsers(int page) async* {
    try {
      if (state is ListUsersLoaded) {
        _data = (state as ListUsersLoaded).data;
        _currentLength = (state as ListUsersLoaded).count;
        _currentPage = (state as ListUsersLoaded).page;
      }

      if (_currentLength != null) {
        yield ListUsersMoreLoading();
      } else {
        yield ListUsersLoading();
      }

      if (_currentLength == null || _isLastPage == null || !_isLastPage) {
        print('page: ' + page.toString());
        final reqData = await _repository.getUsers(page: page);

        if (reqData.isNotEmpty) {
          _data.addAll(reqData);
          if (_currentLength != null) {
            _currentLength += reqData.length;
            _currentPage = _currentPage + 1;
          } else {
            _currentLength = reqData.length;
            _currentPage = 2;
          }
        } else {
          _isLastPage = true;
        }
      }
      yield ListUsersLoaded(data: _data, count: _currentLength, page: _currentPage);
    } catch (e) {
      print(e.toString());
      yield ListUsersError(message: e.toString());
    }
  }
}
