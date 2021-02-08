import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user_model.dart';
import 'package:flutter_firebase/providers/home_provider.dart';
import 'package:flutter_firebase/widgets/chat_widget.dart';
import 'package:flutter_firebase/widgets/oops_widget.dart';
import 'package:flutter_firebase/widgets/scaffold_widget.dart';

class HomePage extends StatefulWidget {
  static String route = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeProvider _provider;

  @override
  void didChangeDependencies() {
    _provider = HomeProvider.unListen(context);
    _provider.getToken();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          HomeProvider.unListen(context).logout();

          Navigator.pop(context);

          return true;
        },
        child: ScaffoldWidget(
          body: StreamBuilder(
            stream: _provider.allUserStream,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return OopsWidget(
                  message: snapshot.error.toString(),
                );

              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );

              final List<UserModel> users = snapshot.data.docs
                  .map<UserModel>((object) => UserModel.fromJson(object.data()))
                  .toList();

              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) =>
                      ChatWidget(users[index], TextEditingController()));
            },
          ),
          title: "Halaman Chats",
        ));
  }
}
