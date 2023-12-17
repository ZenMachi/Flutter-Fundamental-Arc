import 'package:flutter/material.dart';

class DoneModuleList extends StatelessWidget {
  final List<String> doneModuleList;

  const DoneModuleList({Key? key, required this.doneModuleList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Done Module List'),
      ),
      body: ListView.builder(
          itemCount: doneModuleList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(doneModuleList[index]),
            );
          }),
    );
  }
}
