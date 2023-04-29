import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_mvvm/models/todo_model.dart';

final todoProvider = AsyncNotifierProvider.autoDispose<TodoViewModel, List<TodoModel>>(()=> TodoViewModel());

class TodoViewModel extends AutoDisposeAsyncNotifier<List<TodoModel>> {
  List<TodoModel> todoList = <TodoModel>[];

  @override
  Future<List<TodoModel>> build(){
    return Future.delayed(const Duration(seconds: 3), () => fetchTodo());
  }

  Future<List<TodoModel>> fetchTodo() async {
    return todoList;
  }

  Future<void> addTodo(TodoModel todoModel)async{
    state = const AsyncValue.loading();
    state = await AsyncValue.guard((){
      todoList.add(todoModel);
      return Future.delayed(const Duration(seconds: 3), () => fetchTodo());
    });
  }

  Future<void> updateTodo(TodoModel todoModel)async{
    state = const AsyncValue.loading();
    state = await AsyncValue.guard((){
      todoList.where((element) => element.id == todoModel.id).first.title = todoModel.title;
      return Future.delayed(const Duration(seconds: 3), () => fetchTodo());
    });
  }

  Future<void> deleteTodo(int id)async{
    state = const AsyncValue.loading();
    state = await AsyncValue.guard((){
      todoList.removeWhere((element) => element.id == id);
      return Future.delayed(const Duration(seconds: 3), () => fetchTodo());
    });
  }
}
