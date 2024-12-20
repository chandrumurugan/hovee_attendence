// import 'package:flutter/material.dart';

// class SearchfiltertabBar extends StatefulWidget {
//   const SearchfiltertabBar({
//     super.key,
//     required this.title,
//     required this.onSearchChanged,
//     required this.filterOnTap,
//   });
//   final String title;
//   final ValueChanged<String> onSearchChanged;
//   final VoidCallback filterOnTap;

//   @override
//   State<SearchfiltertabBar> createState() => _SearchfiltertabBarState();
// }

// class _SearchfiltertabBarState extends State<SearchfiltertabBar> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.title,
//             style: const TextStyle(
//                 color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _searchController,
//                   onChanged: widget.onSearchChanged, // Calls the callback whenever text changes
//                   decoration: InputDecoration(
//                     hintText: 'Search...',
//                     prefixIcon: Icon(Icons.search),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(8.0),
                    // ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               // IconButton(
//               //   icon: Icon(Icons.filter_list),
//               //   onPressed: widget.filterOnTap,
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

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
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                // Title always displayed
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 10),
                // Search bar displayed conditionally
                if (_isSearching)
                  Expanded(
                    child: TextField(
  controller: _searchController,
  autofocus: true,
  decoration: InputDecoration(
    hintText: 'Search...',
    contentPadding: const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 10.0,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.grey, // Border color
        width: 0.8,         // Reduced border width
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.grey, // Border color
        width: 0.8,         // Reduced border width
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.blue, // Border color when focused
        width: 0.8,         // Reduced border width
      ),
    ),
  ),
  onChanged: widget.onSearchChanged,
),

                  ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search or Close Icon
              IconButton(
                icon: Icon(_isSearching ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    if (_isSearching) {
                      _searchController.clear();
                      widget.onSearchChanged('');
                    }
                    _isSearching = !_isSearching;
                  });
                },
              ),
              // Filter icon
              // IconButton(
              //   icon: const Icon(Icons.filter_alt_outlined),
              //   onPressed: widget.filterOnTap,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
