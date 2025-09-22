import 'dart:math';

import 'package:jaspr/jaspr.dart';
import 'icons.dart';
import 'carousel.dart';

class Review extends StatelessComponent {
  Review({
    super.key,
    required this.reviewText,
    required this.reviewer,
    double? rating,
    this.reviewSource = "",
    this.reviewLink = "",
    this.slideClass = "",
  }) : rating = rating ?? 5.0;

  final String reviewText;
  final String reviewer;
  final double rating;
  final String reviewSource;
  final String reviewLink;
  final String slideClass;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    List<Component> components = [];

    components.add(StarRating(rating: rating));
    components.add(p([text(reviewText)]));
    Component formattedReviewSource;
    if (reviewSource != "") {
      if (reviewLink != "") {
        formattedReviewSource = a(href: reviewLink, [
          p([text("- $reviewer via $reviewSource")])
        ]);
      } else {
        formattedReviewSource = p([text("- $reviewer via $reviewSource")]);
      }
    } else {
      formattedReviewSource = p([text("- $reviewer")]);
    }
    components.add(formattedReviewSource);

    yield Slide(children: [div(classes: slideClass, components)]);
  }
}

class ReviewSection extends StatelessComponent {
  ReviewSection({
    super.key,
    required this.reviewList,
    this.classes = "",
    this.slideClasses = "",
    this.maxReviews = 20,
  });

  final List<dynamic> reviewList;
  final String classes;
  final String slideClasses;
  final int maxReviews;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    print("Compiling review section");
    List<Component> reviewSection = [];
    reviewList.shuffle();

    for (int i = 0; i < min(reviewList.length, maxReviews); i++) {
      // Necessary due to some reviews not having a star rating (thanks HA)
      Map review = reviewList[i];
      var rating = review["rating"];
      rating ??= 5.0;
      rating = rating.toDouble();
      String reviewLink =
          review.containsKey("reviewLink") ? review["reviewLink"] : "";
      String reviewSource =
          review.containsKey("reviewSource") ? review["reviewSource"] : "";
      reviewSection.add(Review(
          reviewText: review["reviewText"],
          reviewer: review["reviewer"],
          rating: rating,
          reviewLink: reviewLink,
          reviewSource: reviewSource,
          slideClass: slideClasses));
    }

    yield div(classes: "embla__container $classes", reviewSection);
  }
}
