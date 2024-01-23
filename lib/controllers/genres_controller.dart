import 'package:gsheets/gsheets.dart';
import 'package:stories/constants/privacy_service.dart';

class GenresController {
  // init GSheets
  final _gsheets = GSheets(credentials);

  // Worksheets
  Worksheet? _sheetGenres;

  // Fungsi async untuk mengambil spreadsheet dan worksheet
  Future<void> _fetchWorksheet() async {
    // fetch spreadsheet by its id
    final ss = await _gsheets.spreadsheet(spreadsheetId);

    // get worksheet by its title
    _sheetGenres = ss.worksheetByTitle('genres')!;
  }

  Future<List<Map<String, String>>?> getGenres() async {
    await _fetchWorksheet();
    final genresData = await _sheetGenres?.values.map.allRows();
    return genresData;
  }
  
}
