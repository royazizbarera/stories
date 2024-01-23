import 'package:gsheets/gsheets.dart';
import 'package:stories/constants/privacy_service.dart';

class StoriesController {
  // init GSheets
  final _gsheets = GSheets(credentials);

  // Worksheets
  Worksheet? _sheetStories;

  // Fungsi async untuk mengambil spreadsheet dan worksheet
  Future<void> _fetchWorksheet() async {
    // fetch spreadsheet by its id
    final ss = await _gsheets.spreadsheet(spreadsheetId);

    // get worksheet by its title
    _sheetStories = ss.worksheetByTitle('stories')!;
  }

  Future<List<Map<String, String>>?> getStories() async {
    await _fetchWorksheet();
    final storiesData = await _sheetStories?.values.map.allRows();
    return storiesData;
  }

  Future<String?> getStoryByTitle(String title) async {
    await _fetchWorksheet();
    final storiesData = await _sheetStories?.values.map.allRows();
    if (storiesData != null) {
      // Filter titles berdasarkan genre
      final filteredTitles =
          storiesData.where((story) => story['title'] == title).toList();
      // Check if any matching title is found
      if (filteredTitles.isNotEmpty) {
        return filteredTitles.last['story']!;
      } else {
        // Handle the case where no matching title is found
        return null;
      }
    } else {
      return null;
    }
    // return titlesData;
  }
}
