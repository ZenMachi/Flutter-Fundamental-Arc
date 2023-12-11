import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  const CustomScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            body,
            _buildShortAppBar(context)
          ],
        ),
      ),
    );
  }

  Card _buildShortAppBar(BuildContext context) {
    return Card(
            margin: const EdgeInsets.all(0),
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16.0)
              )
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text(
                    'N',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
              ],
            ),
          );
  }
}
