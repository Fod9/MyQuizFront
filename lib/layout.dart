import 'package:flutter/material.dart';
import 'package:my_quiz_ap/pages/auth/tmp_logout_btn.dart' show TmpLogoutBtn;
import 'helpers/utils.dart' show getScreenType;


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

    String screenType = getScreenType(context);

    return SafeArea(  // SafeArea is used to avoid the notch and the bottom bar
      bottom: false,
      child: Scaffold(

          // show the app bar if [hasAppBar] is true
          appBar: widget.hasAppBar ? AppBar(
            title: Text(widget.title),
            actions: [

              const TmpLogoutBtn(),  // TODO remove temporary logout button

              IconButton(  // side drawer button
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
            ],
          ) : null,

          body: Stack(
            children: [

              // background image with a gradient
              SizedBox.expand(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        // switch background with type
                        image: (screenType == "mobile")
                            ? const AssetImage(
                            "assets/images/BackgroundMobile.png")
                            : const AssetImage(
                            "assets/images/BackgroundDesktop.png"),
                        fit: BoxFit.cover,
                      ),
                    )
                ),
              ),

              // the page to display
              SingleChildScrollView(
                child: widget.page,
              ),
            ],
          )
      ),
    );
  }
}
