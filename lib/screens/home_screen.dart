import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:login_app/bloc/home/list_users_bloc.dart';
import 'package:login_app/screens/user_item.dart';
import 'package:login_app/model/user_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ListUsersBloc _bloc;
  int _currentLength;
  int _currentPage;
  List<UserModel> _data = [];

  void _loadMoreData() {
    _bloc.add(GetMoreListUsers(page: _currentPage));
  }

  @override
  void initState() {
    print('Init State');
    _bloc = BlocProvider.of<ListUsersBloc>(context);
    _bloc.add(GetListUsers());
    print('Init Bloc');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Users'),
      ),
      body: BlocBuilder<ListUsersBloc, ListUsersState>(
        builder: (context, state) {
          if (state is ListUsersLoaded || state is ListUsersMoreLoading) {
            if (state is ListUsersLoaded) {
              print('Loaded');
              _data = state.data;
              _currentLength = state.count;
              _currentPage = state.page;
            }
            return _buildListUsers(state);
          } else if (state is ListUsersLoading) {
            // print('Loading');
            return Center(child: CircularProgressIndicator());
          } else if(state is ListUsersError){
            return Text(state.message);
          } else{
            return Text('Unidentified Error');
          }
        },
      ),
    );
  }

  Widget _buildListUsers(ListUsersState state) {
    return LazyLoadScrollView(
      child: ListView(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: _data.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) {
                return UserItem(data: _data[i]);
              }),
          // Loading indicator more load data
          (state is ListUsersMoreLoading)
              ? Center(child: CircularProgressIndicator())
              : SizedBox(),
        ],
      ),
      onEndOfPage: _loadMoreData,
    );
  }
}