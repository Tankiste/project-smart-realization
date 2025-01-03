// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/model/add_user.dart';
import 'package:smart_home/model/auth/auth_service.dart';
import 'package:smart_home/model/auth/user_data.dart';
import 'package:smart_home/model/rooms/app_state.dart';
import 'package:smart_home/view/login.dart';

class HomePage extends StatefulWidget {
  final String? username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService _authService = AuthService();
  final List<Map<String, dynamic>> _containers = [
    {'icon': Icons.chair_outlined, 'label': 'Living room'},
    {'icon': Icons.kitchen_outlined, 'label': 'Kitchen'},
    {'icon': Icons.bedroom_parent_outlined, 'label': 'Bedroom'},
    {'icon': Icons.garage_outlined, 'label': 'Garage'},
  ];

  final List<Map<String, dynamic>> _equipments = [
    {'icon': Icons.lightbulb_outline, 'label': 'Lightning'},
    {'icon': Icons.air_outlined, 'label': 'Air Conditionner'},
    {'icon': Icons.sunny_snowing, 'label': 'Heater'},
  ];
  List<UserData> users = [];

  int _selectedRoom = 0;

  List<bool> _switchLivingRoom = [false, false, false];

  bool _switchKitchen = false;

  bool _switchBedRoom = false;

  bool _switchGarage = false;

  @override
  void initState() {
    super.initState();
    updateData();
    // Future.microtask(() => initializeData());
  }

  // Future<void> initializeData() async {
  //   await updateData();
  //   await fetchUsers();
  // }

  void _changeRoom(int index) {
    setState(() {
      _selectedRoom = index;
    });
  }

  Future<void> updateData() async {
    try {
      final appState = Provider.of<ApplicationState>(context, listen: false);
      await appState.refreshUser();
      await fetchUsers();
      print('UpdateData completed');
    } catch (e) {
      print('Error in updateData: $e');
    }
  }

  // Future<void> fetchUsers() async {
  //   try {
  //     List<DocumentSnapshot> userDocs = await _authService.getUsers();
  //     setState(() {
  //       users = userDocs.map((doc) => UserData.fromSnap(doc)).toList();
  //     });
  //     print(users);
  //   } catch (e) {
  //     print('Error fetching users: $e');
  //   }
  // }

