import 'package:flutter/material.dart';

class SearchBarRestaurant extends StatefulWidget {
  final Function(String) onSubmitted;

  const SearchBarRestaurant({super.key, required this.onSubmitted});

  @override
  State<SearchBarRestaurant> createState() => _SearchBarRestaurantState();
}

class _SearchBarRestaurantState extends State<SearchBarRestaurant> {
  FocusNode searchFocus = FocusNode();
  final SearchController _searchController = SearchController();
  String searchString = '';
  String queryString = '';

  @override
  Widget build(BuildContext context) {
    final iconSearch = searchFocus.hasPrimaryFocus
        ? const Icon(Icons.clear)
        : const Icon(Icons.search);

    return SearchBar(
      focusNode: searchFocus,
      controller: _searchController,
      elevation: MaterialStateProperty.all(1),
      hintText: 'Search Restaurant',
      onChanged: (value) {
        setState(() {
          searchString = value;
        });
      },
      onSubmitted: (query) {
        widget.onSubmitted(query);
      },
      trailing: [
        IconButton(
          icon: iconSearch,
          onPressed: () {
            setState(() {
              searchString = '';
              _searchController.clear();
              searchFocus.unfocus();
            });
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
