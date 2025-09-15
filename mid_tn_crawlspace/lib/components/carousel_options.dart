abstract interface class Settings {
  Map<String, dynamic> get properties;

  operator [](Object key) {
    if (properties.containsKey(key)) {
      return properties[key];
    }
    return null;
  }

  @override
  String toString() {
    String outString = "";
    for (var property in properties.entries) {
      if (property.value == null) {
        continue;
      } else {
        if (property.value is String) {
          outString += '${property.key}: "${property.value}",';
        } else {
          outString += "${property.key}: ${property.value}";
        }
      }
    }

    return outString;
  }
}

class AutoPlayOptions extends Settings {
  AutoPlayOptions({
    this.delay,
    this.jump,
    this.playOnInit,
    this.stopOnInteraction,
    this.stopOnMouseEnter,
    this.stopOnFocusIn,
    this.stopOnLastSnap,
  });

  final int? delay;
  final bool? jump;
  final bool? playOnInit;
  final bool? stopOnInteraction;
  final bool? stopOnMouseEnter;
  final bool? stopOnFocusIn;
  final bool? stopOnLastSnap;

  @override
  Map<String, dynamic> get properties => {
        "delay": delay,
        "jump": jump,
        "playOnInit": playOnInit,
        "stopOnInteraction": stopOnInteraction,
        "stopOnMouseEnter": stopOnMouseEnter,
        "stopOnFocusIn": stopOnFocusIn,
        "stopOnLastSnap": stopOnLastSnap
      };
}

///Helper class for scroll directions for the AutoScrollSettings class
// class ScrollDirections {
//   ScrollDirections();

//   static const forward = "forward";
//   static const backward = "backward";
// }

enum ScrollDirections {
  forward,
  backward;

  @override
  String toString() => name;
}

class AutoScrollSettings extends Settings {
  AutoScrollSettings({
    this.speed,
    this.startDelay,
    this.direction,
    this.playOnInit,
    this.stopOnInteraction,
    this.stopOnMouseEnter,
    this.stopOnFocusIn,
  });

  final int? speed;
  final int? startDelay;
  final ScrollDirections? direction;
  final bool? playOnInit;
  final bool? stopOnInteraction;
  final bool? stopOnMouseEnter;
  final bool? stopOnFocusIn;

  @override
  Map<String, dynamic> get properties => {
        "speed": speed,
        "startDelay": startDelay,
        "direction": direction.toString(),
        "playOnInit": playOnInit,
        "stopOnInteraction": stopOnInteraction,
        "stopOnMouseEnter": stopOnMouseEnter,
        "stopOnFocusIn": stopOnFocusIn
      };
}

class ClassNameSettings extends Settings {
  ClassNameSettings(
      {this.snapped = "is-snapped",
      this.inView = "is-in-view",
      this.draggable = "is-draggable",
      this.dragging = "is-dragging",
      this.loop = "is-loop"});

  final String? snapped;
  final String? inView;
  final String? draggable;
  final String? dragging;
  final String? loop;

  String formatClasses(String? classList) {
    if (classList == null) return "";

    String classes = "[";
    for (String className in classList.split(' ')) {
      classes += "'$className'";
    }
    classes += "]";
    return classes;
  }

  @override
  Map<String, String> get properties => {
        "snapped": formatClasses(snapped),
        "inView": formatClasses(inView),
        "draggable": formatClasses(draggable),
        "dragging": formatClasses(dragging),
        "loop": formatClasses(loop),
      };

  @override
  String toString() {
    return properties.toString().substring(1, properties.toString().length - 1);
  }
}
