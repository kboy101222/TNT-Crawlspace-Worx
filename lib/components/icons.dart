import 'package:jaspr/jaspr.dart';

class CustomIcon extends StatelessComponent {
  const CustomIcon(this.iconName,
      {super.key, int iconSize = 24, String fillColor = "none"});

  final String iconName;
  final int iconSize = 24;
  final String fillColor = "none";

  @override
  Iterable<Component> build(BuildContext context) sync* {
    String? iconData;
    if (iconList.containsKey(iconName)) {
      iconData = iconList[iconName];
    } else {
      throw FormatException("$iconName isn't in the icon list");
    }
    yield svg(
        attributes: {
          "xmlns": "http://www.w3.org/2000/svg",
          "fill": fillColor,
          "stroke": "currentColor"
        },
        classes: "h-5 w-5 m-1",
        viewBox: "0 0 $iconSize $iconSize",
        [
          path(
              attributes: {
                'stroke-linecap': 'round',
                'stroke-linejoin': 'round'
              },
              d: iconData,
              [])
        ]);
  }
}

var iconList = {
  'bars-3': "M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5",
  'moon':
      'M21.752 15.002A9.72 9.72 0 0 1 18 15.75c-5.385 0-9.75-4.365-9.75-9.75 0-1.33.266-2.597.748-3.752A9.753 9.753 0 0 0 3 11.25C3 16.635 7.365 21 12.75 21a9.753 9.753 0 0 0 9.002-5.998Z',
  'sun':
      'M12 3v2.25m6.364.386-1.591 1.591M21 12h-2.25m-.386 6.364-1.591-1.591M12 18.75V21m-4.773-4.227-1.591 1.591M5.25 12H3m4.227-4.773L5.636 5.636M15.75 12a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0Z',
  'google-logo':
      'M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z'
};

class BootstrapIcon extends StatelessComponent {
  BootstrapIcon({super.key, required this.iconName});

  final String iconName;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield span(classes: "bi bi-$iconName", []);
  }
}

class StarRating extends StatelessComponent {
  StarRating({super.key, required this.rating, this.minimumStars = 5});

  final double rating;
  final int minimumStars;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    List<BootstrapIcon> symbols = [];
    int totalStars = rating.round();
    int fullStars = rating.truncate();
    int partialStar = (rating - rating.truncate()) > 0 ? 1 : 0;
    int emptyStars = minimumStars - totalStars;
    if (emptyStars < 0) {
      emptyStars = 0;
    }

    for (int i = 0; i < fullStars; i++) {
      symbols.add(BootstrapIcon(iconName: "star-fill"));
    }
    if (partialStar > 0) {
      symbols.add(BootstrapIcon(iconName: "star-half"));
    }
    for (int i = 0; i < emptyStars; i++) {
      symbols.add(BootstrapIcon(iconName: "star"));
    }

    yield span(symbols);
  }
}
