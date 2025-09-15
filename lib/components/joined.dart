import 'package:jaspr/jaspr.dart';

enum JoinDirection {
  vertical("join-vertical"),
  horizontal("join-horizontal");

  final String value;
  const JoinDirection(this.value);
}

class Joined extends StatelessComponent {
  const Joined({
    super.key,
    required this.children,
    required this.direction,
    this.classes = "",
  });

  final String classes;
  final List<Component> children;
  final JoinDirection direction;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(classes: "join ${direction.value} $classes", children);
  }
}
