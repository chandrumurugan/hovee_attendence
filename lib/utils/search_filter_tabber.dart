import 'package:flutter/material.dart';

class SearchfiltertabBar extends StatefulWidget {
  const SearchfiltertabBar({
    super.key,
    required this.title,
    required this.onSearchChanged,
    required this.filterOnTap,
  });
  final String title;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback filterOnTap;

  @override
  State<SearchfiltertabBar> createState() => _SearchfiltertabBarState();
}

class _SearchfiltertabBarState extends State<SearchfiltertabBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: widget.onSearchChanged, // Calls the callback whenever text changes
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // IconButton(
              //   icon: Icon(Icons.filter_list),
              //   onPressed: widget.filterOnTap,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
