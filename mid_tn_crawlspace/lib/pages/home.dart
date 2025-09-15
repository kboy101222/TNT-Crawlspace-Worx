import 'package:jaspr/jaspr.dart';
import 'package:mid_tn_crawlspace/components/accordion.dart';
import 'package:mid_tn_crawlspace/components/carousel_options.dart';
import 'package:mid_tn_crawlspace/review_list.dart';
import '../components/icons.dart';
import '../components/carousel.dart';
import '../components/review.dart';
// import '../components/review.dart';

// By using the @client annotation this component will be automatically compiled to javascript and mounted
// on the client. Therefore:
// - this file and any imported file must be compilable for both server and client environments.
// - this component and any child components will be built once on the server during pre-rendering and then
//   again on the client during normal rendering.
@client
class Home extends StatefulComponent {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Run code depending on the rendering environment.
    // if (kIsWeb) {
    //   print("Hello client");
    //   // When using @client components there is no default `main()` function on the client where you would normally
    //   // run any client-side initialization logic. Instead you can put it here, considering this component is only
    //   // mounted once at the root of your client-side component tree.
    // } else {
    //   print("Hello server");
    // }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
        classes:
            "content-area flex flex-col grow items-center bg-[url(/images/nashville_skyline_fireworks.jpg)]",
        [
          EmblaPlugin(
            autoPlayPlugin: true,
          ),
          p(
              classes: "text-[2rem] font-outline font-bold",
              [text("Contact Us")]),
          div(classes: "lg:join-horizontal justify-center flex flex-col", [
            a(href: "", classes: "btn btn-primary join-item", [
              BootstrapIcon(iconName: "telephone-outbound-fill"),
              text("(615) 582 - 6784")
            ]),
            a(href: "", classes: "btn btn-primary join-item", [
              BootstrapIcon(iconName: "envelope-fill"),
              text("jrmccasland3@gmail.com")
            ]),
            a(href: "", classes: "btn btn-primary join-item", [
              BootstrapIcon(iconName: "house-fill"),
              text("242 West Main Street #206, Hendersonville, TN")
            ]),
          ]),
          p(
              classes: "text-[2rem] font-outline font-bold mt-5",
              [text("Our Reviews")]),
          div(classes: "join-vertical lg:join-horizontal flex flex-col", [
            a(href: "", classes: "btn btn-primary join-item", [
              BootstrapIcon(iconName: "google"),
              StarRating(rating: 4.5),
              text("19 Reviews")
            ]),
            a(href: "", classes: "btn btn-primary join-item", [
              img(
                  src: "images/homeadvisor-logo.svg",
                  height: 20,
                  width: 20,
                  classes: "flex items-center"),
              StarRating(rating: 5),
              text("62 Reviews")
            ]),
          ]),
          Carousel(
              autoPlayPlugin: true,
              classes: "mt-5 text-base-content bg-base-100/50 backdrop-blur-sm",
              navButtons: true,
              carouselHeight: "24rem",
              prevButtonChildren: [
                BootstrapIcon(iconName: "caret-left-fill")
              ],
              nextButtonChildren: [
                BootstrapIcon(iconName: "caret-right-fill")
              ],
              children: [
                ReviewSection(
                    reviewList: reviewList, slideClasses: "max-h-[200px]"
                    // classes: "flex w-[100%] rounded-md w-[100vw] md:w-[40vw]",
                    )
              ]),
          p(
              classes: "text-[2rem] font-outline font-bold",
              [text("Our Services")]),
          JoinedAccordion(
              classes: "backdrop-blur-sm bg-base-100/50 mt-[10px] w-[90vw]",
              children: [
                JoinedAccordionSection(
                    title: "Full Encapsulations with Dehumidifier",
                    content:
                        "Seal up your basement with vapor barriers, turning it into a cleaner and more energy efficient space in your home. Also includes a dehumidifier service.",
                    name: "servicesAccordion",
                    startOpened: true,
                    toggleType: InputType.radio),
                JoinedAccordionSection(
                    title: "Partial Encapsulation",
                    content:
                        "The same as our Full Encapsulation, but without the dehumidifier.",
                    name: "servicesAccordion",
                    startOpened: false,
                    toggleType: InputType.radio),
                JoinedAccordionSection(
                    title: "Interior and Exterior Drain Systems",
                    content:
                        "A French Drain for your basement. It help to move water out of your basement faster and without causing excessive damage.",
                    name: "servicesAccordion",
                    startOpened: false,
                    toggleType: InputType.radio),
                JoinedAccordionSection(
                    title: "Sump Pump Systems",
                    content:
                        "Sump Pumps pump fluids and waste from the lower parts of your home, such as your basement, into your sewer line, helping to prevent waste water from flooding your basement.",
                    name: "servicesAccordion",
                    startOpened: false,
                    toggleType: InputType.radio)
              ])
        ]);
  }
}
