import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healty/controller/admin_controller.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/model/user.dart';
import 'package:healty/widgets/user_details_widget.dart';
import 'package:healty/widgets/user_list_displayer.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<AdminController>().loadUserList();
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        appBar: AppBar(
          title: Text("Admin"),
          actions: [
            IconButton(
              onPressed: () {
                context.read<User>().logout();
                context.read<DietPageController>().logout();
              },
              icon: const Icon(Icons.logout),
              tooltip: "Logout",
            )
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Selector<AdminController, int>(
                          selector: (context, model) => model.countUsers,
                          builder: (context, value, _) {
                            debugPrint("Building Selector con ListView");
                            return ListView.builder(
                                itemCount: value,
                                itemBuilder: (context, index) {
                                  final item = context
                                      .read<AdminController>()
                                      .userList[index];
                                  //return Text(item.username!);

                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => UserDetailsWidget(user: item,)));
                                      },
                                      child: UserListWidget(item));
                                });
                          },
                        ),
                      ),
                      // const _LengthDisplayer(),
                    ])),
            // Selector<GalleryState, bool>(
            //   builder: (context, isLoading, _) {
            //     if (isLoading) {
            //       return Container(
            //         color: Colors.black26,
            //         child: const Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       );
            //     } else {
            //       return const SizedBox.shrink();
            //     }
            //   },
            //   selector: (context, state) => state.isLoading,
            // )
          ],
        ));
  }
}
