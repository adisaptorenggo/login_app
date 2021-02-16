import 'package:flutter/material.dart';
import 'package:login_app/model/user_model.dart';


class UserItem extends StatelessWidget {
  final UserModel data;

  const UserItem({Key key, @required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                '${data.avatar}',
                fit: BoxFit.cover,
                height: 100,
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.firstName + ' ' + data.lastName),
                  Text(data.email),
                ],
              ),
            ]),
      ),
    );
  }
}
