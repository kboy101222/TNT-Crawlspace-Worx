import 'package:jaspr/jaspr.dart';

class Header extends StatelessComponent {
  const Header({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(classes: "navbar bg-base-100 shadow-sm", [
      div(classes: "navbar-start", []),
      div(classes: "navbar-center", [
        img(
            src: "images/mid_tn_crawlspace_logo.svg",
            classes: "md:w-full xs:w-[100%] mx-auto lg:h-[100px] h-[50px]")
      ]),
      div(classes: "navbar-end", []),
    ]);
  }
}
