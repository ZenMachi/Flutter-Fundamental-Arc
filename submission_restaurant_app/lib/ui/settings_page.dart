import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:submission_restaurant_app/provider/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Settings',
                    style: Theme.of(context).textTheme.displayMedium?.apply(
                        color: Theme.of(context).colorScheme.onBackground)),
                SizedBox(height: 8.h),
                Column(
                  children: [
                    ListTile(
                      title: const Text('Dark Theme'),
                      trailing: Switch.adaptive(
                          value: Provider.of<ThemeProvider>(context).isDark,
                          onChanged: (value) =>
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .toggleTheme(value)),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
