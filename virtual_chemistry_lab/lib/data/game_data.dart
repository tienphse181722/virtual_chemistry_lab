/// Game data with multiple levels for each game type
/// Each game has its own levels from basic to advanced

class GameData {
  // 1. QUIZ NHANH - Trả lời nhanh trong thời gian giới hạn
  static final List<Map<String, dynamic>> quizNhanhLevels = [
    {
      'level': 1,
      'name': 'Cơ Bản - Nhận biết nguyên tố',
      'timeLimit': 60, // seconds
      'questions': [
        {
          'question': 'Nguyên tố nào có ký hiệu hóa học là H?',
          'options': ['Hiđro', 'Heli', 'Hydro', 'Halogen'],
          'correct': 0,
          'points': 20,
        },
        {
          'question': 'Oxy có ký hiệu hóa học là gì?',
          'options': ['O', 'Ox', 'O₂', 'OX'],
          'correct': 0,
          'points': 20,
        },
        {
          'question': 'Nguyên tố nào có số nguyên tử Z = 6?',
          'options': ['Nitơ', 'Carbon', 'Oxy', 'Lưu huỳnh'],
          'correct': 1,
          'points': 20,
        },
        {
          'question': 'Kim loại nào có màu vàng?',
          'options': ['Bạc', 'Vàng', 'Đồng', 'Sắt'],
          'correct': 1,
          'points': 20,
        },
        {
          'question': 'Khí nào chiếm nhiều nhất trong không khí?',
          'options': ['Oxy', 'Nitơ', 'CO₂', 'Hơi nước'],
          'correct': 1,
          'points': 20,
        },
      ],
    },
    {
      'level': 2,
      'name': 'Trung Bình - Công thức hóa học',
      'timeLimit': 90,
      'questions': [
        {
          'question': 'Công thức hóa học của nước là gì?',
          'options': ['H₂O', 'HO', 'H₂O₂', 'H₃O'],
          'correct': 0,
          'points': 25,
        },
        {
          'question': 'Muối ăn có công thức là?',
          'options': ['NaCl', 'KCl', 'CaCl₂', 'MgCl₂'],
          'correct': 0,
          'points': 25,
        },
        {
          'question': 'Axit sunfuric có công thức?',
          'options': ['HCl', 'HNO₃', 'H₂SO₄', 'H₃PO₄'],
          'correct': 2,
          'points': 25,
        },
        {
          'question': 'Khí cacbonic có công thức?',
          'options': ['CO', 'CO₂', 'C₂O', 'CO₃'],
          'correct': 1,
          'points': 25,
        },
        {
          'question': 'Amoniac có công thức?',
          'options': ['NH₃', 'NH₄', 'N₂H₄', 'NH₂'],
          'correct': 0,
          'points': 25,
        },
        {
          'question': 'Canxi cacbonat có công thức?',
          'options': ['CaCO₃', 'Ca(CO₃)₂', 'CaC₂O₃', 'Ca₂CO₃'],
          'correct': 0,
          'points': 25,
        },
      ],
    },
    {
      'level': 3,
      'name': 'Nâng Cao - Tính toán hóa học',
      'timeLimit': 120,
      'questions': [
        {
          'question': 'Khối lượng mol của H₂O là bao nhiêu?',
          'options': ['16 g/mol', '18 g/mol', '20 g/mol', '22 g/mol'],
          'correct': 1,
          'points': 30,
          'explanation': 'M(H₂O) = 2×1 + 16 = 18 g/mol',
        },
        {
          'question': 'Số mol của 44g CO₂ là?',
          'options': ['0.5 mol', '1 mol', '1.5 mol', '2 mol'],
          'correct': 1,
          'points': 30,
          'explanation': 'n = m/M = 44/44 = 1 mol',
        },
        {
          'question': 'Hòa tan 5.85g NaCl vào nước được dung dịch 0.5L. Nồng độ mol/L?',
          'options': ['0.1M', '0.2M', '0.3M', '0.4M'],
          'correct': 1,
          'points': 30,
          'explanation': 'n = 5.85/58.5 = 0.1 mol, CM = 0.1/0.5 = 0.2M',
        },
        {
          'question': 'Phần trăm khối lượng O trong H₂SO₄?',
          'options': ['32.65%', '49.00%', '65.31%', '75.00%'],
          'correct': 2,
          'points': 30,
          'explanation': '%O = (4×16)/(2+32+64) × 100% = 65.31%',
        },
        {
          'question': 'Cần bao nhiêu gam NaOH để pha 200ml dung dịch 0.5M?',
          'options': ['2g', '4g', '6g', '8g'],
          'correct': 1,
          'points': 30,
          'explanation': 'n = 0.5×0.2 = 0.1 mol, m = 0.1×40 = 4g',
        },
      ],
    },
  ];

