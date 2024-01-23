import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stories/controllers/contents_controller.dart';
import 'package:stories/theme/theme_provider.dart';

class StoryPage extends StatefulWidget {
  final String title;
  const StoryPage({
    super.key,
    required this.title,
  });

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final ContentsController _contentsController = ContentsController();
  double fontSize = 14;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                pinned: true,
                floating: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      });
                    },
                    icon: Icon(
                      Icons.light_mode,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  )
                ],
                expandedHeight: 160,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  background:
                      // Image.network(
                      //     'https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80'),
                      CachedNetworkImage(
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    imageUrl:
                        'https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80',
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: FutureBuilder(
                  future: _contentsController.getStoriesByTitle(widget.title),
                  builder: (context, snapshot) {
                    // Loading fetch
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Error fetch
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.data != null) {
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data!,
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text('Saat ini tidak ada Cerita tersedia'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 1,
                        offset: Offset(1, 2),
                        spreadRadius: -1,
                      ),
                    ]),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      fontSize++;
                    });
                  },
                  icon: const Icon(Icons.zoom_in_rounded),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 1,
                        offset: Offset(1, 2),
                        spreadRadius: -1,
                      ),
                    ]),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      fontSize--;
                    });
                  },
                  icon: const Icon(Icons.zoom_out_rounded),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
