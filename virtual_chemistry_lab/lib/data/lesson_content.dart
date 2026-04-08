/// Nội dung bài học hóa học - Lý thuyết và công thức từ cơ bản đến nâng cao

class LessonContent {
  static Map<String, dynamic> getLessonContent(String topic) {
    switch (topic) {
      case 'Nguyên tử & Phân tử':
        return _atomAndMoleculeContent;
      case 'Liên kết hóa học':
        return _chemicalBondContent;
      case 'Phản ứng cơ bản':
        return _chemicalReactionContent;
      case 'Mol & Tính toán':
        return _molCalculationContent;
      case 'Hiđrocacbon':
        return _hydrocarbonContent;
      case 'Ancol & Phenol':
        return _alcoholPhenolContent;
      case 'Anđehit & Xeton':
        return _aldehydeKetoneContent;
      case 'Axit cacboxylic':
        return _carboxylicAcidContent;
      case 'Este & Lipit':
        return _esterLipidContent;
      case 'Cacbohiđrat':
        return _carbohydrateContent;
      default:
        return _defaultContent;
    }
  }

  static final Map<String, dynamic> _atomAndMoleculeContent = {
    'title': 'Nguyên tử & Phân tử',
    'sections': [
      {
        'level': 'Cơ bản',
        'icon': '📚',
        'content': [
          {
            'heading': '1. Nguyên tử là gì?',
            'text': 'Nguyên tử là hạt vô cùng nhỏ, trung hòa về điện, là đơn vị cấu tạo nên vật chất.',
          },
          {
            'heading': '2. Cấu tạo nguyên tử',
            'text': '''• Hạt nhân: Gồm proton (+) và neutron (không mang điện)
• Vỏ nguyên tử: Gồm các electron (-) chuyển động xung quanh hạt nhân

Khối lượng nguyên tử tập trung chủ yếu ở hạt nhân.''',
          },
          {
            'heading': '3. Các đại lượng đặc trưng',
            'text': '''• Số hiệu nguyên tử (Z): Số proton trong hạt nhân
• Số khối (A): Tổng số proton và neutron
• Công thức: A = Z + N (N là số neutron)

Ví dụ: Nguyên tử Carbon có Z = 6, N = 6
→ Số khối A = 6 + 6 = 12''',
          },
          {
            'heading': '4. Phân tử',
            'text': '''Phân tử là hạt đại diện cho chất, gồm một số nguyên tử liên kết với nhau.

Ví dụ:
• H₂O: 1 phân tử nước gồm 2 nguyên tử H và 1 nguyên tử O
• CO₂: 1 phân tử khí cacbonic gồm 1 nguyên tử C và 2 nguyên tử O''',
          },
        ],
      },
      {
        'level': 'Nâng cao',
        'icon': '🎓',
        'content': [
          {
            'heading': '1. Đồng vị',
            'text': '''Đồng vị là các nguyên tử có cùng số proton (Z) nhưng khác số neutron (N).

Ví dụ: Hydro có 3 đồng vị
• ¹H (Protium): Z = 1, N = 0, A = 1
• ²H (Deuterium): Z = 1, N = 1, A = 2
• ³H (Tritium): Z = 1, N = 2, A = 3''',
          },
          {
            'heading': '2. Ion',
            'text': '''Ion là nguyên tử hoặc nhóm nguyên tử mang điện.

• Ion dương (cation): Nguyên tử mất electron
  Ví dụ: Na → Na⁺ + 1e⁻

• Ion âm (anion): Nguyên tử nhận electron
  Ví dụ: Cl + 1e⁻ → Cl⁻''',
          },
          {
            'heading': '3. Khối lượng nguyên tử trung bình',
            'text': '''Khi nguyên tố có nhiều đồng vị:

Ā = (A₁ × x₁ + A₂ × x₂ + ...) / 100

Trong đó:
• Ā: Khối lượng nguyên tử trung bình
• A₁, A₂: Số khối các đồng vị
• x₁, x₂: % số nguyên tử mỗi đồng vị

Ví dụ: Chlorine có 2 đồng vị
• ³⁵Cl: 75%
• ³⁷Cl: 25%
→ Ā = (35 × 75 + 37 × 25) / 100 = 35.5''',
          },
        ],
      },
      {
        'level': 'Công thức tính',
        'icon': '🧮',
        'content': [
          {
            'heading': 'Các công thức quan trọng',
            'text': '''1. Số khối:
   A = Z + N

2. Số electron trong nguyên tử trung hòa:
   e = Z (số proton)

3. Số electron trong ion:
   • Ion dương: e = Z - n (n là điện tích)
   • Ion âm: e = Z + n

4. Khối lượng nguyên tử:
   m ≈ A × 1.66 × 10⁻²⁴ (gam)

5. Số Avogadro:
   NA = 6.02 × 10²³ (hạt/mol)''',
          },
        ],
      },
    ],
  };

