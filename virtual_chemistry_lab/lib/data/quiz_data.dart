/// Quiz Data - Bộ câu hỏi hóa học từ cơ bản đến nâng cao
/// Bao gồm cả câu lý thuyết và câu tính toán

class QuizData {
  // Nguyên tử & Phân tử - 50 câu
  static final List<Map<String, dynamic>> atomAndMoleculeQuiz = [
    // CƠ BẢN (Câu 1-15)
    {
      'question': 'Nguyên tử là gì?',
      'options': [
        'Hạt cơ bản cấu tạo nên vật chất',
        'Phân tử nhỏ nhất',
        'Hợp chất hóa học',
        'Ion dương'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Hạt nào mang điện tích dương trong nguyên tử?',
      'options': ['Proton', 'Neutron', 'Electron', 'Photon'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Số proton trong nguyên tử bằng?',
      'options': [
        'Số electron (nguyên tử trung hòa)',
        'Số neutron',
        'Khối lượng nguyên tử',
        'Số oxi hóa'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Electron chuyển động ở đâu trong nguyên tử?',
      'options': [
        'Xung quanh hạt nhân',
        'Trong hạt nhân',
        'Giữa các nguyên tử',
        'Không chuyển động'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Khối lượng nguyên tử tập trung chủ yếu ở đâu?',
      'options': ['Hạt nhân', 'Lớp vỏ electron', 'Toàn bộ nguyên tử', 'Không gian trống'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Nguyên tử Hydro có bao nhiêu proton?',
      'options': ['1', '2', '3', '0'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phân tử là gì?',
      'options': [
        'Hạt đại diện cho chất, gồm nhiều nguyên tử liên kết',
        'Một nguyên tử đơn lẻ',
        'Hỗn hợp các chất',
        'Ion âm'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Số khối A được tính bằng?',
      'options': [
        'A = Z + N (Z: số proton, N: số neutron)',
        'A = Z - N',
        'A = Z × N',
        'A = Z'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Nguyên tử Carbon có 6 proton và 6 neutron. Số khối của nó là?',
      'options': ['12', '6', '18', '0'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Ion là gì?',
      'options': [
        'Nguyên tử hoặc nhóm nguyên tử mang điện',
        'Nguyên tử trung hòa',
        'Phân tử không mang điện',
        'Hạt nhân nguyên tử'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Nguyên tử Oxygen có 8 electron. Khi nhận thêm 2 electron, nó trở thành?',
      'options': ['Ion O²⁻', 'Ion O²⁺', 'Nguyên tử O', 'Phân tử O₂'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Đồng vị là gì?',
      'options': [
        'Các nguyên tử cùng số proton, khác số neutron',
        'Các nguyên tử khác số proton',
        'Các phân tử giống nhau',
        'Các ion cùng điện tích'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phân tử H₂O gồm mấy nguyên tử?',
      'options': ['3 nguyên tử', '2 nguyên tử', '4 nguyên tử', '1 nguyên tử'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Nguyên tố hóa học được xác định bởi?',
      'options': ['Số proton (số hiệu nguyên tử Z)', 'Số neutron', 'Số electron', 'Khối lượng'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Nguyên tử Na có 11 electron. Khi mất 1 electron, nó trở thành?',
      'options': ['Ion Na⁺', 'Ion Na⁻', 'Nguyên tử Na', 'Phân tử Na₂'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },

    // TRUNG BÌNH (Câu 16-35)
    {
      'question': 'Nguyên tử Chlorine có 17 proton, 18 neutron. Kí hiệu đúng là?',
      'options': ['³⁵Cl', '¹⁷Cl', '¹⁸Cl', '³⁵₁₇Cl'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính khối lượng mol của H₂O (H=1, O=16)?',
      'options': ['18 g/mol', '16 g/mol', '20 g/mol', '17 g/mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Có bao nhiêu mol nguyên tử trong 12g Carbon (C=12)?',
      'options': ['1 mol', '12 mol', '0.5 mol', '2 mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính số phân tử trong 0.5 mol H₂O (NA = 6.02×10²³)?',
      'options': ['3.01×10²³', '6.02×10²³', '1.5×10²³', '12.04×10²³'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Nguyên tử Fe có cấu hình electron: 1s² 2s² 2p⁶ 3s² 3p⁶ 3d⁶ 4s². Số electron lớp ngoài cùng?',
      'options': ['2', '6', '8', '26'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính khối lượng của 2 mol NaCl (Na=23, Cl=35.5)?',
      'options': ['117 g', '58.5 g', '234 g', '100 g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phân tử CO₂ có khối lượng mol là bao nhiêu (C=12, O=16)?',
      'options': ['44 g/mol', '28 g/mol', '32 g/mol', '60 g/mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Có 3.01×10²³ phân tử H₂. Đó là bao nhiêu mol?',
      'options': ['0.5 mol', '1 mol', '2 mol', '0.25 mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Nguyên tử Al³⁺ có 13 proton. Số electron của nó là?',
      'options': ['10', '13', '16', '3'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính % khối lượng của Oxygen trong H₂O (H=1, O=16)?',
      'options': ['88.89%', '11.11%', '50%', '75%'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Có 32g O₂. Tính số mol O₂ (O=16)?',
      'options': ['1 mol', '2 mol', '0.5 mol', '32 mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Nguyên tử Mg có 12 electron. Cấu hình electron đúng là?',
      'options': [
        '1s² 2s² 2p⁶ 3s²',
        '1s² 2s² 2p⁸ 3s²',
        '1s² 2s² 2p⁶ 3p²',
        '1s² 2s⁴ 2p⁶'
      ],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính khối lượng của 0.25 mol CaCO₃ (Ca=40, C=12, O=16)?',
      'options': ['25 g', '100 g', '50 g', '12.5 g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phân tử NH₃ có khối lượng mol là (N=14, H=1)?',
      'options': ['17 g/mol', '14 g/mol', '18 g/mol', '15 g/mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Có 11.2 lít khí H₂ (đktc). Tính số mol H₂?',
      'options': ['0.5 mol', '1 mol', '2 mol', '0.25 mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Ion Cl⁻ có 18 electron. Nguyên tử Cl có bao nhiêu electron?',
      'options': ['17', '18', '19', '16'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính % khối lượng của N trong NH₃ (N=14, H=1)?',
      'options': ['82.35%', '17.65%', '50%', '75%'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Có 4.48 lít khí O₂ (đktc). Tính khối lượng O₂ (O=16)?',
      'options': ['6.4 g', '3.2 g', '12.8 g', '32 g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Nguyên tử X có 20 electron, 20 neutron. Số khối của X là?',
      'options': ['40', '20', '60', '10'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính số nguyên tử trong 0.1 mol Fe (NA = 6.02×10²³)?',
      'options': ['6.02×10²²', '6.02×10²³', '6.02×10²¹', '6.02×10²⁴'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },

    // NÂNG CAO (Câu 36-50)
    {
      'question': 'Hỗn hợp X gồm 0.2 mol N₂ và 0.3 mol O₂. Tính khối lượng hỗn hợp (N=14, O=16)?',
      'options': ['15.2 g', '14.4 g', '16.0 g', '20.0 g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Đốt cháy hoàn toàn 6g C thu được bao nhiêu lít CO₂ (đktc)? (C=12)',
      'options': ['11.2 lít', '22.4 lít', '5.6 lít', '33.6 lít'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hợp chất X có công thức MxOy, %O = 30%. Biết M = 56. Công thức X là?',
      'options': ['Fe₃O₄', 'FeO', 'Fe₂O₃', 'Fe₃O₂'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Cho 13g Zn tác dụng với HCl dư. Thể tích H₂ thu được (đktc)? (Zn=65)',
      'options': ['4.48 lít', '2.24 lít', '11.2 lít', '22.4 lít'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Nguyên tử X có tổng số hạt là 40, số hạt mang điện nhiều hơn số hạt không mang điện là 12. Số proton?',
      'options': ['13', '14', '12', '15'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp khí gồm N₂ và H₂ có tỉ khối so với He là 1.75. % thể tích N₂ trong hỗn hợp?',
      'options': ['50%', '25%', '75%', '60%'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Đốt 5.6g Fe trong O₂ dư thu được m gam Fe₃O₄. Tính m? (Fe=56, O=16)',
      'options': ['7.73 g', '8.0 g', '6.4 g', '9.2 g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hợp chất A có %C = 40%, %H = 6.67%, còn lại là O. Công thức đơn giản nhất của A?',
      'options': ['CH₂O', 'C₂H₄O₂', 'CH₃O', 'C₃H₆O₃'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Cho 8.1g Al tác dụng với O₂ dư. Khối lượng Al₂O₃ thu được? (Al=27, O=16)',
      'options': ['15.3 g', '10.2 g', '20.4 g', '30.6 g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Nguyên tử X có 3 lớp electron, lớp ngoài cùng có 6 electron. X là nguyên tố nào?',
      'options': ['S (Sulfur)', 'O (Oxygen)', 'Se (Selenium)', 'Cl (Chlorine)'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp X gồm CO và CO₂ có tỉ khối so với H₂ là 18. % khối lượng CO trong X?',
      'options': ['38.89%', '50%', '61.11%', '75%'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Cho 11.2 lít hỗn hợp N₂ và H₂ (đktc) có khối lượng 4g. Số mol N₂ trong hỗn hợp?',
      'options': ['0.25 mol', '0.5 mol', '0.3 mol', '0.2 mol'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Đốt cháy hoàn toàn hỗn hợp 2.4g C và 0.4g H₂ cần V lít O₂ (đktc). Tính V?',
      'options': ['6.72 lít', '4.48 lít', '8.96 lít', '11.2 lít'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Ion M²⁺ có cấu hình electron lớp ngoài cùng là 3s² 3p⁶. M là nguyên tố nào?',
      'options': ['Ca (Calcium)', 'Mg (Magnesium)', 'Ar (Argon)', 'K (Potassium)'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hợp chất X có công thức CxHyOz. Đốt 0.1 mol X thu được 0.3 mol CO₂ và 0.4 mol H₂O. Công thức X?',
      'options': ['C₃H₈O', 'C₃H₆O', 'C₂H₆O', 'C₄H₁₀O'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
  ];

  // Liên kết hóa học - 50 câu
  static final List<Map<String, dynamic>> chemicalBondQuiz = [
    // CƠ BẢN (15 câu)
    {
      'question': 'Liên kết ion được hình thành giữa?',
      'options': [
        'Kim loại và phi kim',
        'Phi kim và phi kim',
        'Kim loại và kim loại',
        'Khí hiếm'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Liên kết cộng hóa trị được hình thành bởi?',
      'options': [
        'Sự dùng chung cặp electron',
        'Sự cho nhận electron',
        'Lực hút tĩnh điện',
        'Lực Van der Waals'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phân tử H₂ có mấy liên kết cộng hóa trị?',
      'options': ['1', '2', '3', '0'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'NaCl là hợp chất có liên kết gì?',
      'options': ['Liên kết ion', 'Liên kết cộng hóa trị', 'Liên kết kim loại', 'Liên kết hydro'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phân tử nào sau đây có liên kết cộng hóa trị phân cực?',
      'options': ['HCl', 'H₂', 'O₂', 'N₂'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Liên kết hydro là gì?',
      'options': [
        'Liên kết giữa H và nguyên tử có độ âm điện lớn',
        'Liên kết trong phân tử H₂',
        'Liên kết ion',
        'Liên kết kim loại'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phân tử O₂ có mấy liên kết?',
      'options': ['2 (liên kết đôi)', '1', '3', '0'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Liên kết cộng hóa trị không phân cực xuất hiện trong phân tử nào?',
      'options': ['Cl₂', 'HCl', 'H₂O', 'NH₃'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Nguyên tử Na (Z=11) khi tạo liên kết ion sẽ?',
      'options': ['Nhường 1 electron', 'Nhận 1 electron', 'Nhường 2 electron', 'Không thay đổi'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Nguyên tử Cl (Z=17) khi tạo liên kết ion sẽ?',
      'options': ['Nhận 1 electron', 'Nhường 1 electron', 'Nhận 2 electron', 'Không thay đổi'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phân tử N₂ có mấy liên kết?',
      'options': ['3 (liên kết ba)', '1', '2', '4'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Hợp chất nào sau đây có liên kết ion?',
      'options': ['KCl', 'CO₂', 'H₂O', 'CH₄'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Độ âm điện là gì?',
      'options': [
        'Khả năng hút electron của nguyên tử',
        'Điện tích của nguyên tử',
        'Số electron lớp ngoài',
        'Khối lượng nguyên tử'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phân tử H₂O có mấy liên kết cộng hóa trị?',
      'options': ['2', '1', '3', '4'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Liên kết kim loại xuất hiện trong?',
      'options': ['Kim loại nguyên chất', 'Hợp chất ion', 'Phân tử cộng hóa trị', 'Khí hiếm'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },

    // TRUNG BÌNH (20 câu)
    {
      'question': 'Phân tử CO₂ có cấu trúc hình học gì?',
      'options': ['Thẳng', 'Góc', 'Tứ diện', 'Tam giác phẳng'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phân tử NH₃ có cấu trúc hình học gì?',
      'options': ['Tháp tam giác', 'Tứ diện', 'Phẳng', 'Thẳng'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phân tử CH₄ có cấu trúc hình học gì?',
      'options': ['Tứ diện', 'Phẳng', 'Thẳng', 'Góc'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Trong phân tử HCl, nguyên tử nào có độ âm điện lớn hơn?',
      'options': ['Cl', 'H', 'Bằng nhau', 'Không xác định'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phân tử H₂O có góc liên kết bao nhiêu độ?',
      'options': ['104.5°', '109.5°', '120°', '180°'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Hợp chất MgO có liên kết gì?',
      'options': ['Liên kết ion', 'Liên kết cộng hóa trị', 'Liên kết kim loại', 'Liên kết hydro'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phân tử nào sau đây có liên kết hydro?',
      'options': ['H₂O', 'CH₄', 'CO₂', 'N₂'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Nguyên tử C trong CH₄ có lai hóa gì?',
      'options': ['sp³', 'sp²', 'sp', 'không lai hóa'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Nguyên tử C trong C₂H₄ có lai hóa gì?',
      'options': ['sp²', 'sp³', 'sp', 'không lai hóa'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phân tử BF₃ có cấu trúc hình học gì?',
      'options': ['Tam giác phẳng', 'Tứ diện', 'Tháp tam giác', 'Thẳng'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Trong phân tử HF, liên kết có tính chất gì?',
      'options': ['Cộng hóa trị phân cực mạnh', 'Cộng hóa trị không phân cực', 'Ion', 'Kim loại'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phân tử CO có mấy liên kết?',
      'options': ['3 (1 liên kết ba)', '1', '2', '4'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Hợp chất CaCl₂ được tạo bởi liên kết gì?',
      'options': ['Liên kết ion', 'Liên kết cộng hóa trị', 'Liên kết kim loại', 'Liên kết hydro'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phân tử nào sau đây có moment lưỡng cực khác 0?',
      'options': ['H₂O', 'CO₂', 'CH₄', 'BF₃'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Nguyên tử C trong C₂H₂ có lai hóa gì?',
      'options': ['sp', 'sp²', 'sp³', 'không lai hóa'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phân tử BeH₂ có cấu trúc hình học gì?',
      'options': ['Thẳng', 'Góc', 'Tam giác', 'Tứ diện'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Trong phân tử NH₃, N có mấy cặp electron chưa liên kết?',
      'options': ['1', '0', '2', '3'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phân tử PCl₅ có cấu trúc hình học gì?',
      'options': ['Lưỡng tháp tam giác', 'Tứ diện', 'Tam giác phẳng', 'Bát diện'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Hợp chất Al₂O₃ có liên kết gì?',
      'options': ['Liên kết ion', 'Liên kết cộng hóa trị', 'Liên kết kim loại', 'Liên kết hydro'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phân tử SF₆ có cấu trúc hình học gì?',
      'options': ['Bát diện', 'Tứ diện', 'Lưỡng tháp tam giác', 'Tam giác phẳng'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },

    // NÂNG CAO (15 câu)
    {
      'question': 'Năng lượng liên kết của H-H là 436 kJ/mol, Cl-Cl là 243 kJ/mol, H-Cl là 432 kJ/mol. Tính ΔH của phản ứng H₂ + Cl₂ → 2HCl?',
      'options': ['-185 kJ', '+185 kJ', '-247 kJ', '+247 kJ'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Phân tử XeF₄ có cấu trúc hình học gì?',
      'options': ['Vuông phẳng', 'Tứ diện', 'Bát diện', 'Lưỡng tháp tam giác'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Trong phân tử SO₂, S có lai hóa gì và cấu trúc hình học?',
      'options': ['sp², góc', 'sp³, góc', 'sp², thẳng', 'sp³, tháp tam giác'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Phân tử ClF₃ có cấu trúc hình học gì?',
      'options': ['Chữ T', 'Tam giác phẳng', 'Tháp tam giác', 'Thẳng'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Tính bậc liên kết trong ion O₂⁺ theo thuyết MO?',
      'options': ['2.5', '2', '1.5', '3'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Phân tử ICl₂⁻ có cấu trúc hình học gì?',
      'options': ['Thẳng', 'Góc', 'Chữ T', 'Tam giác phẳng'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Trong phân tử benzene C₆H₆, độ dài liên kết C-C là?',
      'options': ['Trung gian giữa đơn và đôi', 'Bằng liên kết đơn', 'Bằng liên kết đôi', 'Bằng liên kết ba'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Phân tử NO₂ có tính thuận từ hay nghịch từ?',
      'options': ['Thuận từ (có electron độc thân)', 'Nghịch từ', 'Không xác định', 'Phụ thuộc nhiệt độ'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Tính năng lượng mạng tinh thể của NaCl biết năng lượng ion hóa Na = 496 kJ/mol, ái lực electron Cl = -349 kJ/mol, năng lượng thăng hoa Na = 108 kJ/mol, năng lượng phân ly Cl₂ = 122 kJ/mol, ΔH tạo thành NaCl = -411 kJ/mol?',
      'options': ['-788 kJ/mol', '-411 kJ/mol', '-496 kJ/mol', '-349 kJ/mol'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Phân tử IF₅ có cấu trúc hình học gì?',
      'options': ['Tháp vuông', 'Lưỡng tháp tam giác', 'Bát diện', 'Tứ diện'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Trong phân tử CO₃²⁻, C có lai hóa gì?',
      'options': ['sp²', 'sp³', 'sp', 'sp³d'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Tính bậc liên kết trong phân tử NO theo thuyết MO?',
      'options': ['2.5', '2', '3', '1.5'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Phân tử XeF₂ có cấu trúc hình học gì?',
      'options': ['Thẳng', 'Góc', 'Chữ T', 'Tam giác phẳng'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Trong phân tử SO₄²⁻, S có lai hóa gì?',
      'options': ['sp³', 'sp²', 'sp', 'sp³d'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Phân tử BrF₅ có cấu trúc hình học gì?',
      'options': ['Tháp vuông', 'Lưỡng tháp tam giác', 'Bát diện', 'Tứ diện'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
  ];

  // Phản ứng hóa học - 50 câu
  static final List<Map<String, dynamic>> chemicalReactionQuiz = [
    // CƠ BẢN (15 câu)
    {
      'question': 'Phản ứng hóa học là gì?',
      'options': [
        'Quá trình biến đổi chất này thành chất khác',
        'Sự thay đổi trạng thái',
        'Sự hòa tan',
        'Sự bay hơi'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Dấu hiệu nào chứng tỏ có phản ứng hóa học?',
      'options': [
        'Xuất hiện chất mới',
        'Thay đổi hình dạng',
        'Thay đổi kích thước',
        'Thay đổi vị trí'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phản ứng nào sau đây là phản ứng hóa hợp?',
      'options': ['2H₂ + O₂ → 2H₂O', 'CaCO₃ → CaO + CO₂', 'Zn + 2HCl → ZnCl₂ + H₂', 'NaCl + AgNO₃ → AgCl + NaNO₃'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phản ứng phân hủy là gì?',
      'options': [
        'Một chất phân ra nhiều chất đơn giản hơn',
        'Nhiều chất tạo thành một chất',
        'Hai chất trao đổi thành phần',
        'Một chất đơn thay thế chất khác'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phản ứng thế là gì?',
      'options': [
        'Nguyên tử của đơn chất thay thế nguyên tử trong hợp chất',
        'Hai chất trao đổi thành phần',
        'Một chất phân ra nhiều chất',
        'Nhiều chất tạo thành một chất'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phản ứng trao đổi là gì?',
      'options': [
        'Hai hợp chất trao đổi thành phần cho nhau',
        'Một chất thay thế chất khác',
        'Một chất phân ra nhiều chất',
        'Nhiều chất tạo thành một chất'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phản ứng oxi hóa - khử là gì?',
      'options': [
        'Phản ứng có sự thay đổi số oxi hóa',
        'Phản ứng không thay đổi số oxi hóa',
        'Phản ứng tạo oxi',
        'Phản ứng tạo hydro'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Chất oxi hóa là chất?',
      'options': [
        'Nhận electron, số oxi hóa giảm',
        'Nhường electron, số oxi hóa tăng',
        'Không thay đổi số oxi hóa',
        'Tạo ra oxi'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Chất khử là chất?',
      'options': [
        'Nhường electron, số oxi hóa tăng',
        'Nhận electron, số oxi hóa giảm',
        'Không thay đổi số oxi hóa',
        'Khử oxi'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phản ứng nào sau đây là phản ứng thế?',
      'options': ['Zn + 2HCl → ZnCl₂ + H₂', '2H₂ + O₂ → 2H₂O', 'CaCO₃ → CaO + CO₂', 'NaCl + AgNO₃ → AgCl + NaNO₃'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Định luật bảo toàn khối lượng phát biểu?',
      'options': [
        'Tổng khối lượng sản phẩm = Tổng khối lượng chất tham gia',
        'Khối lượng tăng sau phản ứng',
        'Khối lượng giảm sau phản ứng',
        'Khối lượng không đổi'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phương trình hóa học cho biết điều gì?',
      'options': [
        'Chất tham gia, sản phẩm và tỉ lệ số mol',
        'Chỉ cho biết chất tham gia',
        'Chỉ cho biết sản phẩm',
        'Không cho biết gì'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Hệ số cân bằng trong phương trình hóa học cho biết?',
      'options': [
        'Tỉ lệ số mol các chất',
        'Khối lượng các chất',
        'Thể tích các chất',
        'Nhiệt độ phản ứng'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phản ứng thu nhiệt là phản ứng?',
      'options': [
        'Hấp thụ nhiệt từ môi trường',
        'Tỏa nhiệt ra môi trường',
        'Không trao đổi nhiệt',
        'Tạo ra nhiệt'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Phản ứng tỏa nhiệt là phản ứng?',
      'options': [
        'Giải phóng nhiệt ra môi trường',
        'Hấp thụ nhiệt từ môi trường',
        'Không trao đổi nhiệt',
        'Hấp thụ ánh sáng'
      ],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },

    // TRUNG BÌNH (20 câu)
    {
      'question': 'Cân bằng phương trình: Fe + O₂ → Fe₃O₄. Hệ số cân bằng đúng là?',
      'options': ['3Fe + 2O₂ → Fe₃O₄', '2Fe + O₂ → Fe₃O₄', 'Fe + 2O₂ → Fe₃O₄', '4Fe + 3O₂ → Fe₃O₄'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Cho 5.6g Fe tác dụng với HCl dư. Thể tích H₂ (đktc) thu được? (Fe=56)',
      'options': ['2.24 lít', '1.12 lít', '4.48 lít', '11.2 lít'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Đốt cháy 2.4g Mg trong O₂. Khối lượng MgO thu được? (Mg=24, O=16)',
      'options': ['4g', '2.4g', '6.4g', '8g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phản ứng: 2KClO₃ → 2KCl + 3O₂. Đốt 24.5g KClO₃ thu được bao nhiêu lít O₂ (đktc)? (K=39, Cl=35.5, O=16)',
      'options': ['6.72 lít', '3.36 lít', '13.44 lít', '22.4 lít'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Trong phản ứng: Zn + CuSO₄ → ZnSO₄ + Cu. Chất khử là?',
      'options': ['Zn', 'Cu²⁺', 'SO₄²⁻', 'Cu'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Trong phản ứng: 2Mg + O₂ → 2MgO. Số oxi hóa của Mg thay đổi như thế nào?',
      'options': ['0 → +2', '+2 → 0', '0 → -2', '-2 → 0'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Cho 13g Zn tác dụng với dung dịch H₂SO₄ loãng dư. Khối lượng ZnSO₄ thu được? (Zn=65, S=32, O=16, H=1)',
      'options': ['32.2g', '16.1g', '64.4g', '48.3g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Đốt cháy hoàn toàn 6.4g Cu trong O₂. Khối lượng CuO thu được? (Cu=64, O=16)',
      'options': ['8g', '6.4g', '16g', '4g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phản ứng: CaCO₃ → CaO + CO₂. Nung 50g CaCO₃ thu được 22.4g CaO. Hiệu suất phản ứng? (Ca=40, C=12, O=16)',
      'options': ['80%', '50%', '100%', '60%'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Cho 11.2 lít khí CO (đktc) tác dụng với CuO dư nung nóng. Khối lượng Cu thu được? (Cu=64)',
      'options': ['32g', '16g', '64g', '8g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Trong phản ứng: Fe₂O₃ + 3CO → 2Fe + 3CO₂. Chất oxi hóa là?',
      'options': ['Fe₂O₃', 'CO', 'Fe', 'CO₂'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Cho 8.1g Al tác dụng với dung dịch HCl dư. Thể tích H₂ (đktc) thu được? (Al=27)',
      'options': ['10.08 lít', '5.04 lít', '20.16 lít', '2.52 lít'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Đốt cháy 5.4g Al trong O₂. Khối lượng Al₂O₃ thu được? (Al=27, O=16)',
      'options': ['10.2g', '5.4g', '20.4g', '15.3g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phản ứng: 2Al + 3H₂SO₄ → Al₂(SO₄)₃ + 3H₂. Cho 5.4g Al tác dụng với H₂SO₄ dư. Số mol H₂ thu được? (Al=27)',
      'options': ['0.3 mol', '0.2 mol', '0.6 mol', '0.1 mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Trong phản ứng: Cl₂ + 2NaBr → 2NaCl + Br₂. Chất khử là?',
      'options': ['Br⁻', 'Cl₂', 'Na⁺', 'Br₂'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Cho 16g CuO tác dụng với H₂ dư nung nóng. Khối lượng Cu thu được? (Cu=64, O=16)',
      'options': ['12.8g', '16g', '6.4g', '32g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Đốt cháy 4.8g Mg trong không khí. Khối lượng MgO thu được? (Mg=24, O=16)',
      'options': ['8g', '4.8g', '12.8g', '16g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Phản ứng: 2Na + 2H₂O → 2NaOH + H₂. Cho 4.6g Na tác dụng với nước dư. Thể tích H₂ (đktc)? (Na=23)',
      'options': ['2.24 lít', '1.12 lít', '4.48 lít', '11.2 lít'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Trong phản ứng: 2H₂S + SO₂ → 3S + 2H₂O. Số oxi hóa của S trong H₂S thay đổi?',
      'options': ['-2 → 0', '0 → -2', '+4 → 0', '0 → +4'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Cho 10g hỗn hợp Fe và Cu tác dụng với HCl dư thu được 2.24 lít H₂ (đktc). Khối lượng Fe trong hỗn hợp? (Fe=56)',
      'options': ['5.6g', '4.4g', '10g', '2.8g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },

    // NÂNG CAO (15 câu)
    {
      'question': 'Cho 16g hỗn hợp Fe và FeO tác dụng với HCl dư thu được 4.48 lít H₂ (đktc). Khối lượng Fe trong hỗn hợp? (Fe=56, O=16)',
      'options': ['11.2g', '4.8g', '8g', '16g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Đốt cháy hoàn toàn hỗn hợp 2.4g C và 0.4g H₂ cần V lít O₂ (đktc). Tính V? (C=12, H=1, O=16)',
      'options': ['6.72 lít', '4.48 lít', '8.96 lít', '11.2 lít'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp X gồm Fe, FeO, Fe₂O₃. Hòa tan hoàn toàn 23.2g X trong HCl dư thu được 4.48 lít H₂ (đktc). Khối lượng Fe nguyên chất trong X? (Fe=56)',
      'options': ['11.2g', '5.6g', '16.8g', '22.4g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Cho 0.2 mol Fe vào dung dịch chứa 0.3 mol HCl. Sau phản ứng thu được bao nhiêu mol H₂?',
      'options': ['0.15 mol', '0.2 mol', '0.3 mol', '0.1 mol'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Đốt cháy hoàn toàn 0.1 mol hợp chất hữu cơ X (C, H, O) thu được 0.3 mol CO₂ và 0.4 mol H₂O. Công thức phân tử X là? (Biết MX = 60)',
      'options': ['C₃H₈O', 'C₃H₆O', 'C₂H₆O', 'C₄H₁₀O'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Cho hỗn hợp Al và Fe vào dung dịch HCl dư thu được 6.72 lít H₂ (đktc). Nếu cho hỗn hợp kim loại đó vào dung dịch NaOH dư thu được 3.36 lít H₂ (đktc). Khối lượng Al trong hỗn hợp? (Al=27)',
      'options': ['5.4g', '2.7g', '8.1g', '10.8g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Nung m gam hỗn hợp Fe và S trong điều kiện không có không khí thu được hỗn hợp rắn X. Hòa tan X trong HCl dư thu được hỗn hợp khí có tỉ khối so với H₂ là 9. Tỉ lệ mol Fe:S ban đầu?',
      'options': ['1:1', '2:1', '1:2', '3:1'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Cho 0.15 mol Fe vào 200ml dung dịch AgNO₃ 1M. Sau phản ứng thu được m gam chất rắn. Tính m? (Fe=56, Ag=108)',
      'options': ['21.6g', '32.4g', '10.8g', '43.2g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Đốt cháy hoàn toàn 0.2 mol hỗn hợp gồm CH₄, C₂H₄, C₃H₄ thu được 0.5 mol CO₂. Số mol H₂O thu được?',
      'options': ['0.5 mol', '0.4 mol', '0.6 mol', '0.3 mol'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Cho 11.2g Fe tác dụng với 200ml dung dịch CuSO₄ 1M. Sau phản ứng khối lượng chất rắn thu được? (Fe=56, Cu=64)',
      'options': ['12.8g', '11.2g', '24g', '6.4g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp X gồm Mg và MgO có khối lượng 12g. Hòa tan X trong dung dịch HCl dư thu được 5.6 lít H₂ (đktc). Khối lượng MgO trong X? (Mg=24, O=16)',
      'options': ['6g', '4g', '8g', '10g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Đốt cháy hoàn toàn hỗn hợp gồm 0.1 mol C₂H₂ và 0.2 mol H₂ trong O₂ vừa đủ. Thể tích O₂ (đktc) cần dùng?',
      'options': ['6.72 lít', '5.6 lít', '7.84 lít', '8.96 lít'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Cho 0.3 mol Al vào dung dịch chứa 0.5 mol Fe²⁺ và 0.2 mol Cu²⁺. Sau phản ứng hoàn toàn, khối lượng kim loại thu được? (Fe=56, Cu=64)',
      'options': ['40.8g', '28g', '12.8g', '53.6g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp X gồm CO và H₂ có tỉ khối so với He là 3.6. Đốt cháy hoàn toàn 0.5 mol X cần V lít O₂ (đktc). Tính V?',
      'options': ['6.72 lít', '5.6 lít', '7.84 lít', '11.2 lít'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Cho 19.2g Cu tác dụng với 500ml dung dịch HNO₃ 2M thu được V lít NO (đktc, sản phẩm khử duy nhất). Tính V? (Cu=64, N=14, O=16)',
      'options': ['4.48 lít', '2.24 lít', '6.72 lít', '8.96 lít'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
  ];

  // Mol & Tính toán - 50 câu (nhiều câu tính toán)
  static final List<Map<String, dynamic>> molCalculationQuiz = [
    // CƠ BẢN (15 câu)
    {
      'question': '1 mol chất chứa bao nhiêu hạt?',
      'options': ['6.02×10²³', '6.02×10²²', '6.02×10²⁴', '6.02×10²¹'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Tính số mol của 32g O₂ (O=16)?',
      'options': ['1 mol', '2 mol', '0.5 mol', '4 mol'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Khối lượng mol của H₂O là bao nhiêu (H=1, O=16)?',
      'options': ['18 g/mol', '16 g/mol', '20 g/mol', '17 g/mol'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Thể tích của 1 mol khí ở đktc là?',
      'options': ['22.4 lít', '11.2 lít', '44.8 lít', '5.6 lít'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Tính khối lượng của 1 mol NaCl (Na=23, Cl=35.5)?',
      'options': ['58.5g', '23g', '35.5g', '100g'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Có 2 mol H₂SO₄. Tính số phân tử H₂SO₄ (NA = 6.02×10²³)?',
      'options': ['12.04×10²³', '6.02×10²³', '3.01×10²³', '24.08×10²³'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Tính số mol của 44.8 lít khí CO₂ (đktc)?',
      'options': ['2 mol', '1 mol', '4 mol', '0.5 mol'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Khối lượng mol của CO₂ là (C=12, O=16)?',
      'options': ['44 g/mol', '28 g/mol', '32 g/mol', '60 g/mol'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Tính khối lượng của 0.5 mol H₂O (H=1, O=16)?',
      'options': ['9g', '18g', '4.5g', '36g'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Có 3.01×10²³ phân tử N₂. Đó là bao nhiêu mol?',
      'options': ['0.5 mol', '1 mol', '2 mol', '0.25 mol'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Tính thể tích của 2 mol khí H₂ (đktc)?',
      'options': ['44.8 lít', '22.4 lít', '11.2 lít', '89.6 lít'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Khối lượng mol của NH₃ là (N=14, H=1)?',
      'options': ['17 g/mol', '14 g/mol', '18 g/mol', '15 g/mol'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Tính số mol của 98g H₂SO₄ (H=1, S=32, O=16)?',
      'options': ['1 mol', '2 mol', '0.5 mol', '98 mol'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Có 0.25 mol CaCO₃. Tính khối lượng (Ca=40, C=12, O=16)?',
      'options': ['25g', '100g', '50g', '12.5g'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },
    {
      'question': 'Tính thể tích của 0.5 mol khí N₂ (đktc)?',
      'options': ['11.2 lít', '22.4 lít', '5.6 lít', '44.8 lít'],
      'correctAnswer': 0,
      'difficulty': 'easy',
    },

    // TRUNG BÌNH (20 câu - tính toán phức tạp hơn)
    {
      'question': 'Tính khối lượng của 2 mol H₂SO₄ (H=1, S=32, O=16)?',
      'options': ['196g', '98g', '294g', '49g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Có 22.4 lít khí N₂ (đktc). Tính số mol N₂?',
      'options': ['1 mol', '2 mol', '0.5 mol', '22.4 mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính thể tích của 0.5 mol khí CO₂ (đktc)?',
      'options': ['11.2 lít', '22.4 lít', '5.6 lít', '44.8 lít'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Hỗn hợp X gồm 0.2 mol N₂ và 0.3 mol O₂. Tính khối lượng hỗn hợp (N=14, O=16)?',
      'options': ['15.2g', '14.4g', '16.0g', '20.0g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính % khối lượng của O trong H₂SO₄ (H=1, S=32, O=16)?',
      'options': ['65.31%', '32.65%', '2.04%', '50%'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Có 16.8 lít khí SO₂ (đktc). Tính khối lượng SO₂ (S=32, O=16)?',
      'options': ['48g', '24g', '64g', '32g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính số nguyên tử trong 0.2 mol Fe (NA = 6.02×10²³)?',
      'options': ['1.204×10²³', '6.02×10²³', '3.01×10²³', '12.04×10²³'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Hỗn hợp khí gồm 0.1 mol CO và 0.2 mol CO₂. Tính khối lượng hỗn hợp (C=12, O=16)?',
      'options': ['11.6g', '8.8g', '14.4g', '20g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính % khối lượng của N trong Ca(NO₃)₂ (Ca=40, N=14, O=16)?',
      'options': ['17.07%', '24.39%', '58.54%', '40%'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Có 13.44 lít khí NH₃ (đktc). Tính khối lượng NH₃ (N=14, H=1)?',
      'options': ['10.2g', '5.1g', '20.4g', '15.3g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính tỉ khối của CO₂ so với H₂ (C=12, O=16, H=1)?',
      'options': ['22', '44', '11', '2'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Hỗn hợp khí có khối lượng mol trung bình là 36 g/mol. Tỉ khối so với H₂?',
      'options': ['18', '36', '9', '72'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Có 0.3 mol Al₂(SO₄)₃. Tính số mol ion SO₄²⁻?',
      'options': ['0.9 mol', '0.3 mol', '0.6 mol', '1.2 mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính khối lượng của 3.36 lít khí O₂ (đktc) (O=16)?',
      'options': ['4.8g', '2.4g', '9.6g', '16g'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Hỗn hợp X gồm N₂ và H₂ có tỉ khối so với He là 1.75. % thể tích N₂?',
      'options': ['50%', '25%', '75%', '60%'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Có 0.4 mol FeCl₃. Tính số mol ion Cl⁻?',
      'options': ['1.2 mol', '0.4 mol', '0.8 mol', '1.6 mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính % khối lượng của Cu trong CuSO₄ (Cu=64, S=32, O=16)?',
      'options': ['40%', '20%', '50%', '64%'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Có 8.96 lít hỗn hợp N₂ và O₂ (đktc) có khối lượng 12.4g. Số mol N₂?',
      'options': ['0.3 mol', '0.1 mol', '0.2 mol', '0.4 mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Tính khối lượng mol trung bình của hỗn hợp gồm 0.2 mol CO và 0.3 mol CO₂ (C=12, O=16)?',
      'options': ['38.4 g/mol', '36 g/mol', '40 g/mol', '44 g/mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },
    {
      'question': 'Có 0.25 mol Na₂SO₄. Tính số mol ion Na⁺?',
      'options': ['0.5 mol', '0.25 mol', '0.75 mol', '1 mol'],
      'correctAnswer': 0,
      'difficulty': 'medium',
    },

    // NÂNG CAO (15 câu - tính toán phức tạp)
    {
      'question': 'Hỗn hợp X gồm CO và CO₂ có tỉ khối so với H₂ là 18. % khối lượng CO trong X (C=12, O=16)?',
      'options': ['38.89%', '50%', '61.11%', '75%'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Cho 11.2 lít hỗn hợp N₂ và H₂ (đktc) có khối lượng 4g. Số mol N₂ (N=14, H=1)?',
      'options': ['0.25 mol', '0.5 mol', '0.3 mol', '0.2 mol'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp khí gồm CH₄, C₂H₆, C₃H₈ có tỉ khối so với H₂ là 15. Khối lượng mol trung bình?',
      'options': ['30 g/mol', '15 g/mol', '60 g/mol', '45 g/mol'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hòa tan hoàn toàn 24.4g hỗn hợp gồm Mg, Al, Zn trong HCl dư thu được 22.4 lít H₂ (đktc). Số mol HCl phản ứng?',
      'options': ['2 mol', '1 mol', '3 mol', '4 mol'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Đốt cháy hoàn toàn 0.1 mol hợp chất hữu cơ X (CxHyOz) thu được 6.72 lít CO₂ (đktc) và 7.2g H₂O. Công thức X? (C=12, H=1, O=16)',
      'options': ['C₃H₈O', 'C₃H₆O', 'C₂H₆O', 'C₄H₁₀O'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp X gồm N₂, H₂, NH₃ có tỉ khối so với H₂ là 8.5. Cho X qua H₂SO₄ đặc dư, khí thoát ra có tỉ khối so với H₂ là 7. % thể tích NH₃ trong X?',
      'options': ['25%', '50%', '75%', '10%'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp X gồm Fe, FeO, Fe₂O₃, Fe₃O₄ có khối lượng 20g. Hòa tan X trong HCl dư thu được 4.48 lít H₂ (đktc). Khối lượng Fe nguyên chất?',
      'options': ['11.2g', '5.6g', '8.4g', '14g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Đốt cháy hoàn toàn hỗn hợp gồm 0.1 mol C₂H₂, 0.15 mol C₂H₄, 0.2 mol CH₄ cần V lít O₂ (đktc). Tính V?',
      'options': ['19.04 lít', '15.68 lít', '22.4 lít', '11.2 lít'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp X gồm Mg và MgO có khối lượng 16g. Hòa tan X trong HCl dư thu được 11.2 lít H₂ (đktc). % khối lượng Mg trong X? (Mg=24, O=16)',
      'options': ['75%', '50%', '25%', '60%'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp khí X gồm CO, CO₂, O₂ có tỉ khối so với H₂ là 18. Cho X qua dung dịch Ca(OH)₂ dư, khí thoát ra có tỉ khối so với H₂ là 15. % thể tích CO₂ trong X?',
      'options': ['40%', '30%', '50%', '60%'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Đốt cháy hoàn toàn m gam hỗn hợp gồm C₂H₂ và H₂ thu được 8.96 lít CO₂ (đktc) và 9g H₂O. Tính m? (C=12, H=1, O=16)',
      'options': ['5.2g', '4.8g', '6.4g', '7.2g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp X gồm Al, Fe, Cu. Hòa tan 10g X trong HCl dư thu được 4.48 lít H₂ (đktc). Hòa tan 10g X trong NaOH dư thu được 3.36 lít H₂ (đktc). Khối lượng Cu trong X? (Al=27, Fe=56, Cu=64)',
      'options': ['1.6g', '2.4g', '3.2g', '4.8g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp X gồm CO và H₂ có tỉ khối so với He là 3.6. Đốt cháy hoàn toàn 11.2 lít X (đktc) thu được m gam H₂O. Tính m? (H=1, O=16)',
      'options': ['5.4g', '3.6g', '7.2g', '9g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp X gồm CH₄, C₂H₄, C₃H₄. Đốt cháy hoàn toàn 0.3 mol X thu được 0.7 mol CO₂ và 0.8 mol H₂O. Số mol CH₄ trong X?',
      'options': ['0.1 mol', '0.15 mol', '0.2 mol', '0.05 mol'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
    {
      'question': 'Hỗn hợp X gồm Fe, FeO, Fe₂O₃. Cho 23.2g X tác dụng với CO dư nung nóng thu được 20.16g Fe. Khối lượng O trong X? (Fe=56, O=16)',
      'options': ['4.8g', '3.2g', '6.4g', '8g'],
      'correctAnswer': 0,
      'difficulty': 'hard',
    },
  ];

  // Helper method để lấy quiz theo chủ đề
  static List<Map<String, dynamic>> getQuizByTopic(String topic) {
    switch (topic) {
      case 'Nguyên tử & Phân tử':
        return atomAndMoleculeQuiz;
      case 'Liên kết hóa học':
        return chemicalBondQuiz;
      case 'Phản ứng cơ bản':
        return chemicalReactionQuiz;
      case 'Mol & Tính toán':
        return molCalculationQuiz;
      default:
        return atomAndMoleculeQuiz;
    }
  }

  // Lấy câu hỏi theo độ khó
  static List<Map<String, dynamic>> getQuizByDifficulty(
    List<Map<String, dynamic>> allQuestions,
    String difficulty,
  ) {
    return allQuestions
        .where((q) => q['difficulty'] == difficulty)
        .toList();
  }

  // Trộn ngẫu nhiên câu hỏi
  static List<Map<String, dynamic>> shuffleQuiz(List<Map<String, dynamic>> questions) {
    final shuffled = List<Map<String, dynamic>>.from(questions);
    shuffled.shuffle();
    return shuffled;
  }
}
