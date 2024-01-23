import 'package:stories/controllers/genres_controller.dart';
import 'package:stories/controllers/stories_controller.dart';
import 'package:stories/controllers/titles_controller.dart';

class ContentsController {

  Future<List<Map<String, String>>?> getTitles() async {
    return await TitlesController().getTitles();
  }

  Future<List<Map<String, String>>?> getTitlesByGenre(String genre) async {
    return await TitlesController().getTitlesByGenre(genre);
  }

  Future<List<Map<String, String>>?> getGenres() async {
    return await GenresController().getGenres();
  }

  Future<List<Map<String, String>>?> getStories() async {
    return await StoriesController().getStories();
  }

  Future<String?> getStoriesByTitle(String title) async {
    return await StoriesController().getStoryByTitle(title);
  }


}
