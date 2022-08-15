import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uidesign/userpage.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  @override
  Widget build(BuildContext context) {
    final name = "Steffano MN";
    final email = "steffanomarulin@gmail.com";
    final urlImage = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/FullMoon2010.jpg/220px-FullMoon2010.jpg";

    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          padding: padding,
          children: <Widget>[
            buildHeader(
                urlImage: urlImage,
                name: name,
                email: email,
                onClick: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => UserPage(
                            name: name,
                            urlImage: urlImage,
                          )));
                }),
            SizedBox(height: 20),
            buildMenuItem(
              text: "People",
              icon: Icons.people,
            ),
            SizedBox(height: 20),
            buildMenuItem(text: "Favorites", icon: Icons.favorite),
            SizedBox(height: 20),
            buildMenuItem(text: "Workflow", icon: Icons.workspaces_outline),
            SizedBox(height: 20),
            buildMenuItem(text: "Update", icon: Icons.update),
            SizedBox(height: 30),
            Divider(
              color: Colors.white70,
            ),
            SizedBox(height: 30),
            buildMenuItem(text: "Plugins", icon: Icons.workspaces_outline),
            SizedBox(height: 20),
            buildMenuItem(text: "Notifications", icon: Icons.update),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
    {required String text, required IconData icon, VoidCallback? onClick}) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: () {
        onClick;
      },
    );
  }

  selectedItem(BuildContext context, int i) {}

  buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClick,
  }) {
    return
    InkWell(
      onTap: onClick,
      child: Container(
        padding: padding.add(EdgeInsets.symmetric(vertical: 50)),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(urlImage),
            ),
            SizedBox( width: 20 ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  )
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  email,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
