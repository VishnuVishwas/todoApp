import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Access the todo items from todo_tiems
  final todosList = ToDo.todoList();
  // to capture the typing
  final _todoController = TextEditingController();

  // search list
  List<ToDo> _foundToDo = [];
  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdBlack, size: 30),
          // insert pfp
          Container(
            height: 40.0,
            width: 40.0,
            // circular pfp
            child: ClipOval(
              child: Image.asset('lib/assets/images/vishnu.png'),
            ),
          ),
        ],
      ),
    );
  }

  // body
  Container _body() {
    return Container(
      // column
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          _searchBar(),
          _toDos(),
          _addTask(),
        ],
      ),
    );
  }

  // Search Bar
  Container _searchBar() {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // todo List
  Expanded _toDos() {
    return Expanded(
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50, bottom: 20),
            child: Text(
              'All ToDos',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
            ),
          ),

          // in todo_item file
          for (ToDo todoo in _foundToDo.reversed)
            TodoItem(todo: todoo, onDeleteItem: _deleteItem),
        ],
      ),
    );
  }

  // _addTask
  Align _addTask() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 20.0, right: 20.0, left: 6.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
                // capture the entered text
                controller: _todoController,
                decoration: InputDecoration(
                    hintText: 'Add a new Todo Item', border: InputBorder.none),
              ),
            ),
          ),

          // add tas button
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

  // delete item
  void _deleteItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  // add todo item
  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    _todoController.clear();
  }

  // search items
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
