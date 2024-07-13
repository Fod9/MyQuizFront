import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/appbar/my_quiz_end_drawer.dart' show MyQuizEndDrawer;
import 'package:my_quiz_ap/components/my_quiz_background.dart' show MyQuizBackground;
import 'package:my_quiz_ap/providers/layout_provider.dart' show LayoutProvider;
import 'package:provider/provider.dart' show ChangeNotifierProvider, Consumer;
import 'components/appbar/my_quiz_appbar.dart' show MyQuizAppBar;

/// This widget is used to display the layout of the app
/// It contains the [AppBar] and the [page]
/// The background image is different depending on the screen type
/// The [AppBar] can be hidden with the [hasAppBar] parameter
///
/// required parameters:
/// - [title] the title of the page
/// - [page] the page to display
///
/// optional parameters:
/// - [hasAppBar] default is true (show the app bar)
///
/// returns a [Scaffold] with the [AppBar] and the [page]
class Layout extends StatefulWidget {
  const Layout(
      this.title,  // positional parameter
          {
        super.key,
        required this.page,
        this.hasAppBar = true,
      }
      );

  final String title;  // title of the page
  final Widget page;  // the page to display
  final bool hasAppBar;  // show the app bar

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => LayoutProvider(),
      child: SafeArea(  // SafeArea is used to avoid the notch and the bottom bar
        bottom: false,
        child: Consumer<LayoutProvider>(
            builder: (context, layoutProvider, child) {

            return Scaffold(
                key: layoutProvider.layoutKey,
                // show the app bar if [hasAppBar] is true
                appBar: widget.hasAppBar ? MyQuizAppBar(
                  title: widget.title,
                  scaffoldKey: layoutProvider.layoutKey,
                ) : null,
                extendBodyBehindAppBar: true,

                endDrawer: const MyQuizEndDrawer(),
                drawerScrimColor: Colors.transparent,

                body: Stack(
                  children: [

                    // background image with a gradient
                    const MyQuizBackground(),

                    // the page to display
                    Padding(
                      padding: const EdgeInsets.only(top : 85.0),
                      child: SingleChildScrollView(
                        controller: layoutProvider.scrollController,
                        physics: const BouncingScrollPhysics(),
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        child: widget.page,
                      ),
                    ),
                  ],
                )
            );
          }
        ),
      ),
    );
  }
}
