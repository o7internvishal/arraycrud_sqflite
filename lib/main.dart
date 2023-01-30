import 'package:arraycrud_sqflite/user.dart';
import 'package:arraycrud_sqflite/user_repository.dart';
import 'package:flutter/material.dart';

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
  void addUser(User user) {
    setState(() {
      userlist.addAll(userRepository.getUser());
    
     
      
    });
  }
 @override
  void initState() {
    
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  void showuserDialog() {
    TextEditingController nameController = new TextEditingController();
    TextEditingController addressController = new TextEditingController();

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
                    await userRepository.insert(
                        User(nameController.text, addressController.text));    
                        userlist.add(User(nameController.text, addressController.text));
                         
                    // addUser(User(nameController.text, addressController.text));
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
                      userlist[index].name,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue),
                    ),
                    subtitle: Text(
                      userlist[index].address,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue),
                    ),
                  )
                  );
                }  
)
                )
        );
  }
}
