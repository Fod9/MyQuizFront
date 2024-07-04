import 'package:flutter/material.dart';

class LayoutProvider extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  void scrollToTop({int duration = 500}) {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: duration),
      curve: Curves.easeInOut,
    );
  }

  void scrollToBottom({int duration = 500}) {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: duration),
      curve: Curves.easeInOut,
    );
  }
}