  static final Map<String, dynamic> _chemicalBondContent = {
    'title': 'Liên kết hóa học',
    'sections': [
      {
        'level': 'Cơ bản',
        'icon': '📚',
        'content': [
          {
            'heading': '1. Liên kết ion',
            'text': '''Liên kết ion được hình thành do lực hút tĩnh điện giữa các ion trái dấu.

Đặc điểm:
• Xảy ra giữa kim loại và phi kim
• Kim loại nhường electron → ion dương
• Phi kim nhận electron → ion âm

Ví dụ: NaCl
Na → Na⁺ + 1e⁻
Cl + 1e⁻ → Cl⁻
Na⁺ + Cl⁻ → NaCl''',
          },
          {
            'heading': '2. Liên kết cộng hóa trị',
            'text': '''Liên kết cộng hóa trị được hình thành do sự dùng chung electron giữa các nguyên tử.

Phân loại:
• Liên kết đơn: Dùng chung 1 cặp electron (H-H)
• Liên kết đôi: Dùng chung 2 cặp electron (O=O)
• Liên kết ba: Dùng chung 3 cặp electron (N≡N)

Ví dụ: H₂O
Mỗi nguyên tử H dùng chung 1 electron với O
→ O có 2 liên kết đơn với 2 nguyên tử H''',
          },
          {
            'heading': '3. Liên kết cộng hóa trị phân cực',
            'text': '''Liên kết giữa 2 nguyên tử có độ âm điện khác nhau.

• Cặp electron lệch về nguyên tử có độ âm điện lớn hơn
• Phân tử có cực dương (+) và cực âm (-)

Ví dụ: HCl
Cl có độ âm điện lớn hơn H
→ Cặp electron lệch về Cl
→ H⁺δ - Cl⁻δ''',
          },
        ],
      },
      {
        'level': 'Nâng cao',
        'icon': '🎓',
        'content': [
          {
            'heading': '1. Độ âm điện',
            'text': '''Độ âm điện là khả năng hút electron của nguyên tử trong liên kết.

Quy luật:
• Trong chu kỳ: Tăng từ trái sang phải
• Trong nhóm: Giảm từ trên xuống dưới

Nguyên tố có độ âm điện lớn nhất: F (4.0)
Nguyên tố có độ âm điện nhỏ nhất: Cs (0.7)''',
          },
          {
            'heading': '2. Liên kết hydro',
            'text': '''Liên kết hydro là liên kết yếu giữa nguyên tử H (liên kết với F, O, N) và nguyên tử có độ âm điện lớn.

Ví dụ:
• H₂O: H-O···H-O
• NH₃: H-N···H-N
• HF: H-F···H-F

Ý nghĩa:
• Làm tăng nhiệt độ sôi, nóng chảy
• Quyết định tính chất của nước, protein, DNA''',
          },
          {
            'heading': '3. Hình dạng phân tử',
            'text': '''Dựa vào thuyết VSEPR:

• Thẳng: CO₂ (O=C=O)
• Góc: H₂O (104.5°)
• Tam giác phẳng: BF₃ (120°)
• Tứ diện: CH₄ (109.5°)
• Tháp tam giác: NH₃ (107°)''',
          },
        ],
      },
      {
        'level': 'Công thức tính',
        'icon': '🧮',
        'content': [
          {
            'heading': 'Các công thức quan trọng',
            'text': '''1. Năng lượng liên kết:
   ΔH = Σ(Năng lượng liên kết bị phá vỡ) - Σ(Năng lượng liên kết tạo thành)

2. Độ phân cực liên kết:
   Δχ = |χA - χB|
   • Δχ < 0.4: Liên kết cộng hóa trị không phân cực
   • 0.4 ≤ Δχ < 1.7: Liên kết cộng hóa trị phân cực
   • Δχ ≥ 1.7: Liên kết ion

3. Số liên kết trong phân tử:
   Số liên kết = (Tổng electron hóa trị - Số electron tự do) / 2''',
          },
        ],
      },
    ],
  };

