import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/favorite_list_page.dart';

class WordListPage extends StatelessWidget {
  const WordListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Startup Name Generator"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                print("click action button");
                /***
                 * Add a new page (called a route in Flutter) that displays the favorites.
                 * You'll learn how to navigate between the home route and the new route.
                 *
                 * In Flutter, the Navigator manages a stack containing the app's routes.
                 * Pushing a route onto the Navigator's stack updates the display to that route.
                 * Popping a route from the Navigator's stack returns the display to the previous route.
                 *
                 * Next, you'll add a list icon to the AppBar in the build method for _RandomWordsState.
                 * When the user clicks the list icon,
                 * a new route that contains the saved favorites is pushed to the Navigator, displaying the icon.
                 */

                /**
                 * Some widget properties take a single widget (child),
                 * and other properties, such as action, take an array of widgets (children),
                 * as indicated by the square brackets ([]).
                 */
                Navigator.of(context)
                    /**
                     * Next, you'll build a route and push it to the Navigator's stack.
                     * That action changes the screen to display the new route.
                     * The content for the new page is built in MaterialPageRoute's builder property in an anonymous function.
                     */
                    .push(MaterialPageRoute(builder: (context) {
                  return FavoriteListPage();
                }));
              },
            )
          ],
        ),
        body: Center(
          child: RandomWords(),
        ));
  }
}

/// Stateless widgets are immutable, meaning that their properties can’t change—all values are final.
/// Stateful widgets maintain state that might change during the lifetime of the widget.
///
/// Implementing a stateful widget requires at least two classes:
/// 1) a StatefulWidget class that creates an instance of 2) a State class.
///
/// The StatefulWidget class is, itself, immutable and can be thrown away and regenerated,
/// but the State class persists over the lifetime of the widget.
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

/// Prefixing an identifier with an underscore enforces privacy in the Dart language
/// and is a recommended best practice for State objects.
class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = []; // List
  Set<WordPair> _saved = {}; // Set

  @override
  Widget build(BuildContext context) {
    /**
     * The ListView class provides a builder property, itemBuilder,
     * that’s a factory builder and callback function specified as an anonymous function.
     */
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      if (index >= _suggestions.length)
        _suggestions.addAll(generateWordPairs().take(10));
      return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair wordPair) {
    final _isAlreadySaved = _saved.contains(wordPair);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: () {
            /**
             * In Flutter's reactive style framework,
             * calling setState() triggers a call to the build() method
             * for the State object, resulting in an update to the UI.
             */
            setState(() {
              if (_isAlreadySaved) {
                _saved.remove(wordPair);
              } else {
                _saved.add(wordPair);
              }
            });
            print(_saved.toString());
          },
          // leading: Icon(Icons.favorite, color: Colors.redAccent),
          title: Text(wordPair.asCamelCase),
          subtitle: Text(wordPair.asCamelCase),
          trailing: Icon(
              _isAlreadySaved ? Icons.favorite : Icons.favorite_border,
              color: _isAlreadySaved ? Colors.redAccent : null),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey[300],
          height: 5,
          indent: 16,
          endIndent: 16,
        )
      ],
    );
  }
}
