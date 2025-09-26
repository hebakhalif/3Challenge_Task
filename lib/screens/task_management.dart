import 'package:flutter/material.dart';

class TaskManagement extends StatefulWidget {
  @override
  TaskManagementState createState() => TaskManagementState();
}

class TaskManagementState extends State<TaskManagement> {
  List<String> tasks = [
    "Complete Flutter assignment",
    "Reciew Clean Architecture",
    "3",
  ];
  String? _recentlyDeleted;
  int? _recentlyDeletedIndex;
  List<bool> isChecked = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Task Manager"),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) newIndex--;
            final item = tasks.removeAt(oldIndex);
            tasks.insert(newIndex, item);
          },
          children: [
            for (int index = 0; index < tasks.length; index++)
              Dismissible(
                key: ValueKey(tasks[index]),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder:
                        (ctx) => AlertDialog(
                          title: Text("Confiem Delete"),
                          content: Text("Delete '${tasks[index]}'?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(false),
                              child: Text("cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(true),
                              child: Text("Delete"),
                            ),
                          ],
                        ),
                  );
                },
                onDismissed: (direction) {
                  setState(() {
                    _recentlyDeleted = tasks[index];
                    _recentlyDeletedIndex = index;
                    tasks.removeAt(index);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Task deleted"),
                      action: SnackBarAction(
                        label: "Undo",
                        onPressed: () {
                          if (_recentlyDeleted != null && _recentlyDeletedIndex != null) {
                            setState(() {
                              tasks.insert(
                                _recentlyDeletedIndex!,
                                _recentlyDeleted!,
                              );
                            });
                          }
                        },
                      ),
                    ),
                  );
                },

                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 340,
                  height: 60,
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 191, 178, 229),
                  ),

                  child: ListTile(
                    
                    leading: ReorderableDragStartListener(
                      index: index,
                      child: Icon(Icons.drag_handle),
                    ),

                    trailing: Checkbox(
                      value: isChecked[index],
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked[index] = value ?? false;
                        });
                      },
                    ),
                    title: Text(tasks[index],
                    style: TextStyle(
                      decoration: isChecked[index]?TextDecoration.lineThrough:TextDecoration.none
                    ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