  static final Map<String, dynamic> _chemicalReactionContent = {
    'title': 'Phản ứng hóa học',
    'sections': [
      {
        'level': 'Cơ bản',
        'icon': '📚',
        'content': [
          {
            'heading': '1. Phản ứng hóa học là gì?',
            'text': '''Phản ứng hóa học là quá trình biến đổi chất này thành chất khác.

Dấu hiệu nhận biết:
• Xuất hiện chất mới
• Thay đổi màu sắc
• Tỏa nhiệt hoặc thu nhiệt
• Có khí thoát ra
• Có kết tủa xuất hiện''',
          },
          {
            'heading': '2. Định luật bảo toàn khối lượng',
            'text': '''Trong phản ứng hóa học, tổng khối lượng các chất sản phẩm bằng tổng khối lượng các chất tham gia.

m(chất tham gia) = m(sản phẩm)

Ví dụ: 2H₂ + O₂ → 2H₂O
4g H₂ + 32g O₂ = 36g H₂O''',
          },
          {
            'heading': '3. Các loại phản ứng',
            'text': '''1. Phản ứng hóa hợp:
   A + B → AB
   Ví dụ: 2H₂ + O₂ → 2H₂O

2. Phản ứng phân hủy:
   AB → A + B
   Ví dụ: 2H₂O → 2H₂ + O₂

3. Phản ứng thế:
   A + BC → AC + B
   Ví dụ: Zn + 2HCl → ZnCl₂ + H₂

4. Phản ứng trao đổi:
   AB + CD → AD + CB
   Ví dụ: NaCl + AgNO₃ → AgCl + NaNO₃''',
          },
        ],
      },
      {
        'level': 'Nâng cao',
        'icon': '🎓',
        'content': [
          {
            'heading': '1. Phản ứng oxi hóa - khử',
            'text': '''Phản ứng có sự thay đổi số oxi hóa của các nguyên tố.

• Chất khử: Nhường electron, số oxi hóa tăng
• Chất oxi hóa: Nhận electron, số oxi hóa giảm

Ví dụ: Zn + CuSO₄ → ZnSO₄ + Cu
• Zn: 0 → +2 (bị oxi hóa, là chất khử)
• Cu: +2 → 0 (bị khử, là chất oxi hóa)''',
          },
          {
            'heading': '2. Cân bằng phương trình',
            'text': '''Nguyên tắc:
• Số nguyên tử mỗi nguyên tố ở 2 vế bằng nhau
• Tổng điện tích 2 vế bằng nhau (nếu có ion)

Phương pháp:
1. Phương pháp hệ số
2. Phương pháp electron (phản ứng oxi hóa - khử)

Ví dụ: Fe + O₂ → Fe₃O₄
Cân bằng: 3Fe + 2O₂ → Fe₃O₄''',
          },
          {
            'heading': '3. Tốc độ phản ứng',
            'text': '''Các yếu tố ảnh hưởng:

1. Nồng độ: Tăng nồng độ → tăng tốc độ
2. Nhiệt độ: Tăng nhiệt độ → tăng tốc độ
3. Áp suất: (với khí) Tăng áp suất → tăng tốc độ
4. Diện tích tiếp xúc: Tăng diện tích → tăng tốc độ
5. Chất xúc tác: Làm tăng tốc độ phản ứng''',
          },
        ],
      },
      {
        'level': 'Công thức tính',
        'icon': '🧮',
        'content': [
          {
            'heading': 'Các công thức quan trọng',
            'text': '''1. Hiệu suất phản ứng:
   H% = (m thực tế / m lý thuyết) × 100%

2. Độ chuyển hóa:
   α = (n phản ứng / n ban đầu) × 100%

3. Nhiệt phản ứng:
   ΔH = H(sản phẩm) - H(chất tham gia)
   • ΔH < 0: Phản ứng tỏa nhiệt
   • ΔH > 0: Phản ứng thu nhiệt

4. Tốc độ phản ứng:
   v = Δn / (V × Δt)
   Trong đó:
   • Δn: Độ biến thiên số mol
   • V: Thể tích
   • Δt: Thời gian''',
          },
        ],
      },
    ],
  };

