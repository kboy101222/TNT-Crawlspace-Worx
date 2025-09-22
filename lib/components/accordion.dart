// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:jaspr/jaspr.dart';
import 'joined.dart';

class JoinedAccordion extends StatelessComponent {
  ///Creates a DaisyUI Accordion Element
  const JoinedAccordion(
      {super.key,
      required this.children,
      this.classes = "",
      this.useExampleClasses = false});

  final List<Component> children;
  final String classes;
  final bool useExampleClasses;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    String _classes = useExampleClasses ? "bg-base-100 $classes" : classes;

    yield Joined(
        classes: _classes,
        children: children,
        direction: JoinDirection.vertical);
  }
}

class AccordionSection extends StatelessComponent {
  ///Creates an Accordion Section<br>
  ///Can either be used standalone to create an accordion piece, or as the children of <code>JoinedAccordion</code><br>
  ///If used with a JoinedAccordion, <code>isJoined</code> must be true to have correct behavior
  const AccordionSection({
    super.key,
    required this.title,
    required this.content,
    required this.name,
    this.accordionClasses = "",
    this.borderClasses = "",
    this.titleClasses = "",
    this.contentClasses = "",
    this.isJoined = false,
    this.startOpened = false,
    this.hasArrow = true,
    this.useExampleClasses = false,
    this.toggleType = InputType.radio,
  });

  final String title;
  final String content;
  final String name;
  final String accordionClasses;
  final String borderClasses;
  final String titleClasses;
  final String contentClasses;
  final bool startOpened;
  final bool isJoined;
  final bool hasArrow;
  final bool useExampleClasses;
  final InputType toggleType;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    String joinClass = isJoined ? "join-item" : "";
    String checkedClass = startOpened ? "checked" : "";
    String arrowClass = hasArrow ? "collapse-arrow" : "";
    String _borderClasses = useExampleClasses
        ? "$borderClasses border-base-300 border bg-base-100"
        : borderClasses;
    String _titleClasses =
        useExampleClasses ? "$titleClasses font-semibold" : titleClasses;
    String _contentClasses =
        useExampleClasses ? "$contentClasses text-sm" : contentClasses;
    String _accordionClasses = "$accordionClasses $joinClass $arrowClass";

    yield div(classes: "$_accordionClasses collapse $_borderClasses", [
      input(type: toggleType, name: name, value: checkedClass),
      div(classes: "collapse-title $_titleClasses", [text(title)]),
      div(classes: "collapse-content $_contentClasses", [text(content)]),
    ]);
  }
}

class JoinedAccordionSection extends AccordionSection {
  ///Shortcut class to create joined sections of a JoinedAccordion
  JoinedAccordionSection({
    required super.title,
    required super.content,
    required super.name,
    super.accordionClasses = "",
    super.borderClasses = "",
    super.titleClasses = "",
    super.contentClasses = "",
    super.isJoined = true,
    super.startOpened = false,
    super.hasArrow = true,
    super.useExampleClasses = false,
    super.toggleType = InputType.radio,
  });
}