  Future<void> fetchUsers() async {
    try {
      ApplicationState appState =
          Provider.of<ApplicationState>(context, listen: false);
      await appState.fetchUsers();
      setState(() {
        users = appState.getUsers;
      });
      print(users);
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  signoutUser() async {
    ApplicationState appState = Provider.of(context, listen: false);
    await appState.logoutUser(context);
    await _authService.logout();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false);
  }

  Widget _firstIndexContent() {
    var ht = MediaQuery.of(context).size.height;
    var wt = MediaQuery.of(context).size.width;
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 25,
      crossAxisSpacing: 25,
      childAspectRatio: 0.88,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(3, (index) {
        return Container(
          height: ht * 0.4,
          width: wt * 0.2,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFE0C3), Color(0xFF6EFFBD)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(4, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFBC74),
                ),
                child: Icon(
                  _equipments[index]['icon'],
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: ht * 0.026,
              ),
              Text(
                _equipments[index]['label'],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: ht * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _switchLivingRoom[index] ? 'ON' : 'OFF',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Switch(
                    value: _switchLivingRoom[index],
                    onChanged: (bool value) {
                      setState(
                        () {
                          _switchLivingRoom[index] = value;
                        },
                      );
                    },
                    activeColor: Color(0xFFFFEBDC),
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _secondIndexContent(
      bool bulbState, void Function(bool) onSwitchChanged) {
    var ht = MediaQuery.of(context).size.height;
    var wt = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 23, bottom: ht * 0.3),
      child: Container(
        height: ht * 0.1,
        width: wt * 0.43,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE0C3), Color(0xFF6EFFBD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(4, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFBC74),
              ),
              child: Icon(
                Icons.lightbulb_outline,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: ht * 0.027,
            ),
            Text(
              'Lightning',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: ht * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  bulbState ? 'ON' : 'OFF',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Switch(
                  value: bulbState,
                  onChanged: onSwitchChanged,
                  activeColor: Color(0xFFFFEBDC),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _selectContentByIndex() {
    switch (_selectedRoom) {
      case 0:
        return _firstIndexContent();
      case 1:
        return _secondIndexContent(_switchKitchen, (bool value) {
          setState(() {
            _switchKitchen = value;
          });
        });
      case 2:
        return _secondIndexContent(_switchBedRoom, (bool value) {
          setState(() {
            _switchBedRoom = value;
          });
        });
      case 3:
        return _secondIndexContent(_switchGarage, (bool value) {
          setState(() {
            _switchGarage = value;
          });
        });
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wt = MediaQuery.of(context).size.width;
    // final userData = Provider.of<ApplicationState>(context).getUser;
    // final username = userData?.name ?? 'Guest';
    return Scaffold(
      backgroundColor: Color(0xFFFFF8EC),
      body: SingleChildScrollView(
        child: Container(
          width: wt,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: ht * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logo.png', width: 350),
              SizedBox(
                height: ht * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi ${widget.username}!',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 5,
                                  offset: Offset(1, 3))
                            ]),
                        child: Icon(Icons.thermostat_outlined),
                      ),
                      SizedBox(
                        width: wt * 0.02,
                      ),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '20°C',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16),
                          ),
                          Text(
                            'Current',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: ht * 0.012,
              ),
              Text(
                'Welcome to your Smart Home',
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: ht * 0.045,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _containers.map((container) {
                  int index = _containers.indexOf(container);
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => _changeRoom(index),
                        child: Container(
                          // padding: EdgeInsets.all(17),
                          width: wt * 0.19,
                          height: ht * 0.09,
                          decoration: BoxDecoration(
                              color: _selectedRoom == index
                                  ? Color(0xFFBD8D73)
                                  : Color(0xFFFFF8EC),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300)),
                          child: Icon(
                            container['icon'],
                            color: _selectedRoom == index
                                ? Colors.white
                                : Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ht * 0.01,
                      ),
                      Text(
                        container['label'],
                        style: TextStyle(
                            // color: Colors.grey.shade600,
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  );
                }).toList(),
              ),
              SizedBox(
                height: ht * 0.07,
              ),
              Text(
                'Devices',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              // SizedBox(
              //   height: ht * 0.02,
              // ),
              SizedBox(
                  height: ht * 0.58,
                  child: Expanded(child: _selectContentByIndex())),
              SizedBox(
                height: ht * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Users',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddUserForm();
                            });
                      },
                      child: Text('Add Users',
                          style: TextStyle(
                              color: Color(0xFFC4987D),
                              fontWeight: FontWeight.bold,
                              fontSize: 20)))
                ],
              ),
              SizedBox(
                height: ht * 0.03,
              ),
              Container(
                width: wt * 0.9,
                padding: EdgeInsets.only(top: 10, bottom: 15),
                decoration: BoxDecoration(
                  color: Color(0xFFFFEBDC),
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 5,
                                        offset: Offset(1, 3))
                                  ]),
                              child: Icon(Icons.person_outlined),
                            ),
                            SizedBox(
                              width: wt * 0.02,
                            ),
                            Text(
                              'Username',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 5,
                                        offset: Offset(1, 3))
                                  ]),
                              child: Icon(Icons.thermostat_outlined),
                            ),
                            SizedBox(
                              width: wt * 0.02,
                            ),
                            Text(
                              'Ideal Temp.',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            )
                          ],
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey.shade700,
                      height: 20,
                    ),
                    Consumer<ApplicationState>(builder: (context, appState, _) {
                      return Container(
                        height: ht * 0.2,
                        width: wt * 0.8,
                        child: appState.getUsers.isEmpty
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: appState.getUsers.length,
                                itemBuilder: (context, index) {
                                  final user = appState.getUsers[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          user.name,
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          '${user.ideal_temperature}°C',
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                      );
                    })
                  ],
                ),
              ),
              SizedBox(
                height: ht * 0.07,
              ),
              ElevatedButton(
                  onPressed: signoutUser,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFCA99),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: wt * 0.32,
                          right: wt * 0.32,
                          top: ht * 0.017,
                          bottom: ht * 0.017),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
