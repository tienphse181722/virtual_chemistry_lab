/// Dữ liệu đề thi - Các đề thi thử từ cơ bản đến nâng cao

class ExamData {
  // Đề thi thử số 1 - 40 câu (Cơ bản + Trung bình)
  static final List<Map<String, dynamic>> exam1 = [
    // PHẦN 1: CƠ BẢN (Câu 1-20)
    {
      'question': 'Nguyên tử nào sau đây có 6 proton?',
      'options': ['Carbon (C)', 'Oxygen (O)', 'Nitrogen (N)', 'Hydrogen (H)'],
      'correctAnswer': 0,
      'explanation': 'Carbon có số hiệu nguyên tử Z = 6, tức là có 6 proton.',
    },
    {
      'question': 'Phân tử H₂O có bao nhiêu nguyên tử?',
      'options': ['3', '2', '4', '5'],
      'correctAnswer': 0,
      'explanation': 'H₂O gồm 2 nguyên tử H và 1 nguyên tử O, tổng cộng 3 nguyên tử.',
    },
    {
      'question': 'Liên kết nào được hình thành giữa Na và Cl trong NaCl?',
      'options': ['Liên kết ion', 'Liên kết cộng hóa trị', 'Liên kết kim loại', 'Liên kết hydro'],
      'correctAnswer': 0,
      'explanation': 'Na (kim loại) và Cl (phi kim) tạo liên kết ion.',
    },
    {
      'question': '1 mol chất chứa bao nhiêu hạt?',
      'options': ['6.02×10²³', '6.02×10²²', '6.02×10²⁴', '6.02×10²¹'],
      'correctAnswer': 0,
      'explanation': 'Số Avogadro NA = 6.02×10²³ hạt/mol.',
    },
    {
      'question': 'Khối lượng mol của H₂O là bao nhiêu? (H=1, O=16)',
      'options': ['18 g/mol', '16 g/mol', '20 g/mol', '17 g/mol'],
      'correctAnswer': 0,
      'explanation': 'M(H₂O) = 2×1 + 16 = 18 g/mol.',
    },
    {
      'question': 'Thể tích của 1 mol khí ở đktc là?',
      'options': ['22.4 lít', '11.2 lít', '44.8 lít', '5.6 lít'],
      'correctAnswer': 0,
      'explanation': 'Ở điều kiện tiêu chuẩn, 1 mol khí có thể tích 22.4 lít.',
    },
    {
      'question': 'Phản ứng nào sau đây là phản ứng hóa hợp?',
      'options': ['2H₂ + O₂ → 2H₂O', 'CaCO₃ → CaO + CO₂', 'Zn + HCl → ZnCl₂ + H₂', 'NaCl + AgNO₃ → AgCl + NaNO₃'],
      'correctAnswer': 0,
      'explanation': 'Phản ứng hóa hợp: nhiều chất tạo thành một chất.',
    },
    {
      'question': 'Số oxi hóa của O trong H₂O là?',
      'options': ['-2', '+2', '0', '-1'],
      'correctAnswer': 0,
      'explanation': 'Oxygen thường có số oxi hóa -2 trong hợp chất.',
    },
    {
      'question': 'Tính số mol của 32g O₂? (O=16)',
      'options': ['1 mol', '2 mol', '0.5 mol', '4 mol'],
      'correctAnswer': 0,
      'explanation': 'n = m/M = 32/32 = 1 mol.',
    },
    {
      'question': 'Phân tử nào có liên kết cộng hóa trị phân cực?',
      'options': ['HCl', 'H₂', 'O₂', 'N₂'],
      'correctAnswer': 0,
      'explanation': 'HCl có độ âm điện khác nhau giữa H và Cl.',
    },
    {
      'question': 'Nguyên tử Na (Z=11) khi tạo ion sẽ?',
      'options': ['Nhường 1 electron', 'Nhận 1 electron', 'Nhường 2 electron', 'Không thay đổi'],
      'correctAnswer': 0,
      'explanation': 'Na có 1 electron lớp ngoài cùng, dễ nhường để đạt cấu hình bền.',
    },
    {
      'question': 'Công thức tính khối lượng từ số mol là?',
      'options': ['m = n × M', 'm = n / M', 'm = M / n', 'm = n + M'],
      'correctAnswer': 0,
      'explanation': 'Khối lượng = số mol × khối lượng mol.',
    },
    {
      'question': 'Phản ứng tỏa nhiệt có ΔH như thế nào?',
      'options': ['ΔH < 0', 'ΔH > 0', 'ΔH = 0', 'ΔH ≥ 0'],
      'correctAnswer': 0,
      'explanation': 'Phản ứng tỏa nhiệt giải phóng năng lượng, ΔH âm.',
    },
    {
      'question': 'Ankan có công thức chung là?',
      'options': ['CnH2n+2', 'CnH2n', 'CnH2n-2', 'CnH2n-6'],
      'correctAnswer': 0,
      'explanation': 'Ankan là hiđrocacbon no, mạch hở.',
    },
    {
      'question': 'Ancol etylic có công thức phân tử là?',
      'options': ['C₂H₅OH', 'CH₃OH', 'C₃H₇OH', 'C₄H₉OH'],
      'correctAnswer': 0,
      'explanation': 'Ancol etylic (Etanol) là C₂H₅OH.',
    },
    {
      'question': 'Axit axetic có công thức là?',
      'options': ['CH₃COOH', 'HCOOH', 'C₂H₅COOH', 'C₆H₅COOH'],
      'correctAnswer': 0,
      'explanation': 'Axit axetic là CH₃COOH.',
    },
    {
      'question': 'Glucozơ có công thức phân tử là?',
      'options': ['C₆H₁₂O₆', 'C₁₂H₂₂O₁₁', 'C₆H₁₀O₅', 'C₅H₁₀O₅'],
      'correctAnswer': 0,
      'explanation': 'Glucozơ là monosaccarit có công thức C₆H₁₂O₆.',
    },
    {
      'question': 'Phản ứng este hóa xảy ra giữa?',
      'options': ['Axit + Ancol', 'Axit + Bazơ', 'Kim loại + Axit', 'Muối + Axit'],
      'correctAnswer': 0,
      'explanation': 'Este hóa: Axit + Ancol → Este + Nước.',
    },
    {
      'question': 'Chất nào làm mất màu dung dịch Br₂?',
      'options': ['Anken', 'Ankan', 'Benzen', 'Ancol'],
      'correctAnswer': 0,
      'explanation': 'Anken có liên kết đôi, phản ứng cộng với Br₂.',
    },
    {
      'question': 'Phản ứng tráng bạc dùng để nhận biết?',
      'options': ['Anđehit', 'Xeton', 'Ancol', 'Axit'],
      'correctAnswer': 0,
      'explanation': 'Anđehit có tính khử, phản ứng với AgNO₃/NH₃.',
    },

    // PHẦN 2: TRUNG BÌNH (Câu 21-40)
    {
      'question': 'Tính khối lượng của 2 mol NaCl? (Na=23, Cl=35.5)',
      'options': ['117 g', '58.5 g', '234 g', '100 g'],
      'correctAnswer': 0,
      'explanation': 'M(NaCl) = 23 + 35.5 = 58.5 g/mol. m = 2 × 58.5 = 117 g.',
    },
    {
      'question': 'Có bao nhiêu mol trong 11.2 lít khí CO₂ (đktc)?',
      'options': ['0.5 mol', '1 mol', '2 mol', '0.25 mol'],
      'correctAnswer': 0,
      'explanation': 'n = V/22.4 = 11.2/22.4 = 0.5 mol.',
    },
    {
      'question': 'Đốt cháy 2.4g Mg thu được bao nhiêu gam MgO? (Mg=24, O=16)',
      'options': ['4 g', '2.4 g', '6.4 g', '8 g'],
      'correctAnswer': 0,
      'explanation': 'n(Mg) = 2.4/24 = 0.1 mol. n(MgO) = 0.1 mol. m(MgO) = 0.1 × 40 = 4 g.',
    },
    {
      'question': 'Cân bằng: Fe + O₂ → Fe₃O₄. Hệ số đúng là?',
      'options': ['3Fe + 2O₂ → Fe₃O₄', '2Fe + O₂ → Fe₃O₄', 'Fe + 2O₂ → Fe₃O₄', '4Fe + 3O₂ → Fe₃O₄'],
      'correctAnswer': 0,
      'explanation': '3Fe + 2O₂ → Fe₃O₄ (cân bằng số nguyên tử Fe và O).',
    },
    {
      'question': 'Tính % khối lượng O trong H₂O? (H=1, O=16)',
      'options': ['88.89%', '11.11%', '50%', '75%'],
      'correctAnswer': 0,
      'explanation': '%O = (16/18) × 100% = 88.89%.',
    },
    {
      'question': 'Cho 5.6g Fe tác dụng HCl dư. Thể tích H₂ (đktc)? (Fe=56)',
      'options': ['2.24 lít', '1.12 lít', '4.48 lít', '11.2 lít'],
      'correctAnswer': 0,
      'explanation': 'n(Fe) = 5.6/56 = 0.1 mol. n(H₂) = 0.1 mol. V = 0.1 × 22.4 = 2.24 lít.',
    },
    {
      'question': 'Phân tử CO₂ có cấu trúc hình học gì?',
      'options': ['Thẳng', 'Góc', 'Tứ diện', 'Tam giác phẳng'],
      'correctAnswer': 0,
      'explanation': 'CO₂ có cấu trúc O=C=O, dạng thẳng.',
    },
    {
      'question': 'Nguyên tử C trong CH₄ có lai hóa gì?',
      'options': ['sp³', 'sp²', 'sp', 'không lai hóa'],
      'correctAnswer': 0,
      'explanation': 'C trong CH₄ có 4 liên kết σ, lai hóa sp³.',
    },
    {
      'question': 'Tính nồng độ mol của dung dịch có 0.5 mol NaCl trong 2 lít?',
      'options': ['0.25 M', '0.5 M', '1 M', '2 M'],
      'correctAnswer': 0,
      'explanation': 'CM = n/V = 0.5/2 = 0.25 M.',
    },
    {
      'question': 'Hỗn hợp X gồm 0.2 mol N₂ và 0.3 mol O₂. Khối lượng? (N=14, O=16)',
      'options': ['15.2 g', '14.4 g', '16 g', '20 g'],
      'correctAnswer': 0,
      'explanation': 'm = 0.2×28 + 0.3×32 = 5.6 + 9.6 = 15.2 g.',
    },
    {
      'question': 'Phản ứng: 2KClO₃ → 2KCl + 3O₂. Đốt 24.5g KClO₃ thu được V lít O₂ (đktc)? (K=39, Cl=35.5, O=16)',
      'options': ['6.72 lít', '3.36 lít', '13.44 lít', '22.4 lít'],
      'correctAnswer': 0,
      'explanation': 'M(KClO₃) = 122.5 g/mol. n = 24.5/122.5 = 0.2 mol. n(O₂) = 0.3 mol. V = 6.72 lít.',
    },
    {
      'question': 'Anken có công thức chung là?',
      'options': ['CnH2n', 'CnH2n+2', 'CnH2n-2', 'CnH2n-6'],
      'correctAnswer': 0,
      'explanation': 'Anken có 1 liên kết đôi C=C.',
    },
    {
      'question': 'Phản ứng: C₂H₅OH + O₂ → ? (oxi hóa không hoàn toàn)',
      'options': ['CH₃CHO', 'CH₃COOH', 'CO₂', 'C₂H₄'],
      'correctAnswer': 0,
      'explanation': 'Ancol bậc 1 oxi hóa thành anđehit.',
    },
    {
      'question': 'Chất béo + NaOH → ?',
      'options': ['Glixerol + Xà phòng', 'Este + Nước', 'Axit + Ancol', 'Muối + H₂'],
      'correctAnswer': 0,
      'explanation': 'Phản ứng xà phòng hóa chất béo.',
    },
    {
      'question': 'Saccarozơ thủy phân tạo ra?',
      'options': ['Glucozơ + Fructozơ', 'Glucozơ + Glucozơ', 'Fructozơ + Fructozơ', 'Glucozơ + Galactozơ'],
      'correctAnswer': 0,
      'explanation': 'C₁₂H₂₂O₁₁ + H₂O → C₆H₁₂O₆ (glucozơ) + C₆H₁₂O₆ (fructozơ).',
    },
    {
      'question': 'Tính tỉ khối của CO₂ so với H₂? (C=12, O=16, H=1)',
      'options': ['22', '44', '11', '2'],
      'correctAnswer': 0,
      'explanation': 'd = M(CO₂)/M(H₂) = 44/2 = 22.',
    },
    {
      'question': 'Cho 13g Zn + HCl dư. Khối lượng ZnCl₂? (Zn=65, Cl=35.5)',
      'options': ['27.2 g', '13.6 g', '54.4 g', '40.8 g'],
      'correctAnswer': 0,
      'explanation': 'n(Zn) = 0.2 mol. n(ZnCl₂) = 0.2 mol. m = 0.2 × 136 = 27.2 g.',
    },
    {
      'question': 'Phản ứng nào tạo kết tủa đỏ gạch?',
      'options': ['Anđehit + Cu(OH)₂', 'Ancol + Na', 'Axit + NaOH', 'Este + H₂O'],
      'correctAnswer': 0,
      'explanation': 'Anđehit khử Cu(OH)₂ thành Cu₂O (đỏ gạch).',
    },
    {
      'question': 'Tinh bột + I₂ cho màu gì?',
      'options': ['Xanh tím', 'Đỏ', 'Vàng', 'Không màu'],
      'correctAnswer': 0,
      'explanation': 'Phản ứng đặc trưng nhận biết tinh bột.',
    },
    {
      'question': 'Phenol phản ứng với Br₂ tạo kết tủa trắng có công thức?',
      'options': ['C₆H₂Br₃OH', 'C₆H₅Br', 'C₆H₄Br₂', 'C₆HBr₅'],
      'correctAnswer': 0,
      'explanation': 'Phenol + 3Br₂ → C₆H₂Br₃OH (kết tủa trắng) + 3HBr.',
    },
  ];

