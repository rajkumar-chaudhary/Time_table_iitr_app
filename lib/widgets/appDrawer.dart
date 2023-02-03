import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screeens/admin_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _userenroll = 'Loading...';
  String _userName = 'unknown user';
  var _pinController = TextEditingController();
  var isAdmin = false;
  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  void _sumitPin() {
    var enteredPin = '';
    setState(() {
      enteredPin = _pinController.text;
    });
    if (enteredPin == '9988') {
      isAdmin = true;
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      Navigator.of(context).pushNamed(
        AdminPage.routeName,
      );

      _pinController.clear();
    }
    _pinController.clear();
  }

  Future<void> _getUserName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(await FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        _userenroll = value.data()!['enroll'].toString();
      });
    });
    // final user = await FirebaseAuth.instance.currentUser;
    // _userName = user!.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.grey,
              ),
              // borderRadius: BorderRadius.circular(6),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple.withOpacity(0.9),
                  Colors.purple.withOpacity(0.3),
                ],
              ),
            ),
            height: 100,
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.black87,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _userenroll,
                    style: TextStyle(
                      fontSize: 17,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
              leading: Icon(
                Icons.admin_panel_settings,
                size: 40,
                color: Colors.red,
              ),
              title: Text(
                'Change Schedule',
                style: TextStyle(fontSize: 17),
              ),
              subtitle: Text('Only for Admins and Crs !'),
              onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return ListView(
                      children: [
                        Container(
                          child: GestureDetector(
                            onTap: () {},
                            behavior: HitTestBehavior.opaque,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                label: Text('Enter Admin\'s Pin'),
                              ),
                              controller: _pinController,
                              onSubmitted: (_) => _sumitPin(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Icon(
                            Icons.admin_panel_settings,
                            size: 170,
                            color: Colors.redAccent,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _sumitPin(),
                          child: Text('Enter'),
                        )
                      ],
                    );
                  })),
          Spacer(),
          TextButton.icon(
            label: Text(
              'Logout',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: Icon(Icons.exit_to_app),
            onPressed: FirebaseAuth.instance.signOut,
          ),
        ],
      ),
    );
  }
}
