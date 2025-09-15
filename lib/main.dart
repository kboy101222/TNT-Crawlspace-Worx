// The entrypoint for the **server** environment.
//
// The [main] method will only be executed on the server during pre-rendering.
// To run code on the client, use the @client annotation.

// Server-specific jaspr import.
import 'package:jaspr/server.dart';

// Imports the [App] component.
import 'app.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'jaspr_options.dart';

void main() {
  // Initializes the server environment with the generated default options.
  Jaspr.initializeApp(
    options: defaultJasprOptions,
  );

  // Starts the app.
  //
  // [Document] renders the root document structure (<html>, <head> and <body>)
  // with the provided parameters and components.
  runApp(Document(
    base: 'TNT-Crawlspace-Worx',
    title: 'Middle TN Crawlspace',
    head: [
      link(href: 'styles.css', rel: 'stylesheet'),
      meta(name: "viewport", content: "width=device-width, initial-scale=1.0")
    ],
    styles: [],
    body: App(),
  ));
}