  // 2. TRÒ CHƠI GHI NHỚ - Tìm cặp công thức và tên
  static final List<Map<String, dynamic>> ghiNhoLevels = [
    {
      'level': 1,
      'name': 'Cơ Bản - Nguyên tố đơn giản',
      'pairs': [
        {'formula': 'H', 'name': 'Hiđro'},
        {'formula': 'O', 'name': 'Oxy'},
        {'formula': 'C', 'name': 'Carbon'},
        {'formula': 'N', 'name': 'Nitơ'},
        {'formula': 'S', 'name': 'Lưu huỳnh'},
        {'formula': 'Fe', 'name': 'Sắt'},
      ],
      'points': 150,
    },
    {
      'level': 2,
      'name': 'Trung Bình - Hợp chất thông dụng',
      'pairs': [
        {'formula': 'H₂O', 'name': 'Nước'},
        {'formula': 'NaCl', 'name': 'Muối ăn'},
        {'formula': 'CO₂', 'name': 'Khí cacbonic'},
        {'formula': 'NH₃', 'name': 'Amoniac'},
        {'formula': 'H₂SO₄', 'name': 'Axit sunfuric'},
        {'formula': 'NaOH', 'name': 'Xút'},
        {'formula': 'CaCO₃', 'name': 'Đá vôi'},
        {'formula': 'CH₄', 'name': 'Metan'},
      ],
      'points': 200,
    },
    {
      'level': 3,
      'name': 'Nâng Cao - Hợp chất phức tạp',
      'pairs': [
        {'formula': 'Ca(OH)₂', 'name': 'Vôi tôi'},
        {'formula': 'H₃PO₄', 'name': 'Axit photphoric'},
        {'formula': 'Al₂O₃', 'name': 'Nhôm oxit'},
        {'formula': 'Fe₂O₃', 'name': 'Sắt(III) oxit'},
        {'formula': 'CuSO₄', 'name': 'Đồng sunfat'},
        {'formula': 'AgNO₃', 'name': 'Bạc nitrat'},
        {'formula': 'KMnO₄', 'name': 'Kali pemanganat'},
        {'formula': 'C₂H₅OH', 'name': 'Etanol'},
        {'formula': 'CH₃COOH', 'name': 'Axit axetic'},
        {'formula': 'C₆H₁₂O₆', 'name': 'Glucozơ'},
      ],
      'points': 300,
    },
  ];

  // 3. XÂY DỰNG PHÂN TỬ - Kéo thả nguyên tử
  static final List<Map<String, dynamic>> xayDungPhanTuLevels = [
    {
      'level': 1,
      'name': 'Cơ Bản - Phân tử đơn giản',
      'molecules': [
        {
          'name': 'Nước',
          'formula': 'H₂O',
          'atoms': ['H', 'H', 'O'],
          'structure': 'H-O-H',
          'points': 50,
        },
        {
          'name': 'Amoniac',
          'formula': 'NH₃',
          'atoms': ['N', 'H', 'H', 'H'],
          'structure': 'H-N-H với H thứ 3',
          'points': 50,
        },
        {
          'name': 'Metan',
          'formula': 'CH₄',
          'atoms': ['C', 'H', 'H', 'H', 'H'],
          'structure': 'C ở giữa, 4 H xung quanh',
          'points': 50,
        },
        {
          'name': 'Khí cacbonic',
          'formula': 'CO₂',
          'atoms': ['C', 'O', 'O'],
          'structure': 'O=C=O',
          'points': 50,
        },
        {
          'name': 'Khí clo',
          'formula': 'Cl₂',
          'atoms': ['Cl', 'Cl'],
          'structure': 'Cl-Cl',
          'points': 50,
        },
      ],
    },
    {
      'level': 2,
      'name': 'Trung Bình - Hợp chất ion',
      'molecules': [
        {
          'name': 'Muối ăn',
          'formula': 'NaCl',
          'atoms': ['Na⁺', 'Cl⁻'],
          'structure': 'Liên kết ion',
          'points': 60,
        },
        {
          'name': 'Canxi oxit',
          'formula': 'CaO',
          'atoms': ['Ca²⁺', 'O²⁻'],
          'structure': 'Liên kết ion',
          'points': 60,
        },
        {
          'name': 'Magie clorua',
          'formula': 'MgCl₂',
          'atoms': ['Mg²⁺', 'Cl⁻', 'Cl⁻'],
          'structure': 'Mg ở giữa, 2 Cl',
          'points': 60,
        },
        {
          'name': 'Nhôm oxit',
          'formula': 'Al₂O₃',
          'atoms': ['Al³⁺', 'Al³⁺', 'O²⁻', 'O²⁻', 'O²⁻'],
          'structure': 'Cấu trúc phức tạp',
          'points': 60,
        },
      ],
    },
    {
      'level': 3,
      'name': 'Nâng Cao - Hợp chất hữu cơ',
      'molecules': [
        {
          'name': 'Etanol',
          'formula': 'C₂H₅OH',
          'atoms': ['C', 'C', 'H', 'H', 'H', 'H', 'H', 'O', 'H'],
          'structure': 'CH₃-CH₂-OH',
          'points': 80,
        },
        {
          'name': 'Axit axetic',
          'formula': 'CH₃COOH',
          'atoms': ['C', 'H', 'H', 'H', 'C', 'O', 'O', 'H'],
          'structure': 'CH₃-COOH',
          'points': 80,
        },
        {
          'name': 'Glucozơ',
          'formula': 'C₆H₁₂O₆',
          'atoms': ['C', 'C', 'C', 'C', 'C', 'C', 'H', 'H', 'H', 'H', 'H', 'H', 'H', 'H', 'H', 'H', 'H', 'H', 'O', 'O', 'O', 'O', 'O', 'O'],
          'structure': 'Cấu trúc vòng 6 cạnh',
          'points': 100,
        },
      ],
    },
  ];

