import 'package:gsheets/gsheets.dart';
import 'package:stories/constants/privacy_service.dart';

class TitlesController {
  // init GSheets
  final _gsheets = GSheets(credentials);

  // Worksheets
  Worksheet? _sheetTitles;

  // Fungsi async untuk mengambil spreadsheet dan worksheet
  Future<void> _fetchWorksheet() async {
    // fetch spreadsheet by its id
    final ss = await _gsheets.spreadsheet(spreadsheetId);

    // get worksheet by its title
    _sheetTitles = ss.worksheetByTitle('titles')!;
  }

  Future<List<Map<String, String>>?> getTitles() async {
    await _fetchWorksheet();
    final titlesData = await _sheetTitles?.values.map.allRows();
    return titlesData;
  }

  Future<List<Map<String, String>>?> getTitlesByGenre(String genre) async {
    await _fetchWorksheet();
    final titlesData = await _sheetTitles?.values.map.allRows();
    if (titlesData != null) {
      // Filter titles berdasarkan genre
      final filteredTitles =
          titlesData.where((title) => title['genre'] == genre).toList();
      if (filteredTitles.isEmpty) {
        return null;
      }
      return filteredTitles;
    }
    return null;
  }
}
