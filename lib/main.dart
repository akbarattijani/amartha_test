import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/main_controller.dart';

/*
  @author AKBAR <akbar.attijani@gmail.com>
 */

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            getPages: [
                GetPage(name: '/', page: () => MyHomePage(), binding: MainBinding()),
            ]
        );
    }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {

    @override
    State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    final MainController _mainController = Get.find<MainController>();
  
    List<Widget> _generateItemsWidget(BuildContext context) {
        List<Widget> widgets = [];

        _mainController.value.forEach((key, value) {
            widgets.add(
                Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: GestureDetector(
                        onTap: () {
                            if (_mainController.data[key] == MainController.ACTIVE) {
                                _mainController.inactiveItem(key);
                            } else {
                                _mainController.removeItem(key);
                            }
                        },
                        child: Row(
                            children: [
                                Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blueAccent
                                    ),
                                    child: Center(
                                        child: Text(
                                            _mainController.value[key]!.substring(0, 1),
                                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                        _mainController.value[key]!,
                                        style: TextStyle(
                                            color: _mainController.data[key] == MainController.ACTIVE ? Colors.black : Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            decoration: _mainController.data[key] == MainController.ACTIVE ? TextDecoration.none : TextDecoration.lineThrough),
                                    ),
                                )
                            ],
                        ),
                    )
                )
            );
        });

        return widgets;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Todo list'),
            ),
            body: Obx(() =>
                ListView(
                    padding: const EdgeInsets.all(8),
                    children: _generateItemsWidget(context)
                )
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    TextEditingController input = TextEditingController();

                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                            title: const Text("Add new todo item"),
                            titlePadding: const EdgeInsets.all(16),
                            contentPadding: const EdgeInsets.all(16),
                            content: TextFormField(
                                controller: input,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 12),
                                    counterText: "",
                                    hintText: 'Type your new todo',
                                    hintStyle: TextStyle(fontSize: 15, color: Color(0xFF9E9D9D)),
                                    fillColor: Colors.transparent,
                                    filled: true,
                                ),
                            ),
                            actions: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: GestureDetector(
                                        onTap: () {
                                            _mainController.addItems(_mainController.data.isEmpty ? 0 : _mainController.data.length + 1, input.text);
                                            Navigator.pop(context);
                                        },
                                        child: const Text(
                                            'Add',
                                            style: TextStyle(color: Colors.blue, fontSize: 16),
                                        ),
                                    )
                                )
                            ],
                        ),
                    );
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
            ),
        );
    }
}
