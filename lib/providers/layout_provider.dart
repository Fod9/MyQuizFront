import 'package:flutter/material.dart';

class LayoutProvider extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  void scrollToTop({int duration = 250}) {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: duration),
      curve: Curves.easeInOut,
    );
  }

  void scrollToBottom({int duration = 250}) {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: duration),
      curve: Curves.easeInOut,
    );
  }

  void scrollDown(double offset, {int duration = 250}) {
    if (_scrollController.offset < _scrollController.position.maxScrollExtent) {
      _scrollController.animateTo(
        _scrollController.offset + offset,
        duration: Duration(milliseconds: duration),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollUp(double offset, {int duration = 250}) {
    if (offset < _scrollController.offset) {
      _scrollController.animateTo(
        _scrollController.offset - offset,
        duration: Duration(milliseconds: duration),
        curve: Curves.easeInOut,
      );
    } else {
      scrollToTop(duration: duration);
    }
  }
}