  // Đề thi thử số 2 - 40 câu (Trung bình + Nâng cao)
  static final List<Map<String, dynamic>> exam2 = [
    // PHẦN 1: TRUNG BÌNH (Câu 1-20)
    {
      'question': 'Nguyên tử X có 20 electron, 20 neutron. Số khối của X là?',
      'options': ['40', '20', '60', '10'],
      'correctAnswer': 0,
      'explanation': 'A = Z + N = 20 + 20 = 40.',
    },
    {
      'question': 'Ion M²⁺ có 18 electron. M là nguyên tố nào?',
      'options': ['Ca (Z=20)', 'Mg (Z=12)', 'Ar (Z=18)', 'K (Z=19)'],
      'correctAnswer': 0,
      'explanation': 'M²⁺ có 18e → M có 20e → Z = 20 (Ca).',
    },
    {
      'question': 'Tính nồng độ mol của dung dịch có 0.5 mol NaCl trong 2 lít?',
      'options': ['0.25 M', '0.5 M', '1 M', '2 M'],
      'correctAnswer': 0,
      'explanation': 'CM = n/V = 0.5/2 = 0.25 M.',
    },
    {
      'question': 'Hỗn hợp X gồm 0.2 mol N₂ và 0.3 mol O₂. Khối lượng? (N=14, O=16)',
      'options': ['15.2 g', '14.4 g', '16 g', '20 g'],
      'correctAnswer': 0,
      'explanation': 'm = 0.2×28 + 0.3×32 = 5.6 + 9.6 = 15.2 g.',
    },
    {
      'question': 'Phân tử CO₂ có cấu trúc hình học gì?',
      'options': ['Thẳng', 'Góc', 'Tứ diện', 'Tam giác phẳng'],
      'correctAnswer': 0,
      'explanation': 'CO₂ có cấu trúc O=C=O, dạng thẳng.',
    },
    {
      'question': 'Nguyên tử C trong CH₄ có lai hóa gì?',
      'options': ['sp³', 'sp²', 'sp', 'không lai hóa'],
      'correctAnswer': 0,
      'explanation': 'C trong CH₄ có 4 liên kết σ, lai hóa sp³.',
    },
    {
      'question': 'Cho 13g Zn + HCl dư. Khối lượng ZnCl₂? (Zn=65, Cl=35.5)',
      'options': ['27.2 g', '13.6 g', '54.4 g', '40.8 g'],
      'correctAnswer': 0,
      'explanation': 'n(Zn) = 0.2 mol. n(ZnCl₂) = 0.2 mol. m = 0.2 × 136 = 27.2 g.',
    },
    {
      'question': 'Tính tỉ khối của CO₂ so với H₂? (C=12, O=16, H=1)',
      'options': ['22', '44', '11', '2'],
      'correctAnswer': 0,
      'explanation': 'd = M(CO₂)/M(H₂) = 44/2 = 22.',
    },
    {
      'question': 'Anken có công thức chung là?',
      'options': ['CnH2n', 'CnH2n+2', 'CnH2n-2', 'CnH2n-6'],
      'correctAnswer': 0,
      'explanation': 'Anken có 1 liên kết đôi C=C.',
    },
    {
      'question': 'Phản ứng: C₂H₅OH + O₂ → ? (oxi hóa không hoàn toàn)',
      'options': ['CH₃CHO', 'CH₃COOH', 'CO₂', 'C₂H₄'],
      'correctAnswer': 0,
      'explanation': 'Ancol bậc 1 oxi hóa thành anđehit.',
    },
    {
      'question': 'Chất béo + NaOH → ?',
      'options': ['Glixerol + Xà phòng', 'Este + Nước', 'Axit + Ancol', 'Muối + H₂'],
      'correctAnswer': 0,
      'explanation': 'Phản ứng xà phòng hóa chất béo.',
    },
    {
      'question': 'Saccarozơ thủy phân tạo ra?',
      'options': ['Glucozơ + Fructozơ', 'Glucozơ + Glucozơ', 'Fructozơ + Fructozơ', 'Glucozơ + Galactozơ'],
      'correctAnswer': 0,
      'explanation': 'C₁₂H₂₂O₁₁ + H₂O → C₆H₁₂O₆ (glucozơ) + C₆H₁₂O₆ (fructozơ).',
    },
    {
      'question': 'Phản ứng nào tạo kết tủa đỏ gạch?',
      'options': ['Anđehit + Cu(OH)₂', 'Ancol + Na', 'Axit + NaOH', 'Este + H₂O'],
      'correctAnswer': 0,
      'explanation': 'Anđehit khử Cu(OH)₂ thành Cu₂O (đỏ gạch).',
    },
    {
      'question': 'Tinh bột + I₂ cho màu gì?',
      'options': ['Xanh tím', 'Đỏ', 'Vàng', 'Không màu'],
      'correctAnswer': 0,
      'explanation': 'Phản ứng đặc trưng nhận biết tinh bột.',
    },
    {
      'question': 'Phenol phản ứng với Br₂ tạo kết tủa trắng có công thức?',
      'options': ['C₆H₂Br₃OH', 'C₆H₅Br', 'C₆H₄Br₂', 'C₆HBr₅'],
      'correctAnswer': 0,
      'explanation': 'Phenol + 3Br₂ → C₆H₂Br₃OH (kết tủa trắng) + 3HBr.',
    },
    {
      'question': 'Phân tử H₂O có góc liên kết bao nhiêu độ?',
      'options': ['104.5°', '109.5°', '120°', '180°'],
      'correctAnswer': 0,
      'explanation': 'H₂O có cấu trúc góc với góc liên kết 104.5°.',
    },
    {
      'question': 'Cân bằng: Fe + O₂ → Fe₂O₃. Hệ số đúng là?',
      'options': ['4Fe + 3O₂ → 2Fe₂O₃', '2Fe + O₂ → Fe₂O₃', 'Fe + O₂ → Fe₂O₃', '3Fe + 2O₂ → Fe₂O₃'],
      'correctAnswer': 0,
      'explanation': '4Fe + 3O₂ → 2Fe₂O₃ (cân bằng số nguyên tử Fe và O).',
    },
    {
      'question': 'Tính % khối lượng C trong CH₄? (C=12, H=1)',
      'options': ['75%', '25%', '50%', '80%'],
      'correctAnswer': 0,
      'explanation': '%C = (12/16) × 100% = 75%.',
    },
    {
      'question': 'Cho 11.2 lít khí CO₂ (đktc). Tính số mol CO₂?',
      'options': ['0.5 mol', '1 mol', '2 mol', '0.25 mol'],
      'correctAnswer': 0,
      'explanation': 'n = V/22.4 = 11.2/22.4 = 0.5 mol.',
    },
    {
      'question': 'Đốt cháy 2.4g C thu được bao nhiêu gam CO₂? (C=12)',
      'options': ['8.8 g', '4.4 g', '17.6 g', '2.2 g'],
      'correctAnswer': 0,
      'explanation': 'n(C) = 0.2 mol. n(CO₂) = 0.2 mol. m(CO₂) = 0.2 × 44 = 8.8 g.',
    },

    // PHẦN 2: NÂNG CAO (Câu 21-40)
    {
      'question': 'Hỗn hợp X gồm Fe, FeO, Fe₂O₃. Hòa tan 23.2g X trong HCl dư thu được 4.48 lít H₂ (đktc). Khối lượng Fe nguyên chất?',
      'options': ['11.2 g', '5.6 g', '16.8 g', '22.4 g'],
      'correctAnswer': 0,
      'explanation': 'Chỉ Fe phản ứng tạo H₂. n(H₂) = 0.2 mol → n(Fe) = 0.2 mol → m = 11.2 g.',
    },
    {
      'question': 'Đốt cháy hoàn toàn 0.1 mol hợp chất hữu cơ X (C, H, O) thu được 0.3 mol CO₂ và 0.4 mol H₂O. Công thức phân tử X? (Biết MX = 60)',
      'options': ['C₃H₈O', 'C₃H₆O', 'C₂H₆O', 'C₄H₁₀O'],
      'correctAnswer': 0,
      'explanation': 'n(C) = 0.3 mol, n(H) = 0.8 mol trong 0.1 mol X → C₃H₈O.',
    },
    {
      'question': 'Hỗn hợp khí gồm N₂ và H₂ có tỉ khối so với He là 1.75. % thể tích N₂ trong hỗn hợp?',
      'options': ['50%', '25%', '75%', '60%'],
      'correctAnswer': 0,
      'explanation': 'M hỗn hợp = 1.75 × 4 = 7. Giải hệ phương trình → %V(N₂) = 50%.',
    },
    {
      'question': 'Cho 11.2 lít hỗn hợp N₂ và H₂ (đktc) có khối lượng 4g. Số mol N₂ trong hỗn hợp?',
      'options': ['0.25 mol', '0.5 mol', '0.3 mol', '0.2 mol'],
      'correctAnswer': 0,
      'explanation': 'n tổng = 0.5 mol. Giải hệ: 28x + 2y = 4 và x + y = 0.5 → x = 0.25 mol.',
    },
    {
      'question': 'Hợp chất X có %C = 40%, %H = 6.67%, còn lại là O. Công thức đơn giản nhất của A?',
      'options': ['CH₂O', 'C₂H₄O₂', 'CH₃O', 'C₃H₆O₃'],
      'correctAnswer': 0,
      'explanation': 'Tỉ lệ C:H:O = (40/12):(6.67/1):(53.33/16) = 1:2:1 → CH₂O.',
    },
    {
      'question': 'Đốt cháy hoàn toàn hỗn hợp 2.4g C và 0.4g H₂ cần V lít O₂ (đktc). Tính V?',
      'options': ['6.72 lít', '4.48 lít', '8.96 lít', '11.2 lít'],
      'correctAnswer': 0,
      'explanation': 'n(C) = 0.2 mol, n(H₂) = 0.2 mol. n(O₂) = 0.2 + 0.1 = 0.3 mol. V = 6.72 lít.',
    },
    {
      'question': 'Ion M²⁺ có cấu hình electron lớp ngoài cùng là 3s² 3p⁶. M là nguyên tố nào?',
      'options': ['Ca (Calcium)', 'Mg (Magnesium)', 'Ar (Argon)', 'K (Potassium)'],
      'correctAnswer': 0,
      'explanation': 'M²⁺ có 18e → M có 20e → Z = 20 (Ca).',
    },
    {
      'question': 'Hỗn hợp X gồm CO và CO₂ có tỉ khối so với H₂ là 18. % khối lượng CO trong X?',
      'options': ['38.89%', '50%', '61.11%', '75%'],
      'correctAnswer': 0,
      'explanation': 'M hỗn hợp = 36. Giải hệ phương trình → %m(CO) = 38.89%.',
    },
    {
      'question': 'Nguyên tử X có tổng số hạt là 40, số hạt mang điện nhiều hơn số hạt không mang điện là 12. Số proton?',
      'options': ['13', '14', '12', '15'],
      'correctAnswer': 0,
      'explanation': '2Z + N = 40 và 2Z - N = 12. Giải hệ → Z = 13.',
    },
    {
      'question': 'Đốt 5.6g Fe trong O₂ dư thu được m gam Fe₃O₄. Tính m? (Fe=56, O=16)',
      'options': ['7.73 g', '8.0 g', '6.4 g', '9.2 g'],
      'correctAnswer': 0,
      'explanation': 'n(Fe) = 0.1 mol. 3Fe + 2O₂ → Fe₃O₄. n(Fe₃O₄) = 0.1/3 mol. m = 7.73 g.',
    },
    {
      'question': 'Cho 8.1g Al tác dụng với O₂ dư. Khối lượng Al₂O₃ thu được? (Al=27, O=16)',
      'options': ['15.3 g', '10.2 g', '20.4 g', '30.6 g'],
      'correctAnswer': 0,
      'explanation': 'n(Al) = 0.3 mol. 4Al + 3O₂ → 2Al₂O₃. n(Al₂O₃) = 0.15 mol. m = 15.3 g.',
    },
    {
      'question': 'Nguyên tử X có 3 lớp electron, lớp ngoài cùng có 6 electron. X là nguyên tố nào?',
      'options': ['S (Sulfur)', 'O (Oxygen)', 'Se (Selenium)', 'Cl (Chlorine)'],
      'correctAnswer': 0,
      'explanation': 'Cấu hình: 1s² 2s² 2p⁶ 3s² 3p⁴ → Z = 16 (S).',
    },
    {
      'question': 'Phản ứng: CaCO₃ → CaO + CO₂. Nung 50g CaCO₃ thu được 22.4g CaO. Hiệu suất phản ứng? (Ca=40, C=12, O=16)',
      'options': ['80%', '50%', '100%', '60%'],
      'correctAnswer': 0,
      'explanation': 'n(CaCO₃) = 0.5 mol. m(CaO) lý thuyết = 28g. H = 22.4/28 = 80%.',
    },
    {
      'question': 'Cho 11.2 lít khí CO (đktc) tác dụng với CuO dư nung nóng. Khối lượng Cu thu được? (Cu=64)',
      'options': ['32g', '16g', '64g', '8g'],
      'correctAnswer': 0,
      'explanation': 'n(CO) = 0.5 mol. CO + CuO → Cu + CO₂. n(Cu) = 0.5 mol. m = 32g.',
    },
    {
      'question': 'Năng lượng liên kết H-H = 436 kJ/mol, Cl-Cl = 243 kJ/mol, H-Cl = 432 kJ/mol. ΔH của H₂ + Cl₂ → 2HCl?',
      'options': ['-185 kJ', '+185 kJ', '-247 kJ', '+247 kJ'],
      'correctAnswer': 0,
      'explanation': 'ΔH = (436 + 243) - 2×432 = -185 kJ.',
    },
    {
      'question': 'Trong phản ứng: SO₂, S có lai hóa gì và cấu trúc hình học?',
      'options': ['sp², góc', 'sp³, góc', 'sp², thẳng', 'sp³, tháp tam giác'],
      'correctAnswer': 0,
      'explanation': 'S trong SO₂ có lai hóa sp² và cấu trúc góc.',
    },
    {
      'question': 'Tính bậc liên kết trong ion O₂⁺ theo thuyết MO?',
      'options': ['2.5', '2', '1.5', '3'],
      'correctAnswer': 0,
      'explanation': 'Bậc liên kết = (10-5)/2 = 2.5.',
    },
    {
      'question': 'Trong phân tử benzene C₆H₆, độ dài liên kết C-C là?',
      'options': ['Trung gian giữa đơn và đôi', 'Bằng liên kết đơn', 'Bằng liên kết đôi', 'Bằng liên kết ba'],
      'correctAnswer': 0,
      'explanation': 'Benzene có cộng hưởng, liên kết C-C trung gian giữa đơn và đôi.',
    },
    {
      'question': 'Phân tử NO₂ có tính thuận từ hay nghịch từ?',
      'options': ['Thuận từ (có electron độc thân)', 'Nghịch từ', 'Không xác định', 'Phụ thuộc nhiệt độ'],
      'correctAnswer': 0,
      'explanation': 'NO₂ có 1 electron độc thân nên có tính thuận từ.',
    },
    {
      'question': 'Trong phân tử CO₃²⁻, C có lai hóa gì?',
      'options': ['sp²', 'sp³', 'sp', 'sp³d'],
      'correctAnswer': 0,
      'explanation': 'C trong CO₃²⁻ có lai hóa sp², cấu trúc tam giác phẳng.',
    },
  ];