  static final Map<String, dynamic> _molCalculationContent = {
    'title': 'Mol & Tính toán hóa học',
    'sections': [
      {
        'level': 'Cơ bản',
        'icon': '📚',
        'content': [
          {
            'heading': '1. Mol là gì?',
            'text': '''Mol là đơn vị đo lượng chất.

1 mol chất chứa NA = 6.02 × 10²³ hạt (nguyên tử, phân tử, ion)

Ví dụ:
• 1 mol H₂O = 6.02 × 10²³ phân tử H₂O
• 1 mol Fe = 6.02 × 10²³ nguyên tử Fe''',
          },
          {
            'heading': '2. Khối lượng mol (M)',
            'text': '''Khối lượng mol là khối lượng của 1 mol chất, đơn vị: g/mol

Công thức: n = m / M

Trong đó:
• n: Số mol (mol)
• m: Khối lượng (g)
• M: Khối lượng mol (g/mol)

Ví dụ: Tính số mol của 18g H₂O
M(H₂O) = 2 × 1 + 16 = 18 g/mol
n = 18 / 18 = 1 mol''',
          },
          {
            'heading': '3. Thể tích mol khí (đktc)',
            'text': '''Ở điều kiện tiêu chuẩn (đktc: 0°C, 1 atm):
1 mol khí bất kỳ có thể tích 22.4 lít

Công thức: n = V / 22.4

Trong đó:
• n: Số mol (mol)
• V: Thể tích (lít)

Ví dụ: Tính số mol của 11.2 lít O₂ (đktc)
n = 11.2 / 22.4 = 0.5 mol''',
          },
        ],
      },
      {
        'level': 'Nâng cao',
        'icon': '🎓',
        'content': [
          {
            'heading': '1. Nồng độ mol (CM)',
            'text': '''Nồng độ mol là số mol chất tan trong 1 lít dung dịch.

Công thức: CM = n / V

Trong đó:
• CM: Nồng độ mol (mol/l hoặc M)
• n: Số mol chất tan (mol)
• V: Thể tích dung dịch (lít)

Ví dụ: Hòa tan 0.5 mol NaCl vào nước được 2 lít dung dịch
CM = 0.5 / 2 = 0.25 M''',
          },
          {
            'heading': '2. Nồng độ phần trăm (C%)',
            'text': '''Nồng độ phần trăm là số gam chất tan trong 100g dung dịch.

Công thức: C% = (m chất tan / m dung dịch) × 100%

Ví dụ: Hòa tan 10g muối vào 90g nước
C% = (10 / 100) × 100% = 10%

Chuyển đổi giữa CM và C%:
CM = (10 × C% × D) / M
Trong đó D là khối lượng riêng (g/ml)''',
          },
          {
            'heading': '3. Tỉ khối khí',
            'text': '''Tỉ khối của khí A so với khí B:

dA/B = MA / MB

Tỉ khối so với không khí:
dA/kk = MA / 29

Tỉ khối so với H₂:
dA/H₂ = MA / 2

Ví dụ: Tính tỉ khối của CO₂ so với không khí
M(CO₂) = 44 g/mol
d = 44 / 29 ≈ 1.52''',
          },
        ],
      },
      {
        'level': 'Công thức tính',
        'icon': '🧮',
        'content': [
          {
            'heading': 'Tổng hợp công thức',
            'text': '''1. Số mol:
   n = m/M = V/22.4 = N/NA = CM × V(dd)

2. Khối lượng:
   m = n × M

3. Thể tích khí (đktc):
   V = n × 22.4

4. Số hạt:
   N = n × NA = n × 6.02 × 10²³

5. Nồng độ mol:
   CM = n/V(dd) = (m × 1000)/(M × V(dd))

6. Nồng độ %:
   C% = (m chất tan / m dung dịch) × 100%

7. Khối lượng mol trung bình:
   M̄ = (n₁M₁ + n₂M₂ + ...) / (n₁ + n₂ + ...)

8. Phần trăm khối lượng:
   %m = (m chất / m hỗn hợp) × 100%

9. Phần trăm thể tích (khí):
   %V = (V khí / V hỗn hợp) × 100%''',
          },
        ],
      },
    ],
  };

  static final Map<String, dynamic> _defaultContent = {
    'title': 'Nội dung bài học',
    'sections': [
      {
        'level': 'Cơ bản',
        'icon': '📚',
        'content': [
          {
            'heading': 'Nội dung đang được cập nhật',
            'text': 'Nội dung chi tiết sẽ được bổ sung trong thời gian tới.',
          },
        ],
      },
    ],
  };

