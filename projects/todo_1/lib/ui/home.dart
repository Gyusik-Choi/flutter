import 'package:flutter/material.dart';
import 'package:todo_1/bloc/todo_bloc.dart';
import 'package:todo_1/model/todo.dart';

class Home extends StatelessWidget {
  final TodoBloc _todoBloc = TodoBloc();
  final DismissDirection _dismissDirection = DismissDirection.horizontal;
  
  Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        // 호출을 해줘야 기존에 저장된 todo 를 불러올 수 있다
    _todoBloc.getTodos();

    return SafeArea(
      child: Scaffold(
        body: getTodosWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            elevation: 5.0,
            onPressed: () {
              _showAddTodoSheet(context);
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              size: 32,
              color: Colors.indigoAccent,
            ),
          ),
        )
      ) 
    );
  }

  Widget getTodosWidget() {
    return StreamBuilder(
      stream: _todoBloc.todos,
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapShot) {
        if (snapShot.hasData == false) {
          return const Center(
            child: Text('No Todos'),
          );
        }
        print('stream builder');
        print(snapShot.data![0].isDone);
        return snapShot.data!.isNotEmpty
          ? ListView.builder(
            itemCount: snapShot.data?.length,
            itemBuilder: (context, itemPosition) {
              Todo todo = snapShot.data![itemPosition];
              final Widget dismissibleCard = Dismissible(
                background: Container(
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Deleting",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  color: Colors.redAccent,
                ),
                onDismissed: (direction) {
                  /*The magic
                  delete Todo item by ID whenever
                  the card is dismissed
                  */
                  _todoBloc.deleteTodoById(todo.id ?? 0);
                },
                direction: _dismissDirection,
                key: ObjectKey(todo),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.grey, 
                      width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    leading: InkWell(
                      onTap: () async {
                        print('onTap');
                        print(todo.isDone);
                        //Reverse the value
                        todo.isDone = !todo.isDone;
                        print(todo.isDone);
                      /*
                        Another magic.
                        This will update Todo isDone with either
                        completed or not
                      */
                        await _todoBloc.updateTodo(todo);
                        print('home');
                        print(todo.isDone);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: todo.isDone
                          ? const Icon(
                              Icons.done,
                              size: 26.0,
                              color: Colors.indigoAccent,
                            )
                          : const Icon(
                              Icons.check_box_outline_blank,
                              size: 26.0,
                              color: Colors.tealAccent,
                            ),
                      ),
                    ),
                    title: Text(
                      todo.description ?? 'todo',
                      style: TextStyle(
                        fontSize: 16.5,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.w500,
                        decoration: todo.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none
                      ),
                    ),
                  )  
                ),
              );
              return dismissibleCard;
            },
          )
        : const Center(
          child: Text(
            "Start adding Todo...",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          ),
        );
      }
    );
  }

  void _showAddTodoSheet(BuildContext context) {
    final _todoDescriptionFormController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: Container(
            color: Colors.transparent,
            child: Container(
              height: 230,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15, top: 25.0, right: 15, bottom: 30
                ),
                child: ListView(
                  children: <Widget> [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget> [
                        Expanded(
                          child: TextFormField(
                            controller: _todoDescriptionFormController,
                            textInputAction: TextInputAction.newline,
                            maxLines: 4,
                            style: const TextStyle(
                              fontSize: 21, 
                              fontWeight: FontWeight.w400
                            ),
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: 'I have to...',
                              labelText: 'New Todo',
                              labelStyle: TextStyle(
                                color: Colors.indigoAccent,
                                fontWeight: FontWeight.w500
                              )
                            ),
                            validator: (String? value) {
                              if (value == null) {
                                return 'Empty description!';
                              }

                              return value.contains('')
                                ? 'Do not use the @ char.'
                                : null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 15),
                          child: CircleAvatar(
                            backgroundColor: Colors.indigoAccent,
                            radius: 18,
                            child: IconButton(
                              icon: const Icon(
                                Icons.save,
                                size: 22,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                final newTodo = Todo(
                                  description: _todoDescriptionFormController.value.text
                                );
                                
                                if (newTodo.description != null) {
                                  /*Create new Todo object and make sure
                                  the Todo description is not empty,
                                  because what's the point of saving empty
                                  Todo
                                  */
                                  _todoBloc.insertTodo(newTodo);

                                  //dismisses the bottomsheet
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}