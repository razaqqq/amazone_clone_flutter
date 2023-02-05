import 'package:amazone_clone/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchbarWidget(isReadOnly: false, hasBackButton: true),
      ),
    );
  }
}