  // 4. GHÉP TỪ HÓA HỌC - Ghép chữ cái thành từ khóa
  static final List<Map<String, dynamic>> ghepTuLevels = [
    {
      'level': 1,
      'name': 'Cơ Bản - Tên nguyên tố',
      'words': [
        {'word': 'HIDRO', 'hint': 'Nguyên tố nhẹ nhất', 'points': 30},
        {'word': 'OXY', 'hint': 'Khí cần cho hô hấp', 'points': 30},
        {'word': 'CARBON', 'hint': 'Nguyên tố trong than', 'points': 30},
        {'word': 'NITO', 'hint': 'Khí chiếm 78% không khí', 'points': 30},
        {'word': 'SAT', 'hint': 'Kim loại từ tính', 'points': 30},
        {'word': 'DONG', 'hint': 'Kim loại màu đỏ', 'points': 30},
      ],
    },
    {
      'level': 2,
      'name': 'Trung Bình - Thuật ngữ hóa học',
      'words': [
        {'word': 'AXIT', 'hint': 'Chất có vị chua', 'points': 35},
        {'word': 'BAZO', 'hint': 'Chất có vị xát', 'points': 35},
        {'word': 'MUOI', 'hint': 'Sản phẩm trung hòa', 'points': 35},
        {'word': 'PHANUNG', 'hint': 'Quá trình biến đổi hóa học', 'points': 35},
        {'word': 'DUNGDICH', 'hint': 'Hỗn hợp đồng nhất', 'points': 35},
        {'word': 'KETTUA', 'hint': 'Chất rắn không tan', 'points': 35},
      ],
    },
    {
      'level': 3,
      'name': 'Nâng Cao - Khái niệm phức tạp',
      'words': [
        {'word': 'OXYHOAKHAU', 'hint': 'Phản ứng nhường nhận e⁻', 'points': 50},
        {'word': 'DONGPHANTU', 'hint': 'Cùng công thức phân tử', 'points': 50},
        {'word': 'XUCTAC', 'hint': 'Chất tăng tốc phản ứng', 'points': 50},
        {'word': 'DIENLI', 'hint': 'Phân ly thành ion', 'points': 50},
        {'word': 'THUYETAXIT', 'hint': 'Lý thuyết về axit-bazơ', 'points': 50},
        {'word': 'DONGHOCDIEN', 'hint': 'Năng lượng từ phản ứng', 'points': 50},
      ],
    },
  ];