  // Hiđrocacbon
  static final Map<String, dynamic> _hydrocarbonContent = {
    'title': 'Hiđrocacbon',
    'sections': [
      {
        'level': 'Cơ bản',
        'icon': '📚',
        'content': [
          {
            'heading': '1. Hiđrocacbon là gì?',
            'text': '''Hiđrocacbon là hợp chất hữu cơ chỉ chứa 2 nguyên tố: Carbon (C) và Hydro (H).

Phân loại:
• Hiđrocacbon no (Ankan): Chỉ có liên kết đơn
• Hiđrocacbon không no (Anken, Ankin): Có liên kết đôi hoặc ba
• Hiđrocacbon thơm (Benzen): Có vòng benzen''',
          },
          {
            'heading': '2. Ankan (CnH2n+2)',
            'text': '''Ankan là hiđrocacbon no, mạch hở.

Công thức chung: CnH2n+2 (n ≥ 1)

Ví dụ:
• Metan: CH₄
• Etan: C₂H₆
• Propan: C₃H₈
• Butan: C₄H₁₀

Tính chất:
• Không tác dụng với dung dịch KMnO₄
• Phản ứng thế với Cl₂, Br₂ (có ánh sáng)
• Phản ứng cháy tỏa nhiệt''',
          },
          {
            'heading': '3. Anken (CnH2n)',
            'text': '''Anken là hiđrocacbon không no, có 1 liên kết đôi C=C.

Công thức chung: CnH2n (n ≥ 2)

Ví dụ:
• Etilen (Eten): C₂H₄
• Propilen: C₃H₆

Tính chất:
• Làm mất màu dung dịch KMnO₄
• Phản ứng cộng với H₂, Br₂, HCl
• Phản ứng trùng hợp tạo polime''',
          },
        ],
      },
      {
        'level': 'Nâng cao',
        'icon': '🎓',
        'content': [
          {
            'heading': '1. Ankin (CnH2n-2)',
            'text': '''Ankin là hiđrocacbon không no, có 1 liên kết ba C≡C.

Công thức chung: CnH2n-2 (n ≥ 2)

Ví dụ:
• Axetilen (Etin): C₂H₂
• Propin: C₃H₄

Tính chất đặc trưng:
• Phản ứng với dung dịch AgNO₃/NH₃ tạo kết tủa
• Phản ứng cộng 2 lần với H₂, Br₂''',
          },
          {
            'heading': '2. Benzen và đồng đẳng',
            'text': '''Benzen (C₆H₆) là hiđrocacbon thơm đơn giản nhất.

Cấu trúc: Vòng 6 cạnh đều, có liên kết π liên hợp

Tính chất:
• Phản ứng thế (với Br₂/Fe, HNO₃/H₂SO₄)
• Phản ứng cộng khó hơn anken
• Cháy với ngọn lửa đen khói''',
          },
        ],
      },
      {
        'level': 'Công thức tính',
        'icon': '🧮',
        'content': [
          {
            'heading': 'Các công thức quan trọng',
            'text': '''1. Công thức tổng quát:
   • Ankan: CnH2n+2
   • Anken: CnH2n
   • Ankin: CnH2n-2
   • Benzen: CnH2n-6

2. Phản ứng cháy:
   CxHy + O₂ → xCO₂ + (y/2)H₂O

3. Số mol O₂ cần dùng:
   nO₂ = x + y/4 (mol)

4. Độ không no (k):
   k = (2n + 2 - m) / 2
   Trong đó: n là số C, m là số H''',
          },
        ],
      },
    ],
  };

  // Ancol & Phenol
  static final Map<String, dynamic> _alcoholPhenolContent = {
    'title': 'Ancol & Phenol',
    'sections': [
      {
        'level': 'Cơ bản',
        'icon': '📚',
        'content': [
          {
            'heading': '1. Ancol là gì?',
            'text': '''Ancol là hợp chất hữu cơ có nhóm -OH liên kết với gốc hiđrocacbon no.

Công thức chung: R-OH

Phân loại:
• Ancol đơn chức: 1 nhóm -OH (CH₃OH, C₂H₅OH)
• Ancol đa chức: Nhiều nhóm -OH (C₂H₄(OH)₂, C₃H₅(OH)₃)''',
          },
          {
            'heading': '2. Ancol etylic (C₂H₅OH)',
            'text': '''Ancol etylic (Etanol) là ancol quan trọng nhất.

Tính chất vật lý:
• Chất lỏng không màu
• Tan vô hạn trong nước
• Nhiệt độ sôi: 78°C

Tính chất hóa học:
• Phản ứng với Na: 2C₂H₅OH + 2Na → 2C₂H₅ONa + H₂
• Phản ứng với HBr: C₂H₅OH + HBr → C₂H₅Br + H₂O
• Oxi hóa thành anđehit: C₂H₅OH + CuO → CH₃CHO + Cu + H₂O''',
          },
          {
            'heading': '3. Phenol (C₆H₅OH)',
            'text': '''Phenol là hợp chất có nhóm -OH liên kết trực tiếp với vòng benzen.

Tính chất:
• Axit yếu hơn axit cacboxylic
• Phản ứng với NaOH: C₆H₅OH + NaOH → C₆H₅ONa + H₂O
• Phản ứng với Br₂: C₆H₅OH + 3Br₂ → C₆H₂Br₃OH + 3HBr''',
          },
        ],
      },
      {
        'level': 'Nâng cao',
        'icon': '🎓',
        'content': [
          {
            'heading': '1. Ancol đa chức',
            'text': '''Etylen glycol (C₂H₄(OH)₂):
• Chất lỏng sánh, ngọt
• Dùng làm chất chống đông
• Phản ứng với Cu(OH)₂ tạo phức màu xanh lam

Glixerol (C₃H₅(OH)₃):
• Chất lỏng sánh, ngọt
• Tan vô hạn trong nước
• Tạo este với axit béo → chất béo''',
          },
          {
            'heading': '2. Phản ứng este hóa',
            'text': '''Ancol + Axit → Este + Nước

Ví dụ:
C₂H₅OH + CH₃COOH ⇌ CH₃COOC₂H₅ + H₂O

Điều kiện: H₂SO₄ đặc, đun nóng
Đặc điểm: Phản ứng thuận nghịch''',
          },
        ],
      },
      {
        'level': 'Công thức tính',
        'icon': '🧮',
        'content': [
          {
            'heading': 'Các công thức quan trọng',
            'text': '''1. Phản ứng với Na:
   2ROH + 2Na → 2RONa + H₂↑
   nH₂ = nOH / 2

2. Phản ứng este hóa:
   Hiệu suất: H% = (neste thực tế / neste lý thuyết) × 100%

3. Oxi hóa ancol:
   • Ancol bậc 1 → Anđehit
   • Ancol bậc 2 → Xeton
   • Ancol bậc 3 → Không bị oxi hóa''',
          },
        ],
      },
    ],
  };