  // Đề thi thử số 3 - 40 câu (Nâng cao)
  static final List<Map<String, dynamic>> exam3 = [
    {
      'question': 'Hỗn hợp X gồm Fe, FeO, Fe₂O₃. Hòa tan 23.2g X trong HCl dư thu được 4.48 lít H₂ (đktc). Khối lượng Fe nguyên chất?',
      'options': ['11.2 g', '5.6 g', '16.8 g', '22.4 g'],
      'correctAnswer': 0,
      'explanation': 'Chỉ Fe phản ứng tạo H₂. n(H₂) = 0.2 mol → n(Fe) = 0.2 mol → m = 11.2 g.',
    },
    {
      'question': 'Đốt cháy hoàn toàn hỗn hợp gồm 0.1 mol ankan X và 0.15 mol anken Y thu được 0.55 mol CO₂. Công thức X và Y?',
      'options': ['C₂H₆ và C₃H₆', 'CH₄ và C₂H₄', 'C₃H₈ và C₄H₈', 'C₄H₁₀ và C₅H₁₀'],
      'correctAnswer': 0,
      'explanation': 'Giải hệ: 0.1x + 0.15y = 0.55. Với x=2, y=3 thỏa mãn.',
    },
    {
      'question': 'Hỗn hợp X gồm Al, Fe, Cu. Hòa tan 10g X trong HCl dư thu được 3.36 lít H₂ (đktc). Khối lượng Cu trong X?',
      'options': ['3.2 g', '6.4 g', '1.6 g', '4.8 g'],
      'correctAnswer': 0,
      'explanation': 'n(H₂) = 0.15 mol. Chỉ Al và Fe phản ứng. m(Al+Fe) = 6.8g → m(Cu) = 3.2g.',
    },
    {
      'question': 'Cho 0.1 mol hợp chất hữu cơ X (C, H, O) tác dụng với Na dư thu được 2.24 lít H₂ (đktc). X có mấy nhóm OH?',
      'options': ['2', '1', '3', '4'],
      'correctAnswer': 0,
      'explanation': 'n(H₂) = 0.1 mol. 2ROH + 2Na → 2RONa + H₂. Số nhóm OH = 0.2/0.1 = 2.',
    },
    {
      'question': 'Hỗn hợp khí X gồm H₂, CH₄, C₂H₄ có tỉ khối so với He là 3. Đốt cháy X thu được 4.48 lít CO₂ (đktc). Thể tích X (đktc)?',
      'options': ['4.48 lít', '2.24 lít', '6.72 lít', '8.96 lít'],
      'correctAnswer': 0,
      'explanation': 'M(X) = 12. n(CO₂) = 0.2 mol. Giải hệ phương trình → V(X) = 4.48 lít.',
    },
    {
      'question': 'Cho 0.1 mol este X (C, H, O) tác dụng với NaOH dư thu được 8.2g muối và 4.6g ancol. Công thức X?',
      'options': ['CH₃COOC₂H₅', 'HCOOC₂H₅', 'C₂H₅COOCH₃', 'CH₃COOCH₃'],
      'correctAnswer': 0,
      'explanation': 'Muối: CH₃COONa (M=82). Ancol: C₂H₅OH (M=46). → X là CH₃COOC₂H₅.',
    },
    {
      'question': 'Hỗn hợp X gồm Mg, Al, Zn. Hòa tan 10g X trong H₂SO₄ loãng dư thu được 5.6 lít H₂ (đktc). Số mol H₂SO₄ phản ứng?',
      'options': ['0.25 mol', '0.5 mol', '0.125 mol', '0.375 mol'],
      'correctAnswer': 0,
      'explanation': 'n(H₂) = 0.25 mol. Bảo toàn electron: n(H₂SO₄) = n(H₂) = 0.25 mol.',
    },
    {
      'question': 'Đốt cháy hoàn toàn 0.1 mol amino axit X thu được 0.3 mol CO₂, 0.35 mol H₂O và 0.05 mol N₂. Công thức X?',
      'options': ['C₃H₇O₂N', 'C₂H₅O₂N', 'C₄H₉O₂N', 'C₅H₁₁O₂N'],
      'correctAnswer': 0,
      'explanation': 'C:H:N = 3:7:1. Amino axit có 1N → C₃H₇O₂N (Alanine).',
    },
    {
      'question': 'Hỗn hợp X gồm ancol đơn chức và phenol. Cho 10.2g X tác dụng với Na dư thu được 2.24 lít H₂ (đktc). Khối lượng phenol?',
      'options': ['4.7 g', '5.5 g', '3.2 g', '6.4 g'],
      'correctAnswer': 0,
      'explanation': 'n(H₂) = 0.1 mol → n(OH) = 0.2 mol. Giải hệ phương trình → m(phenol) = 4.7g.',
    },
    {
      'question': 'Cho 0.1 mol peptit X thủy phân hoàn toàn thu được 0.3 mol glyxin. X là?',
      'options': ['Tripeptit', 'Dipeptit', 'Tetrapeptit', 'Pentapeptit'],
      'correctAnswer': 0,
      'explanation': 'n(glyxin)/n(peptit) = 3 → X là tripeptit.',
    },
    {
      'question': 'Hỗn hợp X gồm HCHO và HCOOH. Cho 6.2g X tác dụng với AgNO₃/NH₃ dư thu được 21.6g Ag. Khối lượng HCHO?',
      'options': ['3 g', '3.2 g', '2.4 g', '4.6 g'],
      'correctAnswer': 0,
      'explanation': 'n(Ag) = 0.2 mol. HCHO cho 4Ag, HCOOH cho 2Ag. Giải hệ → m(HCHO) = 3g.',
    },
    {
      'question': 'Cho 0.1 mol chất béo X tác dụng với NaOH dư thu được 0.3 mol xà phòng. X là triglixerit của?',
      'options': ['3 axit béo khác nhau', '1 axit béo', '2 axit béo', 'Không xác định'],
      'correctAnswer': 0,
      'explanation': 'n(xà phòng)/n(chất béo) = 3 → X có 3 gốc axit.',
    },
    {
      'question': 'Hỗn hợp X gồm glucozơ và saccarozơ. Cho 34.2g X tác dụng với AgNO₃/NH₃ dư thu được 21.6g Ag. Khối lượng glucozơ?',
      'options': ['18 g', '16.2 g', '20 g', '14.4 g'],
      'correctAnswer': 0,
      'explanation': 'Chỉ glucozơ phản ứng tráng bạc. n(Ag) = 0.2 mol → n(glucozơ) = 0.1 mol → m = 18g.',
    },
    {
      'question': 'Cho 0.1 mol anđehit X (no, đơn chức) tác dụng với H₂ dư (Ni, t°) thu được ancol Y. Đốt Y thu được 0.3 mol CO₂. Công thức X?',
      'options': ['C₃H₆O', 'C₂H₄O', 'C₄H₈O', 'C₅H₁₀O'],
      'correctAnswer': 0,
      'explanation': 'n(CO₂)/n(ancol) = 3 → Ancol có 3C → Anđehit C₃H₆O.',
    },
    {
      'question': 'Hỗn hợp X gồm Mg, MgO, MgCO₃. Hòa tan 20g X trong HCl dư thu được 4.48 lít H₂ (đktc) và 2.24 lít CO₂ (đktc). Khối lượng Mg?',
      'options': ['4.8 g', '2.4 g', '7.2 g', '9.6 g'],
      'correctAnswer': 0,
      'explanation': 'n(H₂) = 0.2 mol → n(Mg) = 0.2 mol → m = 4.8g.',
    },
    {
      'question': 'Cho 0.1 mol hợp chất hữu cơ X (C, H, O) tác dụng với NaHCO₃ dư thu được 2.24 lít CO₂ (đktc). X có mấy nhóm COOH?',
      'options': ['1', '2', '3', '0'],
      'correctAnswer': 0,
      'explanation': 'n(CO₂) = 0.1 mol. RCOOH + NaHCO₃ → RCOONa + H₂O + CO₂. Số nhóm COOH = 1.',
    },
    {
      'question': 'Hỗn hợp X gồm ankan và anken (cùng số C). Đốt cháy 0.2 mol X thu được 0.5 mol CO₂. Công thức phân tử?',
      'options': ['C₂H₆ và C₂H₄', 'C₃H₈ và C₃H₆', 'CH₄ và C₂H₄', 'C₄H₁₀ và C₄H₈'],
      'correctAnswer': 0,
      'explanation': 'n(CO₂)/n(X) = 2.5 → Trung bình 2.5C. Với C₂: ankan và anken.',
    },
    {
      'question': 'Cho 0.1 mol este X (no, đơn chức) tác dụng với NaOH dư thu được 6.8g muối và ancol Y. Đốt Y thu được 0.2 mol CO₂. Công thức X?',
      'options': ['C₂H₅COOC₂H₅', 'CH₃COOC₂H₅', 'HCOOC₂H₅', 'C₃H₇COOCH₃'],
      'correctAnswer': 0,
      'explanation': 'Muối: C₂H₅COONa (M=96, sai). Thử lại: M=68 → HCOONa. Ancol có 2C → HCOOC₂H₅.',
    },
    {
      'question': 'Hỗn hợp X gồm Al, Fe₂O₃, CuO. Cho 20g X tác dụng với HCl dư thu được dung dịch Y và 3.2g chất rắn. Khối lượng CuO?',
      'options': ['4 g', '8 g', '2 g', '6 g'],
      'correctAnswer': 0,
      'explanation': 'Chất rắn là Cu. n(Cu) = 0.05 mol → m(CuO) = 0.05 × 80 = 4g.',
    },
    {
      'question': 'Cho 0.1 mol disaccarit X thủy phân hoàn toàn thu được 0.2 mol monosaccarit. X là?',
      'options': ['Saccarozơ hoặc Mantozơ', 'Chỉ Saccarozơ', 'Chỉ Mantozơ', 'Xenlulozơ'],
      'correctAnswer': 0,
      'explanation': '1 phân tử disaccarit → 2 phân tử monosaccarit.',
    },
    {
      'question': 'Hỗn hợp X gồm CH₃OH và C₂H₅OH. Đốt cháy 9.2g X thu được 13.44 lít CO₂ (đktc). Khối lượng CH₃OH?',
      'options': ['3.2 g', '6 g', '4.6 g', '5.2 g'],
      'correctAnswer': 0,
      'explanation': 'n(CO₂) = 0.6 mol. Giải hệ: 32x + 46y = 9.2 và x + 2y = 0.6 → m(CH₃OH) = 3.2g.',
    },
    {
      'question': 'Cho 0.1 mol axit cacboxylic X (no, 2 chức) tác dụng với NaOH dư thu được 16.4g muối. Công thức X?',
      'options': ['HOOC-COOH', 'HOOC-CH₂-COOH', 'HOOC-(CH₂)₂-COOH', 'HOOC-(CH₂)₃-COOH'],
      'correctAnswer': 0,
      'explanation': 'M(muối) = 164. (COONa)₂ có M = 134 (sai). Thử HOOC-COOH → (COONa)₂ = 134.',
    },
    {
      'question': 'Hỗn hợp X gồm Zn, ZnO, ZnCO₃. Hòa tan 25g X trong H₂SO₄ loãng dư thu được 3.36 lít H₂ (đktc) và 1.12 lít CO₂ (đktc). Khối lượng ZnO?',
      'options': ['8.1 g', '6.25 g', '10 g', '12.5 g'],
      'correctAnswer': 0,
      'explanation': 'n(H₂) = 0.15 mol → m(Zn) = 9.75g. n(CO₂) = 0.05 mol → m(ZnCO₃) = 6.25g. m(ZnO) = 8.1g.',
    },
    {
      'question': 'Cho 0.1 mol hợp chất hữu cơ X (C, H, O, N) đốt cháy thu được 0.3 mol CO₂, 0.4 mol H₂O và 0.05 mol N₂. Công thức X?',
      'options': ['C₃H₈O₂N₂', 'C₃H₇O₂N', 'C₃H₆ON₂', 'C₃H₉ON'],
      'correctAnswer': 0,
      'explanation': 'C:H:N = 3:8:2. Với O: C₃H₈O₂N₂.',
    },
    {
      'question': 'Hỗn hợp X gồm anđehit no, đơn chức. Đốt 0.1 mol X thu được 0.25 mol CO₂. Công thức trung bình?',
      'options': ['C₂.₅H₅O', 'C₂H₄O', 'C₃H₆O', 'C₄H₈O'],
      'correctAnswer': 0,
      'explanation': 'Số C trung bình = 0.25/0.1 = 2.5 → C₂.₅H₅O.',
    },
    {
      'question': 'Cho 0.1 mol polime X thủy phân hoàn toàn thu được 0.6 mol amino axit. Hệ số polime hóa?',
      'options': ['6', '3', '4', '5'],
      'correctAnswer': 0,
      'explanation': 'n = n(amino axit)/n(polime) = 6.',
    },
    {
      'question': 'Hỗn hợp X gồm Fe, FeO, Fe₂O₃, Fe₃O₄. Hòa tan 30g X trong HNO₃ loãng dư thu được 2.24 lít NO (đktc). Số mol HNO₃ phản ứng?',
      'options': ['0.7 mol', '0.5 mol', '0.9 mol', '1.1 mol'],
      'correctAnswer': 0,
      'explanation': 'n(NO) = 0.1 mol. Bảo toàn electron và nguyên tố → n(HNO₃) = 0.7 mol.',
    },
    {
      'question': 'Cho 0.1 mol este X (no, 2 chức) tác dụng với NaOH dư thu được 16.4g muối và 9.2g ancol. Công thức X?',
      'options': ['(COOC₂H₅)₂', '(COOCH₃)₂', 'CH₃COO-CH₂-OOCCH₃', 'Không xác định'],
      'correctAnswer': 0,
      'explanation': 'Muối: (COONa)₂ (M=134). Ancol: C₂H₄(OH)₂ (M=62). → X là (COOC₂H₅)₂.',
    },
    {
      'question': 'Hỗn hợp X gồm CH₄, C₂H₄, C₃H₆. Đốt 0.3 mol X thu được 0.7 mol CO₂. % mol C₂H₄ biết %mol CH₄ = %mol C₃H₆?',
      'options': ['33.33%', '50%', '25%', '40%'],
      'correctAnswer': 0,
      'explanation': 'Gọi %mol CH₄ = %mol C₃H₆ = x. %mol C₂H₄ = 100-2x. Giải → x = 33.33%.',
    },
    {
      'question': 'Cho 0.1 mol hợp chất hữu cơ X (C, H, O) tác dụng với Na dư thu được 3.36 lít H₂ (đktc). X có mấy nhóm chức?',
      'options': ['3', '2', '1', '4'],
      'correctAnswer': 0,
      'explanation': 'n(H₂) = 0.15 mol. 2ROH + 2Na → 2RONa + H₂. Số nhóm OH = 0.3/0.1 = 3.',
    },
    {
      'question': 'Hỗn hợp X gồm Al, Mg. Hòa tan 5g X trong HCl dư thu được 5.6 lít H₂ (đktc). Khối lượng Al?',
      'options': ['2.7 g', '2.3 g', '3.2 g', '1.8 g'],
      'correctAnswer': 0,
      'explanation': 'n(H₂) = 0.25 mol. Giải hệ: 27x + 24y = 5 và 1.5x + y = 0.25 → m(Al) = 2.7g.',
    },
    {
      'question': 'Cho 0.1 mol ankan X tác dụng với Cl₂ (as) thu được 1 dẫn xuất monoclo duy nhất. X là?',
      'options': ['CH₄ hoặc C(CH₃)₄', 'C₂H₆', 'C₃H₈', 'C₄H₁₀'],
      'correctAnswer': 0,
      'explanation': 'Chỉ có CH₄ hoặc neopentane C(CH₃)₄ cho 1 sản phẩm monoclo.',
    },
    {
      'question': 'Hỗn hợp X gồm glucozơ, fructozơ, saccarozơ. Cho 51.3g X tác dụng với AgNO₃/NH₃ dư thu được 43.2g Ag. Khối lượng saccarozơ?',
      'options': ['17.1 g', '34.2 g', '25.65 g', '8.55 g'],
      'correctAnswer': 0,
      'explanation': 'Saccarozơ không phản ứng. n(Ag) = 0.4 mol → n(glucozơ+fructozơ) = 0.2 mol → m(saccarozơ) = 17.1g.',
    },
    {
      'question': 'Cho 0.1 mol axit hữu cơ X (no, đa chức) tác dụng với NaHCO₃ dư thu được 4.48 lít CO₂ (đktc). X có mấy nhóm COOH?',
      'options': ['2', '1', '3', '4'],
      'correctAnswer': 0,
      'explanation': 'n(CO₂) = 0.2 mol. Số nhóm COOH = 0.2/0.1 = 2.',
    },
    {
      'question': 'Hỗn hợp X gồm Fe, Cu. Hòa tan 12g X trong HNO₃ loãng dư thu được 4.48 lít NO (đktc). Khối lượng Cu?',
      'options': ['6.4 g', '5.6 g', '7.2 g', '4.8 g'],
      'correctAnswer': 0,
      'explanation': 'n(NO) = 0.2 mol. Bảo toàn electron: 3n(Fe) + 2n(Cu) = 3×0.2. Giải → m(Cu) = 6.4g.',
    },
    {
      'question': 'Cho 0.1 mol peptit X thủy phân hoàn toàn thu được 0.4 mol amino axit (gồm glyxin và alanin). X là?',
      'options': ['Tetrapeptit', 'Tripeptit', 'Pentapeptit', 'Hexapeptit'],
      'correctAnswer': 0,
      'explanation': 'n(amino axit)/n(peptit) = 4 → X là tetrapeptit.',
    },
    {
      'question': 'Hỗn hợp X gồm HCHO, CH₃CHO, C₂H₅CHO. Đốt 0.2 mol X thu được 0.5 mol CO₂. Công thức trung bình?',
      'options': ['C₂.₅H₅O', 'C₂H₄O', 'C₃H₆O', 'C₁.₅H₃O'],
      'correctAnswer': 0,
      'explanation': 'Số C trung bình = 0.5/0.2 = 2.5 → C₂.₅H₅O.',
    },
  ];