  // 5. KIẾN THỨC TỔNG HỢP - Câu hỏi đa dạng
  static final List<Map<String, dynamic>> tongHopLevels = [
    {
      'level': 1,
      'name': 'Cơ Bản - Kiến thức cơ bản',
      'questions': [
        {
          'question': 'Số proton trong nguyên tử bằng?',
          'options': ['Số nơtron', 'Số electron', 'Số khối', 'Khối lượng'],
          'correct': 1,
          'points': 30,
        },
        {
          'question': 'Axit có vị gì?',
          'options': ['Ngọt', 'Chua', 'Đắng', 'Mặn'],
          'correct': 1,
          'points': 30,
        },
        {
          'question': 'Bazơ làm quỳ tím chuyển màu gì?',
          'options': ['Đỏ', 'Xanh', 'Vàng', 'Không đổi'],
          'correct': 1,
          'points': 30,
        },
        {
          'question': 'Kim loại nào dẫn điện tốt nhất?',
          'options': ['Vàng', 'Bạc', 'Đồng', 'Nhôm'],
          'correct': 1,
          'points': 30,
        },
        {
          'question': 'Phản ứng tỏa nhiệt là?',
          'options': ['Giải phóng nhiệt', 'Thu nhiệt', 'Không đổi nhiệt', 'Cả 3 đều sai'],
          'correct': 0,
          'points': 30,
        },
      ],
    },
    {
      'level': 2,
      'name': 'Trung Bình - Phản ứng hóa học',
      'questions': [
        {
          'question': 'Cân bằng: Fe + O₂ → Fe₂O₃. Hệ số của Fe?',
          'options': ['2', '3', '4', '6'],
          'correct': 2,
          'points': 35,
          'explanation': '4Fe + 3O₂ → 2Fe₂O₃',
        },
        {
          'question': 'Phản ứng nào là phản ứng thế?',
          'options': ['Zn + HCl → ZnCl₂ + H₂', 'H₂ + O₂ → H₂O', 'CaCO₃ → CaO + CO₂', 'NaCl + AgNO₃ → AgCl + NaNO₃'],
          'correct': 0,
          'points': 35,
        },
        {
          'question': 'Sản phẩm của phản ứng trung hòa là?',
          'options': ['Muối + Nước', 'Axit + Bazơ', 'Oxit + Nước', 'Muối + Khí'],
          'correct': 0,
          'points': 35,
        },
        {
          'question': 'Chất nào là chất oxi hóa?',
          'options': ['H₂', 'O₂', 'C', 'Fe'],
          'correct': 1,
          'points': 35,
        },
        {
          'question': 'Điện phân nước thu được?',
          'options': ['H₂ và O₂', 'H₂ và H₂O₂', 'O₂ và O₃', 'Chỉ có H₂'],
          'correct': 0,
          'points': 35,
        },
      ],
    },
    {
      'level': 3,
      'name': 'Nâng Cao - Tính toán nâng cao',
      'questions': [
        {
          'question': 'Cho 13g Zn tác dụng với HCl dư. Thể tích H₂ (đktc)?',
          'options': ['2.24L', '4.48L', '6.72L', '8.96L'],
          'correct': 1,
          'points': 50,
          'explanation': 'n(Zn) = 13/65 = 0.2 mol → n(H₂) = 0.2 mol → V = 0.2×22.4 = 4.48L',
        },
        {
          'question': 'Trộn 100ml HCl 0.2M với 100ml NaOH 0.2M. pH của dung dịch?',
          'options': ['pH = 1', 'pH = 7', 'pH = 10', 'pH = 14'],
          'correct': 1,
          'points': 50,
          'explanation': 'n(HCl) = n(NaOH) = 0.02 mol → Trung hòa hoàn toàn → pH = 7',
        },
        {
          'question': 'Hiệu suất phản ứng 80%. Cần bao nhiêu gam CaCO₃ để có 11.2g CaO?',
          'options': ['20g', '25g', '30g', '35g'],
          'correct': 1,
          'points': 50,
          'explanation': 'n(CaO) = 11.2/56 = 0.2 mol → n(CaCO₃) lý thuyết = 0.2 mol → m thực tế = 0.2×100/0.8 = 25g',
        },
        {
          'question': 'Độ tan của NaCl ở 20°C là 36g. Nồng độ % của dung dịch bão hòa?',
          'options': ['26.47%', '30.00%', '36.00%', '40.00%'],
          'correct': 0,
          'points': 50,
          'explanation': 'C% = 36/(36+100) × 100% = 26.47%',
        },
        {
          'question': 'Đốt cháy hoàn toàn 4.6g C₂H₅OH cần bao nhiêu lít O₂ (đktc)?',
          'options': ['4.48L', '6.72L', '8.96L', '11.2L'],
          'correct': 1,
          'points': 50,
          'explanation': 'n(C₂H₅OH) = 4.6/46 = 0.1 mol → n(O₂) = 0.3 mol → V = 0.3×22.4 = 6.72L',
        },
      ],
    },
  ];
}
