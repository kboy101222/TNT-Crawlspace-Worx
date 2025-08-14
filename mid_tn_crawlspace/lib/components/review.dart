import 'dart:math';

import 'package:jaspr/server.dart';
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
      Map review = reviewList[i];
      String reviewLink =
          review.containsKey("reviewLink") ? review["reviewLink"] : "";
      String reviewSource =
          review.containsKey("reviewSource") ? review["reviewSource"] : "";
      reviewSection.add(Review(
          reviewText: review["reviewText"],
          reviewer: review["reviewer"],
          rating: review["rating"],
          reviewLink: reviewLink,
          reviewSource: reviewSource,
          slideClass: slideClasses));
    }

    yield div(classes: "embla__container $classes", reviewSection);
  }
}
