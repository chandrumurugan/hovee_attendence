import 'package:flutter/material.dart';

class SearchfiltertabBar extends StatefulWidget {
  const SearchfiltertabBar(
      {super.key,
      required this.title,
      required this.searchOnTap,
      required this.filterOnTap});
  final String title;
  final VoidCallback searchOnTap;
  final VoidCallback filterOnTap;

  @override
  State<SearchfiltertabBar> createState() => _SearchfiltertabBarState();
}

class _SearchfiltertabBarState extends State<SearchfiltertabBar> {
  // String _selectedStatus = 'Pending';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: widget.searchOnTap,
                child: Image.asset(
                  'assets/icons8-search-48.png',
                  height: 30,
                ),
              ),
              IconButton(
                  onPressed: () {
                    widget.filterOnTap();
                  },
                  icon: const Icon(
                    Icons.filter_list_outlined,
                    size: 25,
                    color: Colors.black,
                  )),
            ],
          ),
        ],
      ),
    );
  }

}