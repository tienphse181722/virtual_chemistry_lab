import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/periodic_table_data.dart';
import 'package:virtual_chemistry_lab/services/element_cache_service.dart';
import 'package:virtual_chemistry_lab/models/element_model.dart';

class PeriodicTableScreen extends StatefulWidget {
  const PeriodicTableScreen({super.key});

  @override
  State<PeriodicTableScreen> createState() => _PeriodicTableScreenState();
}

class _PeriodicTableScreenState extends State<PeriodicTableScreen> {
  String _selectedFilter = 'Tất cả';
  Map<String, dynamic>? _selectedElement;
  List<ElementModel> _elements = [];
  bool _isLoading = true;
  final ElementCacheService _cacheService = ElementCacheService();

  @override
  void initState() {
    super.initState();
    _loadElements();
  }

  // Preload data
  Future<void> _loadElements() async {
    try {
      final elements = await _cacheService.getElements();
      if (mounted) {
        setState(() {
          _elements = elements;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading elements: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<Map<String, dynamic>> _getFilteredElements(List<ElementModel> elements) {
    // Convert ElementModel to Map with grid positions and all fields
    List<Map<String, dynamic>> elementMaps = elements.map((e) {
      final pos = _getPositionForAtomicNumber(e.atomicNumber);
      return {
        'atomicNumber': e.atomicNumber,
        'symbol': e.symbol,
        'name': e.name,
        'atomicMass': e.atomicMass,
        'oxidationStates': e.oxidationStates,
        'category': e.category,
        'description': e.description,
        'row': pos['row'],
        'col': pos['col'],
      };
    }).toList();

    if (_selectedFilter == 'Tất cả') {
      return elementMaps;
    }
    return elementMaps.where((e) => e['category'] == _selectedFilter).toList();
  }

  Map<String, int> _getPositionForAtomicNumber(int z) {
    // Hardcoded positions for accurate periodic table layout
    final Map<int, Map<String, int>> positions = {
      // Period 1
      1: {'row': 0, 'col': 0}, 2: {'row': 0, 'col': 17},
      // Period 2
      3: {'row': 1, 'col': 0}, 4: {'row': 1, 'col': 1},
      5: {'row': 1, 'col': 12}, 6: {'row': 1, 'col': 13}, 7: {'row': 1, 'col': 14},
      8: {'row': 1, 'col': 15}, 9: {'row': 1, 'col': 16}, 10: {'row': 1, 'col': 17},
      // Period 3
      11: {'row': 2, 'col': 0}, 12: {'row': 2, 'col': 1},
      13: {'row': 2, 'col': 12}, 14: {'row': 2, 'col': 13}, 15: {'row': 2, 'col': 14},
      16: {'row': 2, 'col': 15}, 17: {'row': 2, 'col': 16}, 18: {'row': 2, 'col': 17},
      // Period 4
      19: {'row': 3, 'col': 0}, 20: {'row': 3, 'col': 1},
      21: {'row': 3, 'col': 2}, 22: {'row': 3, 'col': 3}, 23: {'row': 3, 'col': 4},
      24: {'row': 3, 'col': 5}, 25: {'row': 3, 'col': 6}, 26: {'row': 3, 'col': 7},
      27: {'row': 3, 'col': 8}, 28: {'row': 3, 'col': 9}, 29: {'row': 3, 'col': 10},
      30: {'row': 3, 'col': 11}, 31: {'row': 3, 'col': 12}, 32: {'row': 3, 'col': 13},
      33: {'row': 3, 'col': 14}, 34: {'row': 3, 'col': 15}, 35: {'row': 3, 'col': 16},
      36: {'row': 3, 'col': 17},
      // Period 5
      37: {'row': 4, 'col': 0}, 38: {'row': 4, 'col': 1},
      39: {'row': 4, 'col': 2}, 40: {'row': 4, 'col': 3}, 41: {'row': 4, 'col': 4},
      42: {'row': 4, 'col': 5}, 43: {'row': 4, 'col': 6}, 44: {'row': 4, 'col': 7},
      45: {'row': 4, 'col': 8}, 46: {'row': 4, 'col': 9}, 47: {'row': 4, 'col': 10},
      48: {'row': 4, 'col': 11}, 49: {'row': 4, 'col': 12}, 50: {'row': 4, 'col': 13},
      51: {'row': 4, 'col': 14}, 52: {'row': 4, 'col': 15}, 53: {'row': 4, 'col': 16},
      54: {'row': 4, 'col': 17},
      // Period 6
      55: {'row': 5, 'col': 0}, 56: {'row': 5, 'col': 1}, 57: {'row': 5, 'col': 2},
      72: {'row': 5, 'col': 3}, 73: {'row': 5, 'col': 4}, 74: {'row': 5, 'col': 5},
      75: {'row': 5, 'col': 6}, 76: {'row': 5, 'col': 7}, 77: {'row': 5, 'col': 8},
      78: {'row': 5, 'col': 9}, 79: {'row': 5, 'col': 10}, 80: {'row': 5, 'col': 11},
      81: {'row': 5, 'col': 12}, 82: {'row': 5, 'col': 13}, 83: {'row': 5, 'col': 14},
      84: {'row': 5, 'col': 15}, 85: {'row': 5, 'col': 16}, 86: {'row': 5, 'col': 17},
      // Period 7
      87: {'row': 6, 'col': 0}, 88: {'row': 6, 'col': 1}, 89: {'row': 6, 'col': 2},
      104: {'row': 6, 'col': 3}, 105: {'row': 6, 'col': 4}, 106: {'row': 6, 'col': 5},
      107: {'row': 6, 'col': 6}, 108: {'row': 6, 'col': 7}, 109: {'row': 6, 'col': 8},
      110: {'row': 6, 'col': 9}, 111: {'row': 6, 'col': 10}, 112: {'row': 6, 'col': 11},
      113: {'row': 6, 'col': 12}, 114: {'row': 6, 'col': 13}, 115: {'row': 6, 'col': 14},
      116: {'row': 6, 'col': 15}, 117: {'row': 6, 'col': 16}, 118: {'row': 6, 'col': 17},
      // Lanthanides (row 8)
      58: {'row': 8, 'col': 3}, 59: {'row': 8, 'col': 4}, 60: {'row': 8, 'col': 5},
      61: {'row': 8, 'col': 6}, 62: {'row': 8, 'col': 7}, 63: {'row': 8, 'col': 8},
      64: {'row': 8, 'col': 9}, 65: {'row': 8, 'col': 10}, 66: {'row': 8, 'col': 11},
      67: {'row': 8, 'col': 12}, 68: {'row': 8, 'col': 13}, 69: {'row': 8, 'col': 14},
      70: {'row': 8, 'col': 15}, 71: {'row': 8, 'col': 16},
      // Actinides (row 9)
      90: {'row': 9, 'col': 3}, 91: {'row': 9, 'col': 4}, 92: {'row': 9, 'col': 5},
      93: {'row': 9, 'col': 6}, 94: {'row': 9, 'col': 7}, 95: {'row': 9, 'col': 8},
      96: {'row': 9, 'col': 9}, 97: {'row': 9, 'col': 10}, 98: {'row': 9, 'col': 11},
      99: {'row': 9, 'col': 12}, 100: {'row': 9, 'col': 13}, 101: {'row': 9, 'col': 14},
      102: {'row': 9, 'col': 15}, 103: {'row': 9, 'col': 16},
    };
    
    return positions[z] ?? {'row': 0, 'col': 0};
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;

    return Scaffold(
      backgroundColor: Color(0xFF1A237E),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Bảng Tuần Hoàn',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20 * scaleX),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : _elements.isEmpty
              ? Center(
                  child: Text(
                    'Không có dữ liệu',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Column(
                  children: [
                    // Title
                    Padding(
                      padding: EdgeInsets.all(16 * scaleX),
                      child: Text(
                        'Phân loại nguyên tố (${_elements.length} nguyên tố)',
                        style: TextStyle(
                          fontSize: 20 * scaleX,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Filter chips
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
                      child: Wrap(
                        spacing: 8 * scaleX,
                        runSpacing: 8 * scaleX,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildFilterChip('Tất cả', Icons.apps, Colors.grey, scaleX),
                          _buildFilterChip('Kim loại', Icons.build, Color(0xFF81D4FA), scaleX),
                          _buildFilterChip('Phi kim', Icons.science, Color(0xFFE57373), scaleX),
                          _buildFilterChip('Á kim', Icons.grid_3x3, Color(0xFFCE93D8), scaleX),
                          _buildFilterChip('Khí hiếm', Icons.bubble_chart, Color(0xFFFFF176), scaleX),
                          _buildFilterChip('Kim loại kiềm', Icons.flash_on, Color(0xFFFFD54F), scaleX),
                          _buildFilterChip('Halogen', Icons.water_drop, Color(0xFFF48FB1), scaleX),
                          _buildFilterChip('Đất hiếm', Icons.star, Color(0xFFFFAB91), scaleX),
                          _buildFilterChip('Actini', Icons.radio_button_checked, Color(0xFFBCAAA4), scaleX),
                        ],
                      ),
                    ),

                    SizedBox(height: 16 * scaleX),

                    // Periodic table - scrollable
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(16 * scaleX),
                            child: Column(
                              children: [
                                _buildPeriodicTable(scaleX, _elements),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Element detail card at bottom - Full info in Vietnamese
                    if (_selectedElement != null)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20 * scaleX),
                        decoration: BoxDecoration(
                          color: Color(0xFF283593),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20 * scaleX),
                            topRight: Radius.circular(20 * scaleX),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100 * scaleX,
                              height: 100 * scaleX,
                              decoration: BoxDecoration(
                                color: PeriodicTableData.getColorForCategory(_selectedElement!['category']),
                                borderRadius: BorderRadius.circular(12 * scaleX),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${_selectedElement!['atomicNumber']}',
                                    style: TextStyle(
                                      fontSize: 16 * scaleX,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _selectedElement!['symbol'],
                                    style: TextStyle(
                                      fontSize: 36 * scaleX,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16 * scaleX),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedElement!['name'],
                                    style: TextStyle(
                                      fontSize: 24 * scaleX,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8 * scaleX),
                                  Text(
                                    'Khối lượng: ${_selectedElement!['atomicMass']}',
                                    style: TextStyle(
                                      fontSize: 14 * scaleX,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  SizedBox(height: 4 * scaleX),
                                  Text(
                                    '${_selectedElement!['category']}',
                                    style: TextStyle(
                                      fontSize: 14 * scaleX,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  SizedBox(height: 4 * scaleX),
                                  Text(
                                    'Số oxi hóa: ${_selectedElement!['oxidationStates']}',
                                    style: TextStyle(
                                      fontSize: 14 * scaleX,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  if (_selectedElement!['description'] != null && _selectedElement!['description'].toString().isNotEmpty) ...[
                                    SizedBox(height: 4 * scaleX),
                                    Text(
                                      _selectedElement!['description'],
                                      style: TextStyle(
                                        fontSize: 12 * scaleX,
                                        color: Colors.white60,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
    );
  }

  Widget _buildPeriodicTable(double scale, List<ElementModel> elements) {
    // Create 10 rows x 18 columns grid (7 main + 2 lanthanides/actinides + 1 spacer)
    final int rows = 10;
    final int cols = 18;
    final double cellSize = 50 * scale;
    final double spacing = 4 * scale;

    final filteredElements = _getFilteredElements(elements);

    List<Widget> rowWidgets = [];
    
    for (int row = 0; row < rows; row++) {
      // Add spacer row after row 6
      if (row == 7) {
        rowWidgets.add(SizedBox(height: spacing * 2));
        continue;
      }
      
      List<Widget> cellWidgets = [];
      
      for (int col = 0; col < cols; col++) {
        // Find element at this position
        final element = filteredElements.firstWhere(
          (e) => e['row'] == row && e['col'] == col,
          orElse: () => {},
        );
        
        if (element.isNotEmpty) {
          cellWidgets.add(_buildElementCell(element, cellSize, scale));
        } else {
          cellWidgets.add(SizedBox(width: cellSize, height: cellSize));
        }
        
        if (col < cols - 1) {
          cellWidgets.add(SizedBox(width: spacing));
        }
      }
      
      rowWidgets.add(Row(children: cellWidgets));
      if (row < rows - 1) {
        rowWidgets.add(SizedBox(height: spacing));
      }
    }
    
    return Column(children: rowWidgets);
  }

  Widget _buildElementCell(Map<String, dynamic> element, double size, double scale) {
    final isSelected = _selectedElement?['atomicNumber'] == element['atomicNumber'];
    final color = PeriodicTableData.getColorForCategory(element['category']);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedElement = element;
        });
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8 * scale),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${element['atomicNumber']}',
              style: TextStyle(
                fontSize: 8 * scale,
                color: Colors.white70,
              ),
            ),
            Text(
              element['symbol'],
              style: TextStyle(
                fontSize: 18 * scale,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, Color color, double scale) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedFilter = label;
        _selectedElement = null;
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20 * scale),
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16 * scale),
            SizedBox(width: 6 * scale),
            Text(
              label,
              style: TextStyle(
                fontSize: 12 * scale,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
