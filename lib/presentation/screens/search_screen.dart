import 'package:flutter/material.dart';

import '../../design_system/design_system.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Search Name',
                hintStyle: const TextStyle(
                  color: ColorSystem.secondary,
                  fontSize: SizeSystem.size18,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorSystem.primary, width: 1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
