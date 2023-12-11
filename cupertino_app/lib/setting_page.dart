import 'package:flutter/cupertino.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Setting Page'),
        ),
        child: Center(
          child: CupertinoButton(
            child: const Text(
              'Log Out',
            ),
            onPressed: () {
              showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text('Are you sure to log out?'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('No'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CupertinoDialogAction(
                          child: const Text('Yes'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    );
                  });
            },
          ),
        ));
  }
}
