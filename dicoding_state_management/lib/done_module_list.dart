import 'package:dicoding_state_management/done_module_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoneModuleList extends StatelessWidget {
  final List<String> doneModuleList;

  const DoneModuleList({Key? key, required this.doneModuleList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doneModuleList =
        Provider.of<DoneModuleProvider>(context, listen: false).doneModuleList;

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
