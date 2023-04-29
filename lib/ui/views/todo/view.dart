import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_mvvm/models/todo_model.dart';
import 'package:riverpod_mvvm/ui/view_models/todo_view_model.dart';

class TodoView extends HookConsumerWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoId = useState(0);
    final todos = ref.watch(todoProvider);
    final textController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
            ),
            ElevatedButton(
                onPressed: () {
                  todoId.value == 0
                      ? ref
                          .read(todoProvider.notifier)
                          .addTodo(TodoModel(
                              id: todos.value!.length + 1,
                              title: textController.text))
                          .then((value) => textController.clear())
                      : ref
                          .read(todoProvider.notifier)
                          .updateTodo(TodoModel(
                              id: todoId.value, title: textController.text))
                          .then((value) {
                          textController.clear();
                          todoId.value = 0;
                        });
                },
                child: Text(todos.isLoading
                    ? 'Wait...'
                    : (todoId.value == 0 ? 'Add' : 'Update'))),
            const Divider(
              height: 15,
              color: Colors.grey,
              thickness: 1,
            ),
            todos.when(
                data: (data) => Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => ListTile(
                              leading: Text(data[index].title.toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        textController.text =
                                            data[index].title.toString();
                                        todoId.value = data[index].id!;
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        ref.read(todoProvider.notifier).deleteTodo(data[index].id!);
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            ))),
                error: (error, _) => Text(error.toString()),
                loading: () => const CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
