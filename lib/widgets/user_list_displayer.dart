import 'package:flutter/material.dart';
import 'package:healty/model/user.dart';

class UserListWidget extends StatelessWidget {
  final User user;

  UserListWidget(this.user);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(96, 110, 110, 120),
                  blurRadius: 6,
                  offset: Offset(4, 4),
                )
              ],
              borderRadius: BorderRadius.circular(6)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username.toString(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              )),
            ],
          )),
    );
  }
}
