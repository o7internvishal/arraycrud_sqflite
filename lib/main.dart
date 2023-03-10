import 'package:arraycrud_sqflite/user.dart';
import 'package:arraycrud_sqflite/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> userlist = [];

  UserRepository userRepository = UserRepository();
  //  late UserDAO userDAO;
  Database? database;

  void addUser(User user) {
    // setState(() {
    //   userlist.addAll(userRepository.getUser());
    // });
  }
  // void remove(User user) {
  //   setState(() {
  //     // userlist.remove(userlist(user));
  //   });
  // }

  void getUsers() async {
    final users = await userRepository.getUser();
    print(users);
    setState(() {
      userlist.clear();
      userlist.addAll(users);
    });
  }

  // void getUser() async {
  //   final users = await userRepository.getUser();
  //   setState((){
  //       userlist.remove(users);
  //     });
  // }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      createDatabaseAndGetUsers();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void createDatabaseAndGetUsers() async {
    await userRepository.createDatabase();
    getUsers();
  }

  void showuserDialog({bool isUpdate = false, int position = -1}) {
    TextEditingController nameController = new TextEditingController();
    TextEditingController addressController = new TextEditingController();
    if (isUpdate) {
      nameController.text = userlist[position].name;
      addressController.text = userlist[position].address;
    }
    showDialog(
        context: context,
        builder: (__) {
          return AlertDialog(
            content: Wrap(children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "name",
                  labelText: "name",
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: "address",
                  labelText: "address",
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (isUpdate == true) {
                      await userRepository.updateTask(
                          User(nameController.text, addressController.text));
                    } else {
                      await userRepository.insert(
                          User(nameController.text, addressController.text));
                    }
                    // User(nameController.text, addressController.text);
                    getUsers();

                    Navigator.of(context).pop();
                  },
                  child: const Text("Add"))
            ]),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: showuserDialog,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Container(
            child: ListView.builder(
                //  scrollDirection: Axis.horizontal,
                itemCount: userlist.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(
                      userlist[index].name.toString(),
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue),
                    ),
                    subtitle: Text(
                      userlist[index].address.toString(),
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue),
                    ),
                    trailing: Column(
                      children: [
                        GestureDetector(
                          child: const Icon(
                            Icons.edit,
                            color: Colors.red,
                          ),
                          onTap: () {
                            showuserDialog(position: index, isUpdate: true);
                            getUsers();
                          },
                        ),
                        GestureDetector(
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onTap: () async {
                            // userRepository.remove(userlist[index]);
                            await userRepository.remove(userlist[index]);
                            getUsers();
                          },
                        ),
                      ],
                    ),
                  ));
                })));
  }
}
