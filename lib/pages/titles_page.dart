import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stories/controllers/contents_controller.dart';
import 'package:stories/pages/story_page.dart';
import 'package:stories/theme/theme_provider.dart';

class TitlesPage extends StatefulWidget {
  final String genre;

  const TitlesPage({
    super.key,
    required this.genre,
  });

  @override
  State<TitlesPage> createState() => TitlesPageState();
}

class TitlesPageState extends State<TitlesPage> {
  final _contentsController = ContentsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        title: Text(
          widget.genre,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              });
            },
            icon: const Icon(Icons.light_mode),
          ),
        ],
      ),

      // Main Content
      body: FutureBuilder(
        // fetch data dari Spreadsheet
        future: _contentsController.getTitlesByGenre(widget.genre),
        builder: (conrext, snapshot) {
          // Loading fetch
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error fetch
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Data hasil fetch
          List<Map<String, String>>? titles = snapshot.data;

          // List UI
          return RefreshIndicator(
            onRefresh: () async {
              var newGenres =
                  await _contentsController.getTitlesByGenre(widget.genre);
              setState(() {
                titles = newGenres;
              });
            },
            // Ketika data tidak kosong
            child: titles != null
                ? ListView.builder(
                    // Jumlah genre
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      // Warna warna tile agar berbeda beda
                      List<Color> myColors = [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.tertiary,
                        Theme.of(context).colorScheme.surfaceTint,
                        Theme.of(context).colorScheme.scrim,
                        Theme.of(context).colorScheme.onErrorContainer,
                        Theme.of(context).colorScheme.onTertiaryContainer,
                        Theme.of(context).colorScheme.onSecondaryContainer,
                      ];

                      // Dapatkan warna untuk card saat ini berdasarkan index
                      Color cardColor = myColors[index % myColors.length];

                      // data
                      Map<String, String> title = titles![index];
                      String titleOfTitles = title['title']!;

                      // Widget tile
                      return Card(
                        color: cardColor,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        // Desain tile
                        child: ListTile(
                          leading: const FlutterLogo(),
                          title: Text(
                            titleOfTitles,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          trailing: Icon(
                            Icons.reply,
                            textDirection: TextDirection.rtl,
                            color: Theme.of(context).colorScheme.surface,
                          ),

                          // Action yang dilakukan
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StoryPage(title: titleOfTitles),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                // Ketika data nya kosong
                : ListView(
                    children: const [
                      Center(
                        child: Text('Saat ini tidak ada Cerita tersedia'),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
