import 'dart:math';

import 'package:jaspr/server.dart';
import 'icons.dart';
import 'carousel.dart';
import '../review_list.dart';

class Review extends StatelessComponent {
  const Review({
    super.key,
    required this.reviewText,
    required this.reviewer,
    required this.rating,
    this.reviewSource = "",
    this.reviewLink = "",
  });

  final String reviewText;
  final String reviewer;
  final double rating;
  final String reviewSource;
  final String reviewLink;

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

    yield Slide(children: [div(classes: "", components)]);
  }
}

class ReviewSection extends StatelessComponent {
  ReviewSection(
      {super.key,
      required this.reviewFile,
      this.classes = "",
      this.maxReviews = 20});

  final String reviewFile;
  final String classes;
  final int maxReviews;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    print("Compiling review section");
    List<Component> reviewSection = [];

    for (int i = 0; i < min(reviewList.length, maxReviews); i++) {
      Map review = reviewList[i];
      String reviewLink =
          review.containsKey("reviewLink") ? review["reviewLink"] : "";
      String reviewSource =
          review.containsKey("reviewSource") ? review["reviewSource"] : "";
      reviewSection.add(Review(
        reviewText: review["reviewText"],
        reviewer: review["reviewer"],
        rating: review["rating"].toDouble(),
        reviewLink: reviewLink,
        reviewSource: reviewSource,
      ));
    }

    yield div(classes: "embla__container $classes", reviewSection);
  }
}
