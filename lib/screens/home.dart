import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  final VoidCallback toggleTheme;

  Home({required this.toggleTheme, super.key});

  @override
  State<Home> createState() => _HomeState();
}

bool iconBool = false;

IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();

  List<ToDo> _foundToDo = [];
  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : tdBGColor,
      appBar: _appBar(isDarkMode),
      body: _body(isDarkMode),
    );
  }

  AppBar _appBar(bool isDarkMode) {
    return AppBar(
      backgroundColor: isDarkMode ? Colors.black : tdBGColor,
      elevation: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5.0, top: 7),
            height: 40.0,
            width: 40.0,
            child: ClipOval(
              child: Image.asset('lib/assets/images/vishnu.png'),
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              widget.toggleTheme();
              setState(() {
                iconBool = !iconBool;
              });
            },
            icon: Icon(iconBool ? iconDark : iconLight),
          ),
        ),
      ],
    );
  }

  Container _body(bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          _searchBar(isDarkMode),
          _toDos(isDarkMode),
          _addTask(isDarkMode),
        ],
      ),
    );
  }

  Container _searchBar(bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(
            Icons.search,
            color: isDarkMode ? Colors.white : tdBlack,
          ),
          filled: true,
          fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Expanded _toDos(bool isDarkMode) {
    return Expanded(
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50, bottom: 20),
            child: Text(
              'All ToDos',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          for (ToDo todoo in _foundToDo.reversed)
            TodoItem(
                todo: todoo, onDeleteItem: _deleteItem, isDarkMode: isDarkMode),
        ],
      ),
    );
  }

  Align _addTask(bool isDarkMode) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 20.0, right: 20.0, left: 6.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[900] : Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _todoController,
                decoration: InputDecoration(
                  hintText: 'Add a new Todo Item',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.white54 : Colors.black54,
                  ),
                ),
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                _addToDoItem(_todoController.text);
              },
              child: Text('+',
                  style: TextStyle(fontSize: 40.0, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: tdBlue,
                  minimumSize: Size(60, 60),
                  elevation: 10),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }
}
