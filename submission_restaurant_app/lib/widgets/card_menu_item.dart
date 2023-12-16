import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  final String menuName;

  CardMenu({super.key, required this.menuName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // SizedBox(width: 24,),
                  Icon(
                    Icons.fastfood,
                    size: 56,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menuName,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
