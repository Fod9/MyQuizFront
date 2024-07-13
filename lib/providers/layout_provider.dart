import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;

class LayoutProvider extends ChangeNotifier {

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> layoutKey = GlobalKey<ScaffoldState>();

  ScrollController get scrollController => _scrollController;

  LayoutProvider() {
    _scrollController.addListener(unFocusAll);
  }

  void unFocusAll() {
    if (_scrollController.position.userScrollDirection != ScrollDirection.idle) {
      // This line removes focus from any text field when the user starts scrolling
      if (FocusManager.instance.primaryFocus != null) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }
  }

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