  // Anđehit & Xeton
  static final Map<String, dynamic> _aldehydeKetoneContent = {
    'title': 'Anđehit & Xeton',
    'sections': [
      {
        'level': 'Cơ bản',
        'icon': '📚',
        'content': [
          {
            'heading': '1. Anđehit',
            'text': '''Anđehit là hợp chất hữu cơ có nhóm chức -CHO.

Công thức chung: R-CHO

Ví dụ:
• Fomanđehit: HCHO
• Axetanđehit: CH₃CHO

Tính chất đặc trưng:
• Có tính khử mạnh
• Phản ứng tráng bạc
• Phản ứng với Cu(OH)₂''',
          },
          {
            'heading': '2. Phản ứng tráng bạc',
            'text': '''Anđehit + AgNO₃/NH₃ → Ag↓ (kết tủa bạc)

Phương trình:
RCHO + 2AgNO₃ + 3NH₃ + H₂O → RCOONH₄ + 2Ag↓ + 2NH₄NO₃

Hiện tượng: Xuất hiện lớp bạc sáng bám vào thành ống nghiệm''',
          },
          {
            'heading': '3. Xeton',
            'text': '''Xeton là hợp chất hữu cơ có nhóm chức >C=O giữa 2 gốc hiđrocacbon.

Công thức chung: R-CO-R'

Ví dụ: Axeton (CH₃COCH₃)

Tính chất:
• Không có tính khử
• Không tráng bạc
• Không phản ứng với Cu(OH)₂''',
          },
        ],
      },
      {
        'level': 'Nâng cao',
        'icon': '🎓',
        'content': [
          {
            'heading': '1. Phản ứng cộng H₂',
            'text': '''Anđehit + H₂ → Ancol bậc 1
RCHO + H₂ → RCH₂OH

Xeton + H₂ → Ancol bậc 2
RCOR' + H₂ → RCH(OH)R'

Điều kiện: Ni, t°''',
          },
          {
            'heading': '2. Phản ứng với Cu(OH)₂',
            'text': '''Anđehit + Cu(OH)₂ → Kết tủa đỏ gạch Cu₂O

2RCHO + Cu(OH)₂ → 2RCOOH + Cu₂O↓ + H₂O

Điều kiện: Đun nóng
Hiện tượng: Xuất hiện kết tủa đỏ gạch''',
          },
        ],
      },
      {
        'level': 'Công thức tính',
        'icon': '🧮',
        'content': [
          {
            'heading': 'Các công thức quan trọng',
            'text': '''1. Phản ứng tráng bạc:
   RCHO + 2AgNO₃/NH₃ → 2Ag↓
   nAg = 2 × nRCHO

2. Phản ứng với Cu(OH)₂:
   2RCHO + Cu(OH)₂ → Cu₂O↓
   nCu₂O = nRCHO / 2

3. Fomanđehit đặc biệt:
   HCHO + 4AgNO₃/NH₃ → 4Ag↓
   nAg = 4 × nHCHO''',
          },
        ],
      },
    ],
  };

  // Axit cacboxylic
  static final Map<String, dynamic> _carboxylicAcidContent = {
    'title': 'Axit cacboxylic',
    'sections': [
      {
        'level': 'Cơ bản',
        'icon': '📚',
        'content': [
          {
            'heading': '1. Axit cacboxylic là gì?',
            'text': '''Axit cacboxylic là hợp chất hữu cơ có nhóm chức -COOH.

Công thức chung: R-COOH

Ví dụ:
• Axit fomic: HCOOH
• Axit axetic: CH₃COOH
• Axit benzoic: C₆H₅COOH''',
          },
          {
            'heading': '2. Tính chất axit',
            'text': '''Axit cacboxylic có tính axit yếu.

Phản ứng với kim loại:
2CH₃COOH + Mg → (CH₃COO)₂Mg + H₂↑

Phản ứng với bazơ:
CH₃COOH + NaOH → CH₃COONa + H₂O

Phản ứng với muối:
CH₃COOH + NaHCO₃ → CH₃COONa + CO₂↑ + H₂O''',
          },
          {
            'heading': '3. Phản ứng este hóa',
            'text': '''Axit + Ancol ⇌ Este + Nước

CH₃COOH + C₂H₅OH ⇌ CH₃COOC₂H₅ + H₂O

Điều kiện: H₂SO₄ đặc, đun nóng
Xúc tác: H₂SO₄ đặc''',
          },
        ],
      },
      {
        'level': 'Nâng cao',
        'icon': '🎓',
        'content': [
          {
            'heading': '1. Axit đa chức',
            'text': '''Axit oxalic (HOOC-COOH):
• Axit 2 chức
• Có trong me chua
• Độc, không dùng trong thực phẩm

Axit adipic (HOOC-(CH₂)₄-COOH):
• Dùng sản xuất tơ nilon-6,6''',
          },
          {
            'heading': '2. Muối của axit',
            'text': '''Muối natri của axit béo (xà phòng):
• C₁₇H₃₅COONa (Natri stearat)
• Có tính tẩy rửa
• Bị phân hủy trong nước cứng

Phản ứng tạo xà phòng:
Chất béo + NaOH → Glixerol + Xà phòng''',
          },
        ],
      },
      {
        'level': 'Công thức tính',
        'icon': '🧮',
        'content': [
          {
            'heading': 'Các công thức quan trọng',
            'text': '''1. Phản ứng với kim loại:
   2RCOOH + M → (RCOO)₂M + H₂↑
   nH₂ = nCOOH / 2

2. Phản ứng với NaOH:
   RCOOH + NaOH → RCOONa + H₂O
   nNaOH = nCOOH

3. Phản ứng với NaHCO₃:
   RCOOH + NaHCO₃ → RCOONa + CO₂↑ + H₂O
   nCO₂ = nCOOH

4. Phản ứng este hóa:
   H% = (neste thực tế / neste lý thuyết) × 100%''',
          },
        ],
      },
    ],
  };

  // Este & Lipit
  static final Map<String, dynamic> _esterLipidContent = {
    'title': 'Este & Lipit',
    'sections': [
      {
        'level': 'Cơ bản',
        'icon': '📚',
        'content': [
          {
            'heading': '1. Este là gì?',
            'text': '''Este là hợp chất có nhóm chức -COO-.

Công thức chung: R-COO-R'

Ví dụ:
• Etyl axetat: CH₃COOC₂H₅ (mùi chuối chín)
• Isoamyl axetat: CH₃COOC₅H₁₁ (mùi chuối)

Tính chất:
• Không tan trong nước
• Có mùi thơm đặc trưng
• Nhẹ hơn nước''',
          },
          {
            'heading': '2. Phản ứng thủy phân este',
            'text': '''Este + Nước ⇌ Axit + Ancol

Trong môi trường axit:
CH₃COOC₂H₅ + H₂O ⇌ CH₃COOH + C₂H₅OH

Trong môi trường kiềm (xà phòng hóa):
CH₃COOC₂H₅ + NaOH → CH₃COONa + C₂H₅OH''',
          },
          {
            'heading': '3. Chất béo (Lipit)',
            'text': '''Chất béo là este của glixerol với axit béo.

Công thức chung:
(RCOO)₃C₃H₅

Phân loại:
• Chất béo no: Rắn ở nhiệt độ thường
• Chất béo không no: Lỏng ở nhiệt độ thường (dầu)''',
          },
        ],
      },
      {
        'level': 'Nâng cao',
        'icon': '🎓',
        'content': [
          {
            'heading': '1. Phản ứng xà phòng hóa',
            'text': '''Chất béo + NaOH → Glixerol + Xà phòng

(RCOO)₃C₃H₅ + 3NaOH → 3RCOONa + C₃H₅(OH)₃

Điều kiện: Đun nóng
Sản phẩm: Xà phòng (muối natri của axit béo)''',
          },
          {
            'heading': '2. Phản ứng cộng H₂',
            'text': '''Dầu (chất béo lỏng) + H₂ → Mỡ (chất béo rắn)

Điều kiện: Ni, t°, p
Ứng dụng: Sản xuất bơ thực vật, margarin''',
          },
        ],
      },
      {
        'level': 'Công thức tính',
        'icon': '🧮',
        'content': [
          {
            'heading': 'Các công thức quan trọng',
            'text': '''1. Phản ứng xà phòng hóa:
   nNaOH = 3 × nchất béo

2. Chỉ số xà phòng hóa:
   Số mg KOH để xà phòng hóa 1g chất béo

3. Chỉ số axit:
   Số mg KOH để trung hòa axit tự do trong 1g chất béo

4. Khối lượng mol trung bình:
   M̄ = mchất béo / nchất béo''',
          },
        ],
      },
    ],
  };