  // Chuyên đề nâng cao - 30 câu
  static final List<Map<String, dynamic>> advancedTopic = [
    {
      'question': 'Đốt cháy hoàn toàn 0.1 mol hợp chất hữu cơ X (C, H, O) thu được 0.3 mol CO₂ và 0.4 mol H₂O. Công thức phân tử X? (Biết MX = 60)',
      'options': ['C₃H₈O', 'C₃H₆O', 'C₂H₆O', 'C₄H₁₀O'],
      'correctAnswer': 0,
      'explanation': 'n(C) = 0.3 mol, n(H) = 0.8 mol trong 0.1 mol X → C₃H₈O.',
    },
    {
      'question': 'Hỗn hợp X gồm Al, Fe, Cu. Cho m gam X tác dụng với HNO₃ loãng dư thu được 4.48 lít NO (đktc) và dung dịch Y. Cô cạn Y thu được 75.2g muối khan. Tính m?',
      'options': ['16 g', '20 g', '24 g', '28 g'],
      'correctAnswer': 0,
      'explanation': 'n(NO) = 0.2 mol. Bảo toàn khối lượng và electron → m = 16g.',
    },
    {
      'question': 'Cho 0.1 mol hợp chất hữu cơ X (C, H, O, N) tác dụng với NaOH dư, đun nóng thu được 0.2 mol NH₃ và muối Y. X có mấy nhóm NH₂?',
      'options': ['2', '1', '3', '4'],
      'correctAnswer': 0,
      'explanation': 'n(NH₃)/n(X) = 2 → X có 2 nhóm NH₂.',
    },
    {
      'question': 'Hỗn hợp X gồm ankan, anken, ankin (cùng số C). Đốt 0.3 mol X thu được 0.8 mol CO₂. Số nguyên tử C?',
      'options': ['3', '2', '4', '5'],
      'correctAnswer': 0,
      'explanation': 'Số C trung bình = 0.8/0.3 ≈ 2.67 → Gần 3C.',
    },
    {
      'question': 'Cho 0.1 mol polisaccarit X thủy phân hoàn toàn thu được 0.6 mol glucozơ. Hệ số polime hóa?',
      'options': ['6', '5', '7', '8'],
      'correctAnswer': 0,
      'explanation': 'n = n(glucozơ)/n(polisaccarit) = 6.',
    },
    {
      'question': 'Hỗn hợp X gồm Fe₃O₄, CuO. Cho 1 mol X tác dụng với CO dư nung nóng thu được hỗn hợp rắn Y. Hòa tan Y trong HNO₃ loãng dư thu được V lít NO (đktc). Tính V?',
      'options': ['22.4 lít', '11.2 lít', '33.6 lít', '44.8 lít'],
      'correctAnswer': 0,
      'explanation': 'Bảo toàn electron: 8n(Fe₃O₄) + 2n(CuO) = 3n(NO). Với 1 mol X → V = 22.4 lít.',
    },
    {
      'question': 'Cho 0.1 mol este X (no, 3 chức) tác dụng với NaOH dư thu được glixerol và muối Y. Đốt Y thu được 0.3 mol CO₂. Công thức Y?',
      'options': ['HCOONa', 'CH₃COONa', 'C₂H₅COONa', 'C₃H₇COONa'],
      'correctAnswer': 0,
      'explanation': 'n(CO₂)/n(muối) = 1 → Muối có 1C → HCOONa.',
    },
    {
      'question': 'Hỗn hợp X gồm Mg, Al, Zn. Hòa tan 10g X trong H₂SO₄ đặc nóng dư thu được 6.72 lít SO₂ (đktc). Số mol H₂SO₄ phản ứng?',
      'options': ['0.7 mol', '0.5 mol', '0.9 mol', '1.1 mol'],
      'correctAnswer': 0,
      'explanation': 'n(SO₂) = 0.3 mol. Bảo toàn electron và nguyên tố S → n(H₂SO₄) = 0.7 mol.',
    },
    {
      'question': 'Cho 0.1 mol hợp chất hữu cơ X (C, H, O) tác dụng với Na dư thu được 4.48 lít H₂ (đktc) và với NaHCO₃ dư thu được 2.24 lít CO₂ (đktc). X có cấu tạo?',
      'options': ['2 nhóm OH và 1 nhóm COOH', '3 nhóm OH', '1 nhóm OH và 2 nhóm COOH', '4 nhóm OH'],
      'correctAnswer': 0,
      'explanation': 'n(H₂) = 0.2 mol → 4 nhóm chức. n(CO₂) = 0.1 mol → 1 COOH. Còn lại 2 OH.',
    },
    {
      'question': 'Hỗn hợp X gồm CH₃COOH, HCOOH, CH₃CHO. Cho 10.2g X tác dụng với AgNO₃/NH₃ dư thu được 43.2g Ag. Khối lượng CH₃COOH?',
      'options': ['6 g', '4.2 g', '8 g', '3.6 g'],
      'correctAnswer': 0,
      'explanation': 'HCOOH và CH₃CHO phản ứng. n(Ag) = 0.4 mol. Giải hệ → m(CH₃COOH) = 6g.',
    },
    {
      'question': 'Cho 0.1 mol amino axit X (có 1 nhóm NH₂ và 2 nhóm COOH) tác dụng với NaOH dư thu được m gam muối. Tính m?',
      'options': ['Phụ thuộc vào X', '10 g', '15 g', '20 g'],
      'correctAnswer': 0,
      'explanation': 'Muối có dạng (COONa)₂-CH(NH₂)-R. Khối lượng phụ thuộc vào R.',
    },
    {
      'question': 'Hỗn hợp X gồm Fe, FeO, Fe₂O₃, Fe₃O₄. Cho 1 mol X tác dụng với HCl dư thu được dung dịch Y chỉ chứa FeCl₂. Tỉ lệ mol Fe:FeO:Fe₂O₃:Fe₃O₄?',
      'options': ['Không xác định được', '1:1:1:1', '2:1:1:1', '1:2:1:1'],
      'correctAnswer': 0,
      'explanation': 'Có nhiều tỉ lệ thỏa mãn điều kiện chỉ tạo FeCl₂.',
    },
    {
      'question': 'Cho 0.1 mol este X (no, mạch hở, 2 chức) tác dụng với NaOH dư thu được ancol Y (no, 2 chức) và muối Z. Đốt Y thu được 0.2 mol CO₂. Công thức X?',
      'options': ['(COOC₂H₄)₂', '(COOCH₂)₂', 'CH₃COO-C₂H₄-OOCCH₃', 'Không xác định'],
      'correctAnswer': 0,
      'explanation': 'Ancol có 2C → C₂H₄(OH)₂. Este 2 chức → (COOC₂H₄)₂.',
    },
    {
      'question': 'Hỗn hợp X gồm glucozơ, mantozơ, saccarozơ. Thủy phân hoàn toàn 0.3 mol X thu được 0.5 mol monosaccarit. Số mol saccarozơ?',
      'options': ['0.1 mol', '0.15 mol', '0.2 mol', '0.05 mol'],
      'correctAnswer': 0,
      'explanation': 'Gọi n(glucozơ)=a, n(mantozơ)=b, n(saccarozơ)=c. a+2b+2c=0.5 và a+b+c=0.3 → c=0.1.',
    },
    {
      'question': 'Cho 0.1 mol hợp chất hữu cơ X (C, H, O, N) đốt cháy thu được 0.4 mol CO₂, 0.5 mol H₂O và 0.1 mol N₂. Công thức X?',
      'options': ['C₄H₁₀O₂N₂', 'C₄H₉O₂N', 'C₄H₈ON₂', 'C₄H₁₁ON'],
      'correctAnswer': 0,
      'explanation': 'C:H:N = 4:10:2. Với O: C₄H₁₀O₂N₂.',
    },
    {
      'question': 'Hỗn hợp X gồm Al, Fe, Cu. Hòa tan 20g X trong HNO₃ đặc nóng dư thu được 11.2 lít NO₂ (đktc) và dung dịch Y. Cô cạn Y thu được m gam muối. Tính m?',
      'options': ['68 g', '60 g', '76 g', '84 g'],
      'correctAnswer': 0,
      'explanation': 'n(NO₂) = 0.5 mol. Bảo toàn khối lượng: m(muối) = 20 + 63×0.5 + 62×0.5 = 68g.',
    },
    {
      'question': 'Cho 0.1 mol peptit X (mạch hở) thủy phân hoàn toàn thu được 0.3 mol glyxin và 0.2 mol alanin. X là?',
      'options': ['Pentapeptit', 'Tetrapeptit', 'Hexapeptit', 'Tripeptit'],
      'correctAnswer': 0,
      'explanation': 'Tổng amino axit = 0.5 mol. n = 0.5/0.1 = 5 → Pentapeptit.',
    },
    {
      'question': 'Hỗn hợp X gồm anđehit no, đơn chức và xeton no, đơn chức (cùng số C). Đốt 0.2 mol X thu được 0.6 mol CO₂. Công thức phân tử?',
      'options': ['C₃H₆O', 'C₂H₄O', 'C₄H₈O', 'C₅H₁₀O'],
      'correctAnswer': 0,
      'explanation': 'Số C = 0.6/0.2 = 3 → C₃H₆O.',
    },
    {
      'question': 'Cho 0.1 mol chất béo X tác dụng với I₂ dư (xúc tác) thu được chất béo Y no. Khối lượng tăng 12.7g. Số liên kết C=C trong X?',
      'options': ['5', '4', '6', '3'],
      'correctAnswer': 0,
      'explanation': 'Δm = 254n(I₂). n(I₂) = 0.05 mol. Số C=C = 0.05/0.1 = 5 (trên 1 phân tử X).',
    },
    {
      'question': 'Hỗn hợp X gồm Mg, MgO, Mg(OH)₂, MgCO₃. Hòa tan 30g X trong HCl dư thu được 6.72 lít H₂ (đktc) và 2.24 lít CO₂ (đktc). Khối lượng MgO?',
      'options': ['4 g', '8 g', '12 g', '16 g'],
      'correctAnswer': 0,
      'explanation': 'n(H₂)=0.3 → m(Mg)=7.2g. n(CO₂)=0.1 → m(MgCO₃)=8.4g. Bảo toàn Mg → m(MgO)=4g.',
    },
    {
      'question': 'Cho 0.1 mol hợp chất hữu cơ X (C, H, O) tác dụng với NaOH dư thu được 0.2 mol ancol và 0.1 mol muối. X là?',
      'options': ['Este 2 chức', 'Este đơn chức', 'Axit 2 chức', 'Ancol 2 chức'],
      'correctAnswer': 0,
      'explanation': 'n(ancol)/n(X) = 2 → X là este 2 chức.',
    },
    {
      'question': 'Hỗn hợp X gồm Fe, FeO, Fe₂O₃. Cho 1 mol X tác dụng với CO dư nung nóng thu được hỗn hợp rắn Y chỉ chứa Fe. Thể tích CO₂ (đktc)?',
      'options': ['Phụ thuộc vào tỉ lệ', '22.4 lít', '44.8 lít', '67.2 lít'],
      'correctAnswer': 0,
      'explanation': 'V(CO₂) phụ thuộc vào tỉ lệ mol FeO và Fe₂O₃ trong X.',
    },
    {
      'question': 'Cho 0.1 mol amino axit X (có 2 nhóm NH₂ và 1 nhóm COOH) tác dụng với HCl dư thu được m gam muối. Tính m?',
      'options': ['Phụ thuộc vào X', '10 g', '15 g', '20 g'],
      'correctAnswer': 0,
      'explanation': 'Muối có dạng (NH₃Cl)₂-R-COOH. Khối lượng phụ thuộc vào R.',
    },
    {
      'question': 'Hỗn hợp X gồm HCHO, CH₃CHO, HCOOH. Cho 10g X tác dụng với AgNO₃/NH₃ dư thu được 64.8g Ag. Khối lượng HCOOH?',
      'options': ['4.6 g', '3 g', '6 g', '5.2 g'],
      'correctAnswer': 0,
      'explanation': 'n(Ag) = 0.6 mol. HCHO cho 4Ag, CH₃CHO cho 2Ag, HCOOH cho 2Ag. Giải hệ → m(HCOOH)=4.6g.',
    },
    {
      'question': 'Cho 0.1 mol polime X (mạch thẳng) thủy phân hoàn toàn thu được 0.4 mol glyxin và 0.2 mol alanin. Hệ số polime hóa?',
      'options': ['6', '5', '7', '8'],
      'correctAnswer': 0,
      'explanation': 'Tổng amino axit = 0.6 mol. n = 0.6/0.1 = 6.',
    },
    {
      'question': 'Hỗn hợp X gồm Al, Fe, Cu. Hòa tan 15g X trong H₂SO₄ loãng dư thu được 6.72 lít H₂ (đktc) và chất rắn Y. Khối lượng Y?',
      'options': ['3.2 g', '6.4 g', '1.6 g', '4.8 g'],
      'correctAnswer': 0,
      'explanation': 'Y là Cu. n(H₂) = 0.3 mol. Bảo toàn khối lượng → m(Cu) = 3.2g.',
    },
    {
      'question': 'Cho 0.1 mol este X (no, mạch hở, 3 chức) tác dụng với NaOH dư thu được glixerol và 0.3 mol muối Y. Đốt Y thu được 0.6 mol CO₂. Công thức Y?',
      'options': ['CH₃COONa', 'HCOONa', 'C₂H₅COONa', 'C₃H₇COONa'],
      'correctAnswer': 0,
      'explanation': 'n(CO₂)/n(muối) = 2 → Muối có 2C → CH₃COONa.',
    },
    {
      'question': 'Hỗn hợp X gồm Mg, Al. Hòa tan 6g X trong HNO₃ loãng dư thu được 4.48 lít NO (đktc). Khối lượng Mg?',
      'options': ['2.4 g', '3.6 g', '4.8 g', '1.2 g'],
      'correctAnswer': 0,
      'explanation': 'n(NO) = 0.2 mol. Bảo toàn electron: 2n(Mg) + 3n(Al) = 3×0.2. Giải → m(Mg) = 2.4g.',
    },
    {
      'question': 'Cho 0.1 mol hợp chất hữu cơ X (C, H, O) tác dụng với Na dư thu được 5.6 lít H₂ (đktc). X có mấy nhóm OH?',
      'options': ['5', '4', '3', '6'],
      'correctAnswer': 0,
      'explanation': 'n(H₂) = 0.25 mol. 2ROH + 2Na → 2RONa + H₂. Số nhóm OH = 0.5/0.1 = 5.',
    },
  ];

