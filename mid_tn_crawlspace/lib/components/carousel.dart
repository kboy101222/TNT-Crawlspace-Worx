import 'package:jaspr/jaspr.dart';

class EmblaPlugin extends StatelessComponent {
  const EmblaPlugin({super.key, this.autoplayPlugin = false});

  final bool autoplayPlugin;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    if (autoplayPlugin) {
      yield div([
        script(src: "https://unpkg.com/embla-carousel/embla-carousel.umd.js"),
        script(
            src:
                "https://unpkg.com/embla-carousel-autoplay/embla-carousel-autoplay.umd.js"),
      ]);
    }
    yield script(src: "https://unpkg.com/embla-carousel/embla-carousel.umd.js");
  }
}

class Carousel extends StatelessComponent {
  ///<p>Creates a carousel object. Uses <a href="https://www.embla-carousel.com/">Embla Carousel</a> as the base</p>
  ///<p><b>You must create an EmblaPlugin object before this object to ensure the script loads</b></p>
  ///<p>Params:</p>
  ///<ul>
  ///<li><code>List&ltComponent&gt children</code> : Child elements</li>
  ///<li><code>String className</code> : Class name of the carousel (default: <code>"embla"</code>)</li>
  ///<ul><li>If there is more than 1 carousel on the same, this must be unique</li></ul>
  ///<li><code>String classes</code> : CSS classes to attach to the carousel (default: <code>""</code>)</li>
  ///<li><code>bool loop</code> : Determines if the carousel loops (default: <code>true</code>)</li>
  ///<li><code>bool autoplay</code> : Enables the Autoplay plugin (default: <code>false</code>)
  ///<li><code>bool navButtons</code> : Creates previous/next buttons (default: <code>false</code>)
  ///<p>The following do nothing unless <code>navButtons == true</code></p>
  ///<li><code>List&ltComponent&gt prevButtonChildren</code> : Child components that make up the previous button (default: <code>[Text("Prev")]</code>)
  ///<li><code>List&ltComponent&gt nextButtonChildren</code> : Child components that make up the next button (default: <code>[Text("Next")]</code>)
  ///<li><code>String carouselHeight</code> : The height of the carousel. Only adjusts the height of the prev/next buttons (default: <code>null</code>)
  ///<p>The following require <a href="https://tailwindcss.com/">tailwindCSS</a>, but can otherwise be set through CSS:</p>
  ///<li><code>String mdWidth</code> : The width of the carousel on md - lg screens (default: <code>40vw</code>)
  ///<li><code>String width</code> : The default width of the carousel (default: <code>100vw</code>)
  Carousel({
    super.key,
    required this.children,
    this.loop = true,
    this.autoplay = false,
    this.navButtons = false,
    this.className = "embla",
    this.classes = "",
    this.carouselHeight,
    this.mdWidth = "40vw",
    this.width = "100vw",
    List<Component>? prevButtonChildren,
    List<Component>? nextButtonChildren,
    AutoplayOptions? autoPlayOptions,
  })  : prevButtonChildren = prevButtonChildren ?? const [Text("Prev")],
        nextButtonChildren = nextButtonChildren ?? const [Text("Next")],
        autoplayOptions = autoPlayOptions ?? AutoplayOptions();

  final List<Component> children;
  final bool loop;
  final bool autoplay;
  final bool navButtons;
  final String className;
  final String classes;
  final String mdWidth;
  final String width;
  final List<Component> prevButtonChildren;
  final List<Component> nextButtonChildren;
  final AutoplayOptions autoplayOptions;
  final String? carouselHeight;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    String autoplayPlugin = "const ${className}_plugins = [];";
    String autoplaySettings = "";
    if (autoplay) {
      autoplayPlugin = "const ${className}_plugins = [EmblaCarouselAutoplay()]";
      for (String setting in autoplayOptions.keys) {
        autoplaySettings += "$setting: ${autoplayOptions[setting]},";
      }
    }
    String scripting = '''
        const ${className}_emblaNode = document.querySelector(".$className")
        const ${className}_viewportNode = ${className}_emblaNode.querySelector('.${className}__viewport')
        const ${className}_OPTIONS = { loop: $loop, $autoplaySettings }
        $autoplayPlugin
        const ${className}_emblaApi = EmblaCarousel(${className}_viewportNode, ${className}_OPTIONS, ${className}_plugins)
      ''';

    if (navButtons) {
      scripting += '''
      const ${className}_prevButtonNode = ${className}_emblaNode.querySelector('.${className}__prev')
      const ${className}_nextButtonNode = ${className}_emblaNode.querySelector('.${className}__next')

      ${className}_prevButtonNode.addEventListener('click', ${className}_emblaApi.scrollPrev, false)
      ${className}_nextButtonNode.addEventListener('click', ${className}_emblaApi.scrollNext, false)
      ''';
      yield div([
        div(classes: "$className $classes rounded-md w-[100vw] md:w-[40vw]", [
          button(
              classes:
                  "${className}__prev btn btn-ghost self-center ${carouselHeight == null ? "" : "h-[$carouselHeight]"}",
              prevButtonChildren),
          div(classes: "${className}__viewport", children),
          button(
              classes:
                  "${className}__next btn btn-ghost self-center ${carouselHeight ?? ""}",
              nextButtonChildren)
        ]),
        script(content: scripting)
      ]);
    } else {
      yield div([
        div(
            classes: "$className $classes rounded-md w-[100vw] md:w-[40vw]",
            [div(classes: "${className}__viewport", children)]),
        script(content: scripting)
      ]);
    }
  }
}

class Slide extends StatelessComponent {
  const Slide(
      {super.key,
      required this.children,
      this.classes = "",
      this.className = "embla"});

  final List<Component> children;
  final String classes;
  final String className;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(classes: "${className}__slide $classes ", children);
  }
}

class CarouselNavButton extends StatelessComponent {
  const CarouselNavButton(
      {super.key, required this.buttonType, this.className = "embla"});

  final String buttonType;
  final String className;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    if (!["prev", "next"].contains(buttonType)) {
      throw FormatException(
          'buttonType must be one of the following: "prev", "next"');
    }
  }
}

class AutoplayOptions {
  AutoplayOptions({
    this.delay = 4000,
    this.jump = false,
    this.playOnInit = true,
    this.stopOnInteraction = true,
    this.stopOnMouseEnter = false,
    this.stopOnFocusIn = true,
    this.stopOnLastSnap = false,
  });

  final int delay;
  final bool jump;
  final bool playOnInit;
  final bool stopOnInteraction;
  final bool stopOnMouseEnter;
  final bool stopOnFocusIn;
  final bool stopOnLastSnap;

  final List<String> keys = [
    "delay",
    "jump",
    "playOnInit",
    "stopOnInteraction",
    "stopOnMouseEnter",
    "stopOnFocusIn",
    "stopOnLastSnap"
  ];

  Map getSettings() {
    Map outMap = {};

    outMap["delay"] = delay;
    outMap["jump"] = jump;
    outMap["playOnInit"] = playOnInit;
    outMap["stopOnInteraction"] = stopOnInteraction;
    outMap["stopOnMouseEnter"] = stopOnMouseEnter;
    outMap["stopOnFocusIn"] = stopOnFocusIn;
    outMap["stopOnLastSnap"] = stopOnLastSnap;

    return outMap;
  }

  operator [](Object key) {
    Map outMap = getSettings();
    if (outMap.containsKey(key.toString())) {
      return outMap[key.toString()];
    }
    return "";
  }
}