  // Cacbohiđrat
  static final Map<String, dynamic> _carbohydrateContent = {
    'title': 'Cacbohiđrat',
    'sections': [
      {
        'level': 'Cơ bản',
        'icon': '📚',
        'content': [
          {
            'heading': '1. Cacbohiđrat là gì?',
            'text': '''Cacbohiđrat (Gluxit) là hợp chất hữu cơ có công thức chung Cn(H₂O)m.

Phân loại:
• Monosaccarit: Glucozơ, Fructozơ
• Đisaccarit: Saccarozơ, Mantozơ
• Polisaccarit: Tinh bột, Xenlulozơ''',
          },
          {
            'heading': '2. Glucozơ (C₆H₁₂O₆)',
            'text': '''Glucozơ là monosaccarit quan trọng nhất.

Tính chất:
• Chất rắn kết tinh, vị ngọt
• Tan tốt trong nước
• Có tính khử (phản ứng tráng bạc)

Phản ứng tráng bạc:
C₆H₁₂O₆ + 2AgNO₃/NH₃ → C₆H₁₂O₇ + 2Ag↓''',
          },
          {
            'heading': '3. Saccarozơ (C₁₂H₂₂O₁₁)',
            'text': '''Saccarozơ (đường mía, đường kính) là đisaccarit.

Tính chất:
• Chất rắn kết tinh, vị ngọt
• Tan tốt trong nước
• Không có tính khử

Phản ứng thủy phân:
C₁₂H₂₂O₁₁ + H₂O → C₆H₁₂O₆ (glucozơ) + C₆H₁₂O₆ (fructozơ)''',
          },
        ],
      },
      {
        'level': 'Nâng cao',
        'icon': '🎓',
        'content': [
          {
            'heading': '1. Tinh bột (C₆H₁₀O₅)n',
            'text': '''Tinh bột là polisaccarit quan trọng.

Tính chất:
• Chất rắn vô định hình, màu trắng
• Không tan trong nước lạnh
• Phản ứng với I₂ cho màu xanh tím

Phản ứng thủy phân:
(C₆H₁₀O₅)n + nH₂O → nC₆H₁₂O₆''',
          },
          {
            'heading': '2. Xenlulozơ (C₆H₁₀O₅)n',
            'text': '''Xenlulozơ là thành phần chính của thành tế bào thực vật.

Tính chất:
• Chất rắn dạng sợi, màu trắng
• Không tan trong nước
• Không phản ứng với I₂

Ứng dụng:
• Sản xuất giấy
• Sản xuất tơ nhân tạo
• Sản xuất thuốc súng không khói''',
          },
        ],
      },
      {
        'level': 'Công thức tính',
        'icon': '🧮',
        'content': [
          {
            'heading': 'Các công thức quan trọng',
            'text': '''1. Phản ứng tráng bạc (glucozơ):
   C₆H₁₂O₆ + 2AgNO₃/NH₃ → 2Ag↓
   nAg = 2 × nglucozơ

2. Phản ứng thủy phân saccarozơ:
   C₁₂H₂₂O₁₁ + H₂O → 2C₆H₁₂O₆
   nsaccarozơ = nglucozơ / 2

3. Phản ứng thủy phân tinh bột:
   (C₆H₁₀O₅)n + nH₂O → nC₆H₁₂O₆
   nglucozơ = n × ntinh bột

4. Phản ứng lên men:
   C₆H₁₂O₆ → 2C₂H₅OH + 2CO₂↑
   nancol = 2 × nglucozơ''',
          },
        ],
      },
    ],
  };

}