  // Tổng ôn tập - 50 câu
  static final List<Map<String, dynamic>> comprehensiveReview = [
    // PHẦN 1: CƠ BẢN (Câu 1-20)
    {
      'question': 'Nguyên tử Carbon có 6 proton, 6 neutron. Kí hiệu đúng là?',
      'options': ['¹²C', '⁶C', '¹²₆C', '⁶₁₂C'],
      'correctAnswer': 0,
      'explanation': 'Số khối A = 12, số hiệu Z = 6.',
    },
    {
      'question': 'Phân tử H₂O có bao nhiêu nguyên tử?',
      'options': ['3', '2', '4', '5'],
      'correctAnswer': 0,
      'explanation': 'H₂O gồm 2 nguyên tử H và 1 nguyên tử O.',
    },
    {
      'question': 'Liên kết ion được hình thành giữa?',
      'options': ['Kim loại và phi kim', 'Phi kim và phi kim', 'Kim loại và kim loại', 'Khí hiếm'],
      'correctAnswer': 0,
      'explanation': 'Liên kết ion: kim loại nhường electron, phi kim nhận electron.',
    },
    {
      'question': '1 mol chất chứa bao nhiêu hạt?',
      'options': ['6.02×10²³', '6.02×10²²', '6.02×10²⁴', '6.02×10²¹'],
      'correctAnswer': 0,
      'explanation': 'Số Avogadro NA = 6.02×10²³ hạt/mol.',
    },
    {
      'question': 'Khối lượng mol của H₂O là? (H=1, O=16)',
      'options': ['18 g/mol', '16 g/mol', '20 g/mol', '17 g/mol'],
      'correctAnswer': 0,
      'explanation': 'M(H₂O) = 2×1 + 16 = 18 g/mol.',
    },
    {
      'question': 'Thể tích của 1 mol khí ở đktc là?',
      'options': ['22.4 lít', '11.2 lít', '44.8 lít', '5.6 lít'],
      'correctAnswer': 0,
      'explanation': 'Ở điều kiện tiêu chuẩn, 1 mol khí = 22.4 lít.',
    },
    {
      'question': 'Phản ứng nào là phản ứng hóa hợp?',
      'options': ['2H₂ + O₂ → 2H₂O', 'CaCO₃ → CaO + CO₂', 'Zn + HCl → ZnCl₂ + H₂', 'NaCl + AgNO₃ → AgCl + NaNO₃'],
      'correctAnswer': 0,
      'explanation': 'Phản ứng hóa hợp: nhiều chất → một chất.',
    },
    {
      'question': 'Số oxi hóa của O trong H₂O là?',
      'options': ['-2', '+2', '0', '-1'],
      'correctAnswer': 0,
      'explanation': 'Oxygen thường có số oxi hóa -2.',
    },
    {
      'question': 'Tính số mol của 32g O₂? (O=16)',
      'options': ['1 mol', '2 mol', '0.5 mol', '4 mol'],
      'correctAnswer': 0,
      'explanation': 'n = m/M = 32/32 = 1 mol.',
    },
    {
      'question': 'Phân tử nào có liên kết cộng hóa trị phân cực?',
      'options': ['HCl', 'H₂', 'O₂', 'N₂'],
      'correctAnswer': 0,
      'explanation': 'HCl có độ âm điện khác nhau.',
    },
    {
      'question': 'Ankan có công thức chung là?',
      'options': ['CnH2n+2', 'CnH2n', 'CnH2n-2', 'CnH2n-6'],
      'correctAnswer': 0,
      'explanation': 'Ankan là hiđrocacbon no, mạch hở.',
    },
    {
      'question': 'Ancol etylic có công thức là?',
      'options': ['C₂H₅OH', 'CH₃OH', 'C₃H₇OH', 'C₄H₉OH'],
      'correctAnswer': 0,
      'explanation': 'Ancol etylic (Etanol) là C₂H₅OH.',
    },
    {
      'question': 'Axit axetic có công thức là?',
      'options': ['CH₃COOH', 'HCOOH', 'C₂H₅COOH', 'C₆H₅COOH'],
      'correctAnswer': 0,
      'explanation': 'Axit axetic là CH₃COOH.',
    },
    {
      'question': 'Glucozơ có công thức phân tử là?',
      'options': ['C₆H₁₂O₆', 'C₁₂H₂₂O₁₁', 'C₆H₁₀O₅', 'C₅H₁₀O₅'],
      'correctAnswer': 0,
      'explanation': 'Glucozơ là monosaccarit C₆H₁₂O₆.',
    },
    {
      'question': 'Phản ứng este hóa xảy ra giữa?',
      'options': ['Axit + Ancol', 'Axit + Bazơ', 'Kim loại + Axit', 'Muối + Axit'],
      'correctAnswer': 0,
      'explanation': 'Este hóa: Axit + Ancol → Este + Nước.',
    },
    {
      'question': 'Chất nào làm mất màu dung dịch Br₂?',
      'options': ['Anken', 'Ankan', 'Benzen', 'Ancol'],
      'correctAnswer': 0,
      'explanation': 'Anken có liên kết đôi, phản ứng cộng với Br₂.',
    },
    {
      'question': 'Phản ứng tráng bạc dùng để nhận biết?',
      'options': ['Anđehit', 'Xeton', 'Ancol', 'Axit'],
      'correctAnswer': 0,
      'explanation': 'Anđehit có tính khử, phản ứng với AgNO₃/NH₃.',
    },
    {
      'question': 'Phản ứng tỏa nhiệt có ΔH như thế nào?',
      'options': ['ΔH < 0', 'ΔH > 0', 'ΔH = 0', 'ΔH ≥ 0'],
      'correctAnswer': 0,
      'explanation': 'Phản ứng tỏa nhiệt giải phóng năng lượng, ΔH âm.',
    },
    {
      'question': 'Công thức tính khối lượng từ số mol là?',
      'options': ['m = n × M', 'm = n / M', 'm = M / n', 'm = n + M'],
      'correctAnswer': 0,
      'explanation': 'Khối lượng = số mol × khối lượng mol.',
    },
    {
      'question': 'Nguyên tử Na (Z=11) khi tạo ion sẽ?',
      'options': ['Nhường 1 electron', 'Nhận 1 electron', 'Nhường 2 electron', 'Không thay đổi'],
      'correctAnswer': 0,
      'explanation': 'Na có 1 electron lớp ngoài cùng, dễ nhường.',
    },

    // PHẦN 2: TRUNG BÌNH (Câu 21-35)
    {
      'question': 'Tính khối lượng của 2 mol NaCl? (Na=23, Cl=35.5)',
      'options': ['117 g', '58.5 g', '234 g', '100 g'],
      'correctAnswer': 0,
      'explanation': 'M(NaCl) = 58.5 g/mol. m = 2 × 58.5 = 117 g.',
    },
    {
      'question': 'Có bao nhiêu mol trong 11.2 lít khí CO₂ (đktc)?',
      'options': ['0.5 mol', '1 mol', '2 mol', '0.25 mol'],
      'correctAnswer': 0,
      'explanation': 'n = V/22.4 = 11.2/22.4 = 0.5 mol.',
    },
    {
      'question': 'Đốt cháy 2.4g Mg thu được bao nhiêu gam MgO? (Mg=24, O=16)',
      'options': ['4 g', '2.4 g', '6.4 g', '8 g'],
      'correctAnswer': 0,
      'explanation': 'n(Mg) = 0.1 mol. n(MgO) = 0.1 mol. m = 4 g.',
    },
    {
      'question': 'Cân bằng: Fe + O₂ → Fe₃O₄. Hệ số đúng là?',
      'options': ['3Fe + 2O₂ → Fe₃O₄', '2Fe + O₂ → Fe₃O₄', 'Fe + 2O₂ → Fe₃O₄', '4Fe + 3O₂ → Fe₃O₄'],
      'correctAnswer': 0,
      'explanation': '3Fe + 2O₂ → Fe₃O₄ (cân bằng).',
    },
    {
      'question': 'Tính % khối lượng O trong H₂O? (H=1, O=16)',
      'options': ['88.89%', '11.11%', '50%', '75%'],
      'correctAnswer': 0,
      'explanation': '%O = (16/18) × 100% = 88.89%.',
    },
    {
      'question': 'Cho 5.6g Fe tác dụng HCl dư. Thể tích H₂ (đktc)? (Fe=56)',
      'options': ['2.24 lít', '1.12 lít', '4.48 lít', '11.2 lít'],
      'correctAnswer': 0,
      'explanation': 'n(Fe) = 0.1 mol. n(H₂) = 0.1 mol. V = 2.24 lít.',
    },
    {
      'question': 'Phân tử CO₂ có cấu trúc hình học gì?',
      'options': ['Thẳng', 'Góc', 'Tứ diện', 'Tam giác phẳng'],
      'correctAnswer': 0,
      'explanation': 'CO₂ có cấu trúc O=C=O, dạng thẳng.',
    },
    {
      'question': 'Nguyên tử C trong CH₄ có lai hóa gì?',
      'options': ['sp³', 'sp²', 'sp', 'không lai hóa'],
      'correctAnswer': 0,
      'explanation': 'C trong CH₄ có 4 liên kết σ, lai hóa sp³.',
    },
    {
      'question': 'Tính nồng độ mol của dung dịch có 0.5 mol NaCl trong 2 lít?',
      'options': ['0.25 M', '0.5 M', '1 M', '2 M'],
      'correctAnswer': 0,
      'explanation': 'CM = n/V = 0.5/2 = 0.25 M.',
    },
    {
      'question': 'Hỗn hợp X gồm 0.2 mol N₂ và 0.3 mol O₂. Khối lượng? (N=14, O=16)',
      'options': ['15.2 g', '14.4 g', '16 g', '20 g'],
      'correctAnswer': 0,
      'explanation': 'm = 0.2×28 + 0.3×32 = 15.2 g.',
    },
    {
      'question': 'Anken có công thức chung là?',
      'options': ['CnH2n', 'CnH2n+2', 'CnH2n-2', 'CnH2n-6'],
      'correctAnswer': 0,
      'explanation': 'Anken có 1 liên kết đôi C=C.',
    },
    {
      'question': 'Phản ứng: C₂H₅OH + O₂ → ? (oxi hóa không hoàn toàn)',
      'options': ['CH₃CHO', 'CH₃COOH', 'CO₂', 'C₂H₄'],
      'correctAnswer': 0,
      'explanation': 'Ancol bậc 1 oxi hóa thành anđehit.',
    },
    {
      'question': 'Chất béo + NaOH → ?',
      'options': ['Glixerol + Xà phòng', 'Este + Nước', 'Axit + Ancol', 'Muối + H₂'],
      'correctAnswer': 0,
      'explanation': 'Phản ứng xà phòng hóa chất béo.',
    },
    {
      'question': 'Saccarozơ thủy phân tạo ra?',
      'options': ['Glucozơ + Fructozơ', 'Glucozơ + Glucozơ', 'Fructozơ + Fructozơ', 'Glucozơ + Galactozơ'],
      'correctAnswer': 0,
      'explanation': 'C₁₂H₂₂O₁₁ + H₂O → C₆H₁₂O₆ (glucozơ) + C₆H₁₂O₆ (fructozơ).',
    },
    {
      'question': 'Tính tỉ khối của CO₂ so với H₂? (C=12, O=16, H=1)',
      'options': ['22', '44', '11', '2'],
      'correctAnswer': 0,
      'explanation': 'd = M(CO₂)/M(H₂) = 44/2 = 22.',
    },

    // PHẦN 3: NÂNG CAO (Câu 36-50)
    {
      'question': 'Hỗn hợp X gồm 0.2 mol N₂ và 0.3 mol O₂. Tính khối lượng hỗn hợp (N=14, O=16)?',
      'options': ['15.2 g', '14.4 g', '16.0 g', '20.0 g'],
      'correctAnswer': 0,
      'explanation': 'm = 0.2×28 + 0.3×32 = 5.6 + 9.6 = 15.2 g.',
    },
    {
      'question': 'Đốt cháy hoàn toàn 6g C thu được bao nhiêu lít CO₂ (đktc)? (C=12)',
      'options': ['11.2 lít', '22.4 lít', '5.6 lít', '33.6 lít'],
      'correctAnswer': 0,
      'explanation': 'n(C) = 0.5 mol. n(CO₂) = 0.5 mol. V = 11.2 lít.',
    },
    {
      'question': 'Hợp chất X có %O = 30%, M(X) = 232. Biết X chứa Fe. Công thức X?',
      'options': ['Fe₃O₄', 'FeO', 'Fe₂O₃', 'Fe₃O₂'],
      'correctAnswer': 0,
      'explanation': 'M(Fe₃O₄) = 232. %O = 64/232 ≈ 27.6% (gần 30%).',
    },
    {
      'question': 'Cho 13g Zn tác dụng với HCl dư. Thể tích H₂ thu được (đktc)? (Zn=65)',
      'options': ['4.48 lít', '2.24 lít', '11.2 lít', '22.4 lít'],
      'correctAnswer': 0,
      'explanation': 'n(Zn) = 0.2 mol. n(H₂) = 0.2 mol. V = 4.48 lít.',
    },
    {
      'question': 'Nguyên tử X có tổng số hạt là 40, số hạt mang điện nhiều hơn số hạt không mang điện là 12. Số proton?',
      'options': ['13', '14', '12', '15'],
      'correctAnswer': 0,
      'explanation': '2Z + N = 40 và 2Z - N = 12. Giải → Z = 13.',
    },
    {
      'question': 'Hỗn hợp khí gồm N₂ và H₂ có tỉ khối so với He là 1.75. % thể tích N₂?',
      'options': ['50%', '25%', '75%', '60%'],
      'correctAnswer': 0,
      'explanation': 'M hỗn hợp = 7. Giải hệ → %V(N₂) = 50%.',
    },
    {
      'question': 'Đốt 5.6g Fe trong O₂ dư thu được m gam Fe₃O₄. Tính m? (Fe=56, O=16)',
      'options': ['7.73 g', '8.0 g', '6.4 g', '9.2 g'],
      'correctAnswer': 0,
      'explanation': 'n(Fe) = 0.1 mol. n(Fe₃O₄) = 0.1/3 mol. m = 7.73 g.',
    },
    {
      'question': 'Hợp chất A có %C = 40%, %H = 6.67%, còn lại là O. Công thức đơn giản nhất?',
      'options': ['CH₂O', 'C₂H₄O₂', 'CH₃O', 'C₃H₆O₃'],
      'correctAnswer': 0,
      'explanation': 'Tỉ lệ C:H:O = 1:2:1 → CH₂O.',
    },
    {
      'question': 'Cho 8.1g Al tác dụng với O₂ dư. Khối lượng Al₂O₃? (Al=27, O=16)',
      'options': ['15.3 g', '10.2 g', '20.4 g', '30.6 g'],
      'correctAnswer': 0,
      'explanation': 'n(Al) = 0.3 mol. n(Al₂O₃) = 0.15 mol. m = 15.3 g.',
    },
    {
      'question': 'Nguyên tử X có 3 lớp electron, lớp ngoài cùng có 6 electron. X là?',
      'options': ['S (Sulfur)', 'O (Oxygen)', 'Se (Selenium)', 'Cl (Chlorine)'],
      'correctAnswer': 0,
      'explanation': 'Cấu hình: ...3s² 3p⁴ → Z = 16 (S).',
    },
    {
      'question': 'Hỗn hợp X gồm CO và CO₂ có tỉ khối so với H₂ là 18. % khối lượng CO?',
      'options': ['38.89%', '50%', '61.11%', '75%'],
      'correctAnswer': 0,
      'explanation': 'M hỗn hợp = 36. Giải hệ → %m(CO) = 38.89%.',
    },
    {
      'question': 'Cho 11.2 lít hỗn hợp N₂ và H₂ (đktc) có khối lượng 4g. Số mol N₂?',
      'options': ['0.25 mol', '0.5 mol', '0.3 mol', '0.2 mol'],
      'correctAnswer': 0,
      'explanation': 'n tổng = 0.5 mol. Giải hệ → n(N₂) = 0.25 mol.',
    },
    {
      'question': 'Đốt cháy hoàn toàn hỗn hợp 2.4g C và 0.4g H₂ cần V lít O₂ (đktc). Tính V?',
      'options': ['6.72 lít', '4.48 lít', '8.96 lít', '11.2 lít'],
      'correctAnswer': 0,
      'explanation': 'n(O₂) = 0.2 + 0.1 = 0.3 mol. V = 6.72 lít.',
    },
    {
      'question': 'Ion M²⁺ có cấu hình electron lớp ngoài cùng là 3s² 3p⁶. M là?',
      'options': ['Ca (Calcium)', 'Mg (Magnesium)', 'Ar (Argon)', 'K (Potassium)'],
      'correctAnswer': 0,
      'explanation': 'M²⁺ có 18e → M có 20e → Z = 20 (Ca).',
    },
    {
      'question': 'Hợp chất X có công thức CxHyOz. Đốt 0.1 mol X thu được 0.3 mol CO₂ và 0.4 mol H₂O. Công thức X?',
      'options': ['C₃H₈O', 'C₃H₆O', 'C₂H₆O', 'C₄H₁₀O'],
      'correctAnswer': 0,
      'explanation': 'C:H = 3:8 trong 0.1 mol X → C₃H₈O.',
    },
  ];

  // Helper method để lấy đề thi theo tên
  static List<Map<String, dynamic>> getExamByName(String examName) {
    switch (examName) {
      case 'Đề thi thử số 1':
        return exam1;
      case 'Đề thi thử số 2':
        return exam2;
      case 'Đề thi thử số 3':
        return exam3;
      case 'Chuyên đề nâng cao':
        return advancedTopic;
      case 'Tổng ôn tập':
        return comprehensiveReview;
      default:
        return exam1;
    }
  }

  // Tính điểm
  static Map<String, dynamic> calculateScore(List<int?> userAnswers, List<Map<String, dynamic>> examQuestions) {
    int correctCount = 0;
    int totalQuestions = examQuestions.length;
    
    for (int i = 0; i < totalQuestions; i++) {
      if (userAnswers[i] == examQuestions[i]['correctAnswer']) {
        correctCount++;
      }
    }
    
    double percentage = (correctCount / totalQuestions) * 100;
    double score = (correctCount / totalQuestions) * 10; // Thang điểm 10
    
    String grade;
    if (score >= 9) {
      grade = 'Xuất sắc';
    } else if (score >= 8) {
      grade = 'Giỏi';
    } else if (score >= 6.5) {
      grade = 'Khá';
    } else if (score >= 5) {
      grade = 'Trung bình';
    } else {
      grade = 'Yếu';
    }
    
    return {
      'correctCount': correctCount,
      'totalQuestions': totalQuestions,
      'percentage': percentage,
      'score': score,
      'grade': grade,
    };
  }
}
