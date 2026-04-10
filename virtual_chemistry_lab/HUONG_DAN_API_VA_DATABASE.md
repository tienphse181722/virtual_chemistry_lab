# 📚 HƯỚNG DẪN ĐẦY ĐỦ - API VÀ DATABASE CHEMLEARN

## 📊 SƠ ĐỒ KIẾN TRÚC TỔNG QUAN

```
╔═══════════════════════════════════════════════════════════════════════════════╗
║                           🧪 CHEMLEARN APP                                    ║
╠═══════════════════════════════════════════════════════════════════════════════╣
║                                                                               ║
║  ┌─────────────────────────────────┐    ┌─────────────────────────────────┐ ║
║  │     💾 HARDCODE DATA            │    │     🔥 FIREBASE FIRESTORE       │ ║
║  │     (Dữ liệu tĩnh trong code)   │    │     (Dữ liệu động trên cloud)   │ ║
║  ├─────────────────────────────────┤    ├─────────────────────────────────┤ ║
║  │                                 │    │                                 │ ║
║  │ 📂 lib/data/                    │    │ 📊 COLLECTIONS:                 │ ║
║  │                                 │    │                                 │ ║
║  │ ✅ game_data.dart               │    │ ✅ chemicals (118 docs)         │ ║
║  │    • 5 games x 10 levels        │    │    └─ Bảng tuần hoàn            │ ║
║  │    • Quiz nhanh, Ghi nhớ        │    │                                 │ ║
║  │    • Xây dựng phân tử, Ghép từ  │    │ ✅ users                        │ ║
║  │    • Tổng hợp                   │    │    ├─ best_scores (subcol)     │ ║
║  │                                 │    │    ├─ lab_stats (subcol)       │ ║
║  │ ✅ exam_data.dart               │    │    ├─ lesson_progress (subcol) │ ║
║  │    • 5 đề thi (210 câu)         │    │    ├─ course_progress (subcol) │ ║
║  │    • Đề 1, 2, 3                 │    │    └─ best_exam_scores (subcol)│ ║
║  │    • Chuyên đề nâng cao         │    │                                 │ ║
║  │    • Tổng ôn tập                │    │ ⚪ experiments                  │ ║
║  │                                 │    │    └─ Thí nghiệm của users     │ ║
║  │ ✅ quiz_data.dart               │    │                                 │ ║
║  │    • 4 bộ quiz (200 câu)        │    │ ⚪ quiz_results                 │ ║
║  │    • Nguyên tử & Phân tử        │    │    └─ Kết quả quiz             │ ║
║  │    • Liên kết hóa học           │    │                                 │ ║
║  │    • Phản ứng hóa học           │    │ ⚪ game_results                 │ ║
║  │    • Mol & Tính toán            │    │    └─ Kết quả game             │ ║
║  │                                 │    │                                 │ ║
║  │ ✅ lesson_content.dart          │    │ ⚪ lab_experiments              │ ║
║  │    • 10 bài học lý thuyết       │    │    └─ Thí nghiệm lab           │ ║
║  │    • Nội dung đầy đủ            │    │                                 │ ║
║  │    • Hình ảnh, ví dụ            │    │ ⚪ exam_results                 │ ║
║  │                                 │    │    └─ Kết quả thi              │ ║
║  │ 🎯 LOAD: Ngay lập tức           │    │                                 │ ║
║  │ 🎯 KHÔNG CẦN: Internet          │    │ ⚪ user_activities              │ ║
║  │ 🎯 KHÔNG THAY ĐỔI               │    │    └─ Lịch sử hoạt động        │ ║
║  │                                 │    │                                 │ ║
║  └─────────────────────────────────┘    │ 🎯 LOAD: Qua internet          │ ║
║                                         │ 🎯 CẬP NHẬT: Real-time         │ ║
║                                         │ 🎯 BẢO MẬT: Firebase Rules     │ ║
║                                         │                                 │ ║
║                                         └─────────────────────────────────┘ ║
║                                                                               ║
║  ┌───────────────────────────────────────────────────────────────────────┐   ║
║  │                        🔧 API SERVICES                                │   ║
║  ├───────────────────────────────────────────────────────────────────────┤   ║
║  │                                                                       │   ║
║  │  📁 lib/services/firestore_service.dart                              │   ║
║  │     └─ Quản lý: chemicals, users, experiments, quiz_results          │   ║
║  │                                                                       │   ║
║  │  📁 lib/services/user_data_service.dart                              │   ║
║  │     └─ Quản lý: game_results, lab_experiments, exam_results          │   ║
║  │                                                                       │   ║
║  │  📁 lib/services/progress_service.dart                               │   ║
║  │     └─ Quản lý: Tiến độ, điểm, streak, achievements                 │   ║
║  │                                                                       │   ║
║  │  📁 lib/services/leaderboard_service.dart                            │   ║
║  │     └─ Quản lý: Bảng xếp hạng, thứ hạng user                         │   ║
║  │                                                                       │   ║
║  └───────────────────────────────────────────────────────────────────────┘   ║
║                                                                               ║
║  CHÚ THÍCH:                                                                   ║
║  ✅ = Có sẵn / Cần có trước khi chạy app                                     ║
║  ⚪ = Tự động tạo khi user sử dụng (KHÔNG CẦN TẠO TRƯỚC)                     ║
║                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════╝
```

---

## 📊 PHẦN 1: DỮ LIỆU TRÊN FIREBASE

### 1.1. Collection: `chemicals` (118 nguyên tố)

**📍 Vị trí:** Firebase Firestore
**📁 File nguồn:** `assets/periodic_table.json`
**🔧 API Service:** `lib/services/firestore_service.dart`

**Chức năng:**
```dart
// Lấy tất cả nguyên tố
Future<List<ChemicalModel>> getChemicals()

// Lấy 1 nguyên tố theo ID
Future<ChemicalModel?> getChemical(String id)

// Lấy danh sách nguyên tố (cho bảng tuần hoàn)
Future<List<ElementModel>> getElements()
```

**Cấu trúc dữ liệu:**
```json
{
  "id": "element_1",
  "atomicNumber": 1,
  "symbol": "H",
  "name": "Hydro",
  "atomicMass": "1.008",
  "oxidationStates": "-1, +1",
  "category": "Phi kim",
  "type": "element",
  "formula": "H",
  "description": "Nguyên tố Hydro (H) - Số hiệu nguyên tử: 1",
  "imageUrl": "",
  "hazardLevel": "low",
  "state": "solid",
  "color": "gray"
}
```

**Sử dụng trong:**
- `lib/screens/course/periodic_table_screen.dart` - Hiển thị bảng tuần hoàn
- `lib/screens/lab/mix_chemicals_screen.dart` - Trộn hóa chất
- `lib/providers/lab_provider.dart` - Quản lý dữ liệu lab

---

### 1.2. Collection: `users`

**📍 Vị trí:** Firebase Firestore
**🔧 API Service:** `lib/services/firestore_service.dart`

**Chức năng:**
```dart
// Tạo user mới
Future<void> createUser(UserModel user)

// Lấy thông tin user
Future<UserModel?> getUser(String uid)

// Cập nhật thông tin user
Future<void> updateUser(String uid, Map<String, dynamic> data)
```

**Cấu trúc dữ liệu:**
```json
{
  "uid": "user_id_123",
  "email": "user@example.com",
  "displayName": "Nguyễn Văn A",
  "photoUrl": "https://...",
  "createdAt": "2024-01-01T00:00:00.000Z",
  "lastLogin": "2024-01-01T00:00:00.000Z",
  "totalPoints": 0,
  "completedLessons": 0,
  "totalLessons": 50,
  "currentStreak": 0,
  "achievements": {},
  "courseProgress": {},
  "labProgress": {},
  "gameProgress": {}
}
```

**Sử dụng trong:**
- `lib/providers/auth_provider.dart` - Xác thực và quản lý user
- `lib/screens/profile/profile_screen.dart` - Hiển thị thông tin cá nhân

---

### 1.3. Collection: `experiments` (Thí nghiệm của user)

**📍 Vị trí:** Firebase Firestore (Tự động tạo khi user làm thí nghiệm)
**🔧 API Service:** `lib/services/firestore_service.dart`

**Chức năng:**
```dart
// Lưu thí nghiệm
Future<void> saveExperiment(ExperimentModel experiment)

// Lấy thí nghiệm của user
Future<List<ExperimentModel>> getUserExperiments(String userId)
```

**Cấu trúc dữ liệu:**
```json
{
  "id": "exp_123",
  "userId": "user_id_123",
  "experimentType": "mix",
  "chemicals": ["HCl", "NaOH"],
  "result": "NaCl + H2O",
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

**Sử dụng trong:**
- `lib/screens/lab/mix_chemicals_screen.dart` - Trộn hóa chất
- `lib/screens/lab/burn_chemical_screen.dart` - Đốt hóa chất

---

### 1.4. Collection: `quiz_results` (Kết quả quiz)

**📍 Vị trí:** Firebase Firestore (Tự động tạo khi user làm quiz)
**🔧 API Service:** `lib/services/firestore_service.dart`

**Chức năng:**
```dart
// Lưu kết quả quiz
Future<void> saveQuizResult(String userId, String quizId, int score)

// Lấy kết quả quiz của user
Future<List<Map<String, dynamic>>> getUserQuizResults(String userId)
```

**Cấu trúc dữ liệu:**
```json
{
  "userId": "user_id_123",
  "quizId": "atom_molecule",
  "score": 85,
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

**Sử dụng trong:**
- `lib/screens/quiz/quiz_screen.dart` - Làm quiz
- `lib/providers/quiz_provider.dart` - Quản lý quiz

---

### 1.5. Collection: `game_results` (Kết quả game)

**📍 Vị trí:** Firebase Firestore (Tự động tạo khi user chơi game)
**🔧 API Service:** `lib/services/user_data_service.dart`

**Chức năng:**
```dart
// Lưu kết quả game
Future<void> saveGameResult({
  required String userId,
  required String gameType,
  required int level,
  required int score,
  required int timeSpent,
  required bool completed,
})

// Lấy lịch sử game
Future<List<Map<String, dynamic>>> getGameHistory(String userId, {String? gameType})

// Lấy điểm cao nhất
Future<Map<String, int>> getBestScores(String userId)
```

**Cấu trúc dữ liệu:**
```json
{
  "userId": "user_id_123",
  "gameType": "quiz_nhanh",
  "level": 1,
  "score": 100,
  "timeSpent": 120,
  "completed": true,
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

**Sử dụng trong:**
- `lib/screens/game/quiz_nhanh_screen.dart` - Game quiz nhanh
- `lib/screens/game/ghi_nho_screen.dart` - Game ghi nhớ
- `lib/screens/game/xay_dung_phan_tu_screen.dart` - Game xây dựng phân tử
- `lib/screens/game/ghep_tu_screen.dart` - Game ghép từ
- `lib/screens/game/tong_hop_screen.dart` - Game tổng hợp

---

### 1.6. Collection: `lab_experiments` (Thí nghiệm lab chi tiết)

**📍 Vị trí:** Firebase Firestore (Tự động tạo khi user làm lab)
**🔧 API Service:** `lib/services/user_data_service.dart`

**Chức năng:**
```dart
// Lưu thí nghiệm lab
Future<void> saveLabExperiment({
  required String userId,
  required String labType,
  required String experimentName,
  required Map<String, dynamic> inputs,
  required Map<String, dynamic> results,
  required bool successful,
})

// Lấy lịch sử lab
Future<List<Map<String, dynamic>>> getLabHistory(String userId, {String? labType})

// Lấy thống kê lab
Future<Map<String, Map<String, dynamic>>> getLabStats(String userId)
```

**Cấu trúc dữ liệu:**
```json
{
  "userId": "user_id_123",
  "labType": "mix_chemicals",
  "experimentName": "Trộn HCl và NaOH",
  "inputs": {
    "chemical1": "HCl",
    "chemical2": "NaOH",
    "volume1": 10,
    "volume2": 10
  },
  "results": {
    "product": "NaCl + H2O",
    "observation": "Tỏa nhiệt"
  },
  "successful": true,
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

**Sử dụng trong:**
- `lib/screens/lab/mix_chemicals_screen.dart` - Trộn hóa chất
- `lib/screens/lab/burn_chemical_screen.dart` - Đốt hóa chất
- `lib/screens/lab/electrolysis_screen.dart` - Điện phân
- `lib/screens/lab/quantitative_analysis_screen.dart` - Phân tích định lượng
- `lib/screens/lab/reaction_kinetics_screen.dart` - Động học phản ứng
- `lib/screens/lab/balance_equation_screen.dart` - Cân bằng phương trình

---

### 1.7. Collection: `exam_results` (Kết quả thi)

**📍 Vị trí:** Firebase Firestore (Tự động tạo khi user làm đề thi)
**🔧 API Service:** `lib/services/user_data_service.dart`

**Chức năng:**
```dart
// Lưu kết quả thi
Future<void> saveExamResult({
  required String userId,
  required String examId,
  required String examTitle,
  required int totalQuestions,
  required int correctAnswers,
  required int score,
  required int timeSpent,
  required List<Map<String, dynamic>> answers,
})

// Lấy lịch sử thi
Future<List<Map<String, dynamic>>> getExamHistory(String userId, {String? examId})

// Lấy điểm thi cao nhất
Future<Map<String, Map<String, dynamic>>> getBestExamScores(String userId)
```

**Sử dụng trong:**
- `lib/screens/exam/exam_screen.dart` - Làm đề thi

---

### 1.8. Progress & Leaderboard Services

**📍 Vị trí:** `lib/services/progress_service.dart` và `lib/services/leaderboard_service.dart`

**Chức năng Progress:**
```dart
// Lấy tiến độ user
Future<UserProgress> getUserProgress(String userId)

// Cập nhật tiến độ
Future<void> updateProgress(UserProgress progress)

// Thêm điểm
Future<UserProgress> addPoints(String userId, int points)

// Hoàn thành bài học
Future<UserProgress> completeLesson(String userId, String courseId)

// Hoàn thành lab
Future<UserProgress> completeLab(String userId, String labId, int points)

// Hoàn thành game
Future<UserProgress> completeGame(String userId, String gameId, int score)

// Cập nhật streak
Future<UserProgress> updateStreak(String userId)

// Kiểm tra achievements
Future<UserProgress> checkAchievements(String userId)
```

**Chức năng Leaderboard:**
```dart
// Lấy top users
Future<List<Map<String, dynamic>>> getTopUsers({int limit = 20})

// Lấy thứ hạng user
Future<Map<String, dynamic>> getUserRank(String userId)

// Stream leaderboard real-time
Stream<List<Map<String, dynamic>>> streamLeaderboard({int limit = 20})
```

**Sử dụng trong:**
- `lib/screens/profile/profile_screen.dart` - Hiển thị tiến độ
- `lib/screens/profile/leaderboard_screen.dart` - Bảng xếp hạng

---

## � PHẦN 2: CHI TIẾT TẤT CẢ API SERVICES

### 🔧 2.1. FirestoreService - API Cơ Bản

**📍 Vị trí:** `lib/services/firestore_service.dart`

**Mục đích:** Quản lý các operations cơ bản với Firestore (chemicals, users, experiments, quiz)

#### API Methods:

| Method | Parameters | Return | Công dụng |
|--------|-----------|--------|-----------|
| `createUser()` | `UserModel user` | `Future<void>` | Tạo user mới khi đăng ký |
| `getUser()` | `String uid` | `Future<UserModel?>` | Lấy thông tin user theo ID |
| `updateUser()` | `String uid, Map<String, dynamic> data` | `Future<void>` | Cập nhật thông tin user |
| `getChemicals()` | - | `Future<List<ChemicalModel>>` | Lấy tất cả 118 nguyên tố |
| `getChemical()` | `String id` | `Future<ChemicalModel?>` | Lấy 1 nguyên tố theo ID |
| `getElements()` | - | `Future<List<ElementModel>>` | Lấy elements cho bảng tuần hoàn |
| `saveExperiment()` | `ExperimentModel experiment` | `Future<void>` | Lưu thí nghiệm |
| `getUserExperiments()` | `String userId` | `Future<List<ExperimentModel>>` | Lấy thí nghiệm của user |
| `getQuizzes()` | - | `Future<List<QuizModel>>` | Lấy quizzes (KHÔNG DÙNG) |
| `saveQuizResult()` | `String userId, String quizId, int score` | `Future<void>` | Lưu kết quả quiz |
| `getUserQuizResults()` | `String userId` | `Future<List<Map>>` | Lấy kết quả quiz của user |

**Sử dụng trong:**
- `lib/providers/auth_provider.dart` - Quản lý user
- `lib/providers/lab_provider.dart` - Quản lý lab
- `lib/screens/course/periodic_table_screen.dart` - Hiển thị bảng tuần hoàn
- `lib/screens/lab/mix_chemicals_screen.dart` - Trộn hóa chất

---

### 🎮 2.2. UserDataService - API Lưu Kết Quả

**📍 Vị trí:** `lib/services/user_data_service.dart`

**Mục đích:** Quản lý TẤT CẢ kết quả của user (game, lab, course, exam, activities)

#### 🎯 GAME APIs:

| Method | Parameters | Return | Công dụng |
|--------|-----------|--------|-----------|
| `saveGameResult()` | `userId, gameType, level, score, timeSpent, completed` | `Future<void>` | Lưu kết quả game + cập nhật best score |
| `getGameHistory()` | `userId, {gameType?}` | `Future<List<Map>>` | Lấy lịch sử chơi game (50 gần nhất) |
| `getBestScores()` | `userId` | `Future<Map<String, int>>` | Lấy điểm cao nhất từng game |

**Game Types:**
- `quiz_nhanh` - Quiz nhanh
- `ghi_nho` - Ghi nhớ
- `xay_dung_phan_tu` - Xây dựng phân tử
- `ghep_tu` - Ghép từ
- `tong_hop` - Tổng hợp

**Sử dụng trong:**
- `lib/screens/game/quiz_nhanh_screen.dart`
- `lib/screens/game/ghi_nho_screen.dart`
- `lib/screens/game/xay_dung_phan_tu_screen.dart`
- `lib/screens/game/ghep_tu_screen.dart`
- `lib/screens/game/tong_hop_screen.dart`

#### 🧪 LAB APIs:

| Method | Parameters | Return | Công dụng |
|--------|-----------|--------|-----------|
| `saveLabExperiment()` | `userId, labType, experimentName, inputs, results, successful` | `Future<void>` | Lưu thí nghiệm lab + cập nhật stats |
| `getLabHistory()` | `userId, {labType?}` | `Future<List<Map>>` | Lấy lịch sử lab (50 gần nhất) |
| `getLabStats()` | `userId` | `Future<Map<String, Map>>` | Lấy thống kê lab (tổng/thành công) |

**Lab Types:**
- `mix_chemicals` - Trộn hóa chất
- `burn_chemical` - Đốt hóa chất
- `electrolysis` - Điện phân
- `quantitative_analysis` - Phân tích định lượng
- `reaction_kinetics` - Động học phản ứng
- `balance_equation` - Cân bằng phương trình

**Sử dụng trong:**
- `lib/screens/lab/mix_chemicals_screen.dart`
- `lib/screens/lab/burn_chemical_screen.dart`
- `lib/screens/lab/electrolysis_screen.dart`
- `lib/screens/lab/quantitative_analysis_screen.dart`
- `lib/screens/lab/reaction_kinetics_screen.dart`
- `lib/screens/lab/balance_equation_screen.dart`

#### 📚 COURSE APIs:

| Method | Parameters | Return | Công dụng |
|--------|-----------|--------|-----------|
| `saveLessonProgress()` | `userId, courseId, lessonId, progress, completed, {timeSpent?}` | `Future<void>` | Lưu tiến độ bài học + cập nhật course |
| `getCourseProgress()` | `userId, courseId` | `Future<Map?>` | Lấy tiến độ 1 khóa học |
| `getAllCourseProgress()` | `userId` | `Future<Map<String, Map>>` | Lấy tiến độ tất cả khóa học |

**Sử dụng trong:**
- `lib/screens/course/lesson_detail_screen.dart` - Học bài
- `lib/screens/course/course_screen.dart` - Xem tiến độ

#### 📝 EXAM APIs:

| Method | Parameters | Return | Công dụng |
|--------|-----------|--------|-----------|
| `saveExamResult()` | `userId, examId, examTitle, totalQuestions, correctAnswers, score, timeSpent, answers` | `Future<void>` | Lưu kết quả thi + cập nhật best score |
| `getExamHistory()` | `userId, {examId?}` | `Future<List<Map>>` | Lấy lịch sử thi (50 gần nhất) |
| `getBestExamScores()` | `userId` | `Future<Map<String, Map>>` | Lấy điểm thi cao nhất từng đề |

**Sử dụng trong:**
- `lib/screens/exam/exam_screen.dart` - Làm đề thi

#### 📊 STATISTICS APIs:

| Method | Parameters | Return | Công dụng |
|--------|-----------|--------|-----------|
| `getUserStatistics()` | `userId` | `Future<Map>` | Lấy tổng quan thống kê (game, lab, course, exam) |

**Trả về:**
```dart
{
  'totalGamesPlayed': 50,
  'totalLabExperiments': 30,
  'totalCoursesStarted': 5,
  'totalExamsTaken': 10,
  'bestGameScores': {...},
  'labStatistics': {...},
  'courseProgress': {...}
}
```

**Sử dụng trong:**
- `lib/screens/profile/profile_screen.dart` - Hiển thị thống kê

#### 📝 ACTIVITY LOG APIs:

| Method | Parameters | Return | Công dụng |
|--------|-----------|--------|-----------|
| `logActivity()` | `userId, activityType, action, itemId, {metadata?}` | `Future<void>` | Ghi log hoạt động user |
| `getRecentActivities()` | `userId, {limit = 20}` | `Future<List<Map>>` | Lấy hoạt động gần đây |

**Activity Types:** `game`, `lab`, `course`, `exam`
**Actions:** `start`, `complete`, `view`

**Sử dụng trong:**
- `lib/screens/profile/activity_screen.dart` - Xem lịch sử hoạt động

---

### 📈 2.3. ProgressService - API Tiến Độ

**📍 Vị trí:** `lib/services/progress_service.dart`

**Mục đích:** Quản lý tiến độ, điểm, streak, achievements của user

#### API Methods:

| Method | Parameters | Return | Công dụng |
|--------|-----------|--------|-----------|
| `getUserProgress()` | `userId` | `Future<UserProgress>` | Lấy toàn bộ tiến độ user |
| `updateProgress()` | `UserProgress progress` | `Future<void>` | Cập nhật tiến độ |
| `addPoints()` | `userId, points` | `Future<UserProgress>` | Thêm điểm cho user |
| `completeLesson()` | `userId, courseId` | `Future<UserProgress>` | Đánh dấu hoàn thành bài học |
| `completeLab()` | `userId, labId, points` | `Future<UserProgress>` | Đánh dấu hoàn thành lab + thêm điểm |
| `completeGame()` | `userId, gameId, score` | `Future<UserProgress>` | Đánh dấu hoàn thành game + lưu best score |
| `updateStreak()` | `userId` | `Future<UserProgress>` | Cập nhật streak (chuỗi ngày học liên tục) |
| `checkAchievements()` | `userId` | `Future<UserProgress>` | Kiểm tra và mở khóa achievements |
| `streamUserProgress()` | `userId` | `Stream<UserProgress>` | Stream real-time tiến độ user |

**UserProgress Model:**
```dart
{
  userId: String,
  totalPoints: int,
  completedLessons: int,
  totalLessons: int,
  currentStreak: int,
  lastActiveDate: DateTime?,
  achievements: Map<String, bool>,
  courseProgress: Map<String, int>,
  labProgress: Map<String, int>,
  gameProgress: Map<String, int>
}
```

**Sử dụng trong:**
- `lib/providers/progress_provider.dart` - Quản lý tiến độ
- `lib/screens/profile/profile_screen.dart` - Hiển thị tiến độ
- `lib/screens/profile/achievements_screen.dart` - Hiển thị thành tích

---

### 🏆 2.4. LeaderboardService - API Xếp Hạng

**📍 Vị trí:** `lib/services/leaderboard_service.dart`

**Mục đích:** Quản lý bảng xếp hạng và thứ hạng user

#### API Methods:

| Method | Parameters | Return | Công dụng |
|--------|-----------|--------|-----------|
| `getTopUsers()` | `{limit = 20}` | `Future<List<Map>>` | Lấy top users theo điểm |
| `getUserRank()` | `userId` | `Future<Map>` | Lấy thứ hạng của user |
| `streamLeaderboard()` | `{limit = 20}` | `Stream<List<Map>>` | Stream real-time bảng xếp hạng |

**getTopUsers() trả về:**
```dart
[
  {
    'rank': 1,
    'userId': 'user_123',
    'displayName': 'Nguyễn Văn A',
    'email': 'user@example.com',
    'totalPoints': 5000,
    'completedLessons': 50,
    'currentStreak': 10,
    'achievements': {...}
  },
  ...
]
```

**getUserRank() trả về:**
```dart
{
  'rank': 15,
  'totalUsers': 100,
  'userPoints': 2500
}
```

**Sử dụng trong:**
- `lib/screens/profile/leaderboard_screen.dart` - Hiển thị bảng xếp hạng
- `lib/screens/home/home_screen.dart` - Hiển thị thứ hạng user

---

## �📁 PHẦN 3: DỮ LIỆU HARDCODE (KHÔNG CẦN FIREBASE)

### 3.1. Quiz Data

**📍 Vị trí:** `lib/data/quiz_data.dart`
**📊 Dữ liệu:** 200 câu hỏi trắc nghiệm (4 bộ x 50 câu)

**Các bộ quiz:**
```dart
QuizData.atomAndMoleculeQuiz      // 50 câu - Nguyên tử & Phân tử
QuizData.chemicalBondQuiz         // 50 câu - Liên kết hóa học
QuizData.chemicalReactionQuiz     // 50 câu - Phản ứng hóa học
QuizData.molCalculationQuiz       // 50 câu - Mol & Tính toán
```

**Cấu trúc dữ liệu:**
```dart
class QuizQuestion {
  final String question;        // Câu hỏi
  final List<String> options;   // 4 đáp án
  final int correctAnswer;      // Index đáp án đúng (0-3)
  final String explanation;     // Giải thích
}
```

**Sử dụng trong:**
- `lib/screens/quiz/quiz_screen.dart` - Màn hình làm quiz
- `lib/providers/quiz_provider.dart` - Provider quản lý quiz

**Lý do không dùng Firebase:** 
- Dữ liệu tĩnh, không thay đổi
- Load ngay lập tức, không cần internet
- Giảm chi phí Firebase reads

**⚠️ LƯU Ý:** App chỉ LOAD câu hỏi từ file này, LƯU KẾT QUẢ lên Firebase

---

### 3.2. Exam Data

**📍 Vị trí:** `lib/data/exam_data.dart`
**📊 Dữ liệu:** 210 câu thi (5 đề)

**Các đề thi:**
```dart
ExamData.exam1                    // 40 câu - Đề thi thử số 1
ExamData.exam2                    // 40 câu - Đề thi thử số 2
ExamData.exam3                    // 40 câu - Đề thi thử số 3
ExamData.advancedTopic            // 30 câu - Chuyên đề nâng cao
ExamData.comprehensiveReview      // 50 câu - Tổng ôn tập
```

**Cấu trúc dữ liệu:**
```dart
class ExamQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;
  final String difficulty;      // 'easy', 'medium', 'hard'
}
```

**Sử dụng trong:**
- `lib/screens/exam/exam_screen.dart` - Màn hình làm đề thi

**Lý do không dùng Firebase:** 
- Đề thi cố định, không cần cập nhật thường xuyên
- Tránh tốn Firebase reads
- Bảo mật đề thi (không public trên cloud)

**⚠️ LƯU Ý:** App chỉ LOAD đề thi từ file này, LƯU KẾT QUẢ lên Firebase

---

### 3.3. Game Data

**📍 Vị trí:** `lib/data/game_data.dart`
**📊 Dữ liệu:** 50 levels (5 games x 10 levels)

**Các game:**
```dart
GameData.quizNhanhLevels          // 10 levels - Quiz nhanh
GameData.ghiNhoLevels             // 10 levels - Ghi nhớ
GameData.xayDungPhanTuLevels      // 10 levels - Xây dựng phân tử
GameData.ghepTuLevels             // 10 levels - Ghép từ
GameData.tongHopLevels            // 10 levels - Tổng hợp
```

**Cấu trúc dữ liệu:**
```dart
class GameLevel {
  final int level;
  final String title;
  final String description;
  final int timeLimit;          // Giây
  final int targetScore;        // Điểm cần đạt
  final List<dynamic> data;     // Data riêng cho từng game
}
```

**Chi tiết từng game:**

1. **Quiz Nhanh** - Trả lời nhanh câu hỏi hóa học
   - Data: List câu hỏi trắc nghiệm
   - Mục tiêu: Trả lời đúng trong thời gian giới hạn

2. **Ghi Nhớ** - Ghi nhớ công thức, ký hiệu
   - Data: List cặp (ký hiệu - tên nguyên tố)
   - Mục tiêu: Ghép đúng cặp

3. **Xây Dựng Phân Tử** - Tạo phân tử từ nguyên tử
   - Data: List phân tử cần tạo
   - Mục tiêu: Kéo thả nguyên tử đúng vị trí

4. **Ghép Từ** - Ghép chữ thành thuật ngữ hóa học
   - Data: List từ cần ghép
   - Mục tiêu: Sắp xếp chữ cái đúng

5. **Tổng Hợp** - Kết hợp nhiều dạng bài
   - Data: Mix các dạng trên
   - Mục tiêu: Hoàn thành tất cả

**Sử dụng trong:**
- `lib/screens/game/quiz_nhanh_screen.dart`
- `lib/screens/game/ghi_nho_screen.dart`
- `lib/screens/game/xay_dung_phan_tu_screen.dart`
- `lib/screens/game/ghep_tu_screen.dart`
- `lib/screens/game/tong_hop_screen.dart`

**Lý do không dùng Firebase:** 
- Game levels cố định
- Load ngay lập tức, không lag
- Offline-friendly

**⚠️ LƯU Ý:** App chỉ LOAD levels từ file này, LƯU ĐIỂM lên Firebase

---

### 3.4. Lesson Content

**📍 Vị trí:** `lib/data/lesson_content.dart`
**📊 Dữ liệu:** 10 bài học lý thuyết đầy đủ

**Các bài học:**
```dart
LessonContent.getLessonContent('Nguyên tử & Phân tử')
LessonContent.getLessonContent('Liên kết hóa học')
LessonContent.getLessonContent('Phản ứng cơ bản')
LessonContent.getLessonContent('Mol & Tính toán')
LessonContent.getLessonContent('Hiđrocacbon')
LessonContent.getLessonContent('Ancol & Phenol')
LessonContent.getLessonContent('Anđehit & Xeton')
LessonContent.getLessonContent('Axit cacboxylic')
LessonContent.getLessonContent('Este & Lipit')
LessonContent.getLessonContent('Cacbohiđrat')
```

**Cấu trúc dữ liệu:**
```dart
class LessonContent {
  final String title;
  final List<LessonSection> sections;
}

class LessonSection {
  final String heading;         // Tiêu đề phần
  final String content;         // Nội dung text
  final String? imageUrl;       // Hình ảnh minh họa
  final List<String>? examples; // Ví dụ
  final String? note;           // Ghi chú quan trọng
}
```

**Nội dung mỗi bài:**
- Lý thuyết đầy đủ (3000-5000 từ)
- Hình ảnh minh họa
- Ví dụ cụ thể
- Ghi chú quan trọng
- Bài tập vận dụng

**Sử dụng trong:**
- `lib/screens/course/lesson_detail_screen.dart` - Màn hình học bài
- `lib/screens/course/course_screen.dart` - Danh sách bài học

**Lý do không dùng Firebase:** 
- Nội dung bài học rất dài (3000-5000 từ/bài)
- Tốn nhiều Firebase reads nếu load từ cloud
- Load nhanh hơn từ code
- Offline-friendly

**⚠️ LƯU Ý:** App chỉ LOAD nội dung từ file này, LƯU TIẾN ĐỘ lên Firebase

---

## 🔐 PHẦN 3: FIREBASE SECURITY RULES (BẢO MẬT)

**📍 Vị trí:** Firebase Console → Firestore Database → Rules tab

**Mục đích:** Bảo vệ dữ liệu, kiểm soát quyền truy cập, ngăn chặn truy cập trái phép

### 🔒 QUY TẮC BẢO MẬT CHI TIẾT:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // ============ CHEMICALS COLLECTION ============
    // Mọi người ĐỌC được, chỉ ADMIN mới GHI
    match /chemicals/{chemicalId} {
      allow read: if true;  // Ai cũng xem được bảng tuần hoàn
      allow write: if false; // Không ai ghi được (chỉ admin qua Console)
    }
    
    // ============ USERS COLLECTION ============
    // Chỉ user đó mới đọc/ghi data của chính mình
    match /users/{userId} {
      allow read: if request.auth != null && request.auth.uid == userId;
      allow write: if request.auth != null && request.auth.uid == userId;
      
      // Subcollections của user
      match /best_scores/{scoreId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      match /lab_stats/{statId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      match /lesson_progress/{progressId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      match /course_progress/{courseId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      match /best_exam_scores/{examId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
    
    // ============ EXPERIMENTS COLLECTION ============
    // Chỉ user đó mới thấy thí nghiệm của mình
    match /experiments/{experimentId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.resource.data.userId == request.auth.uid;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // ============ QUIZ RESULTS COLLECTION ============
    // Chỉ user đó mới thấy kết quả quiz của mình
    match /quiz_results/{resultId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.resource.data.userId == request.auth.uid;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // ============ GAME RESULTS COLLECTION ============
    // Chỉ user đó mới thấy kết quả game của mình
    match /game_results/{resultId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.resource.data.userId == request.auth.uid;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // ============ LAB EXPERIMENTS COLLECTION ============
    // Chỉ user đó mới thấy thí nghiệm lab của mình
    match /lab_experiments/{experimentId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.resource.data.userId == request.auth.uid;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // ============ EXAM RESULTS COLLECTION ============
    // Chỉ user đó mới thấy kết quả thi của mình
    match /exam_results/{resultId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.resource.data.userId == request.auth.uid;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // ============ USER ACTIVITIES COLLECTION ============
    // Chỉ user đó mới thấy hoạt động của mình
    match /user_activities/{activityId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.resource.data.userId == request.auth.uid;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // ============ LEADERBOARD (ĐẶC BIỆT) ============
    // Cho phép LIST users để xếp hạng (chỉ đọc totalPoints, displayName)
    // Quy tắc này đã được xử lý ở users collection phía trên
    // LeaderboardService sẽ query users collection với orderBy totalPoints
  }
}
```

### 📖 GIẢI THÍCH CÁC QUY TẮC:

#### 1. **chemicals** - Bảng tuần hoàn
- ✅ **READ (Đọc):** Ai cũng xem được (không cần đăng nhập)
- ❌ **WRITE (Ghi):** Không ai ghi được, chỉ admin qua Firebase Console
- **Lý do:** Dữ liệu tĩnh, không thay đổi, cần public để mọi người học

#### 2. **users** - Thông tin người dùng
- ✅ **READ/WRITE:** Chỉ user đó mới đọc/ghi data của chính mình
- ✅ **Subcollections:** Cũng chỉ user đó mới truy cập
- **Lý do:** Bảo mật thông tin cá nhân, điểm số, tiến độ

#### 3. **experiments, quiz_results, game_results, lab_experiments, exam_results**
- ✅ **READ:** Chỉ user đó mới thấy kết quả của mình
- ✅ **CREATE:** User chỉ tạo được document với userId của mình
- ✅ **UPDATE/DELETE:** Chỉ sửa/xóa được document của mình
- **Lý do:** Ngăn user xem/sửa kết quả của người khác

#### 4. **Leaderboard** - Bảng xếp hạng
- ✅ **ĐẶC BIỆT:** Cho phép query users collection để lấy top điểm
- ✅ LeaderboardService dùng: `.orderBy('totalPoints', descending: true)`
- **Lý do:** Cần xem điểm của người khác để xếp hạng

### ⚠️ LƯU Ý QUAN TRỌNG:

1. **KHÔNG BAO GIỜ** cho phép `allow write: if true` trên collections quan trọng
2. **LUÔN LUÔN** kiểm tra `request.auth != null` (user đã đăng nhập)
3. **LUÔN LUÔN** kiểm tra `userId == request.auth.uid` (đúng user)
4. **Leaderboard** cần đặc biệt: Cho phép đọc users nhưng KHÔNG cho ghi
5. **Chemicals** là public read-only vì là dữ liệu học tập

### 🔧 CÁCH CẬP NHẬT RULES:

1. Vào Firebase Console: https://console.firebase.google.com
2. Chọn project ChemLearn
3. Vào **Firestore Database** → **Rules** tab
4. Copy toàn bộ rules ở trên
5. Paste vào editor
6. Click **Publish** để áp dụng

---

## 📊 PHẦN 4: FIREBASE COLLECTIONS CHI TIẾT

### 4.1. Collection: `chemicals` ✅ CẦN CÓ TRƯỚC

**Mục đích:** Lưu 118 nguyên tố trong bảng tuần hoàn

**Cấu trúc document:**
```json
{
  "id": "element_1",
  "atomicNumber": 1,
  "symbol": "H",
  "name": "Hydro",
  "atomicMass": "1.008",
  "oxidationStates": "-1, +1",
  "category": "Phi kim",
  "type": "element",
  "formula": "H",
  "description": "Nguyên tố Hydro (H) - Số hiệu nguyên tử: 1",
  "imageUrl": "",
  "hazardLevel": "low",
  "state": "solid",
  "color": "gray"
}
```

**Số lượng:** 118 documents (element_1 đến element_118)

**Nguồn data:** `assets/periodic_table.json`

**Trạng thái:** ✅ Đã upload

---

### 4.2. Collection: `users` ✅ TỰ ĐỘNG TẠO

**Mục đích:** Lưu thông tin user

**Cấu trúc document:**
```json
{
  "uid": "user_id_123",
  "email": "user@example.com",
  "displayName": "Nguyễn Văn A",
  "photoUrl": "https://...",
  "createdAt": "2024-01-01T00:00:00.000Z",
  "lastLogin": "2024-01-01T00:00:00.000Z",
  "totalPoints": 0,
  "completedLessons": 0,
  "totalLessons": 50,
  "currentStreak": 0,
  "achievements": {},
  "courseProgress": {},
  "labProgress": {},
  "gameProgress": {}
}
```

**Subcollections:**
- `best_scores/{gameId}` - Điểm cao nhất từng game
- `lab_stats/{labType}` - Thống kê lab
- `lesson_progress/{lessonId}` - Tiến độ bài học
- `course_progress/{courseId}` - Tiến độ khóa học
- `best_exam_scores/{examId}` - Điểm thi cao nhất

**Trạng thái:** ✅ Tự động tạo khi user đăng ký

---

### 4.3. Collection: `experiments` ⚪ TỰ ĐỘNG TẠO

**Mục đích:** Lưu thí nghiệm của user

**Cấu trúc document:**
```json
{
  "id": "exp_123",
  "userId": "user_id_123",
  "experimentType": "mix",
  "chemicals": ["HCl", "NaOH"],
  "result": "NaCl + H2O",
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

**Trạng thái:** ⚪ Tự động tạo khi user làm thí nghiệm lần đầu

---

### 4.4. Collection: `quiz_results` ⚪ TỰ ĐỘNG TẠO

**Mục đích:** Lưu kết quả quiz

**Cấu trúc document:**
```json
{
  "userId": "user_id_123",
  "quizId": "atom_molecule",
  "score": 85,
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

**Trạng thái:** ⚪ Tự động tạo khi user làm quiz lần đầu

---

### 4.5. Collection: `game_results` ⚪ TỰ ĐỘNG TẠO

**Mục đích:** Lưu kết quả game

**Cấu trúc document:**
```json
{
  "userId": "user_id_123",
  "gameType": "quiz_nhanh",
  "level": 1,
  "score": 100,
  "timeSpent": 120,
  "completed": true,
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

**Trạng thái:** ⚪ Tự động tạo khi user chơi game lần đầu

---

### 4.6. Collection: `lab_experiments` ⚪ TỰ ĐỘNG TẠO

**Mục đích:** Lưu thí nghiệm lab chi tiết

**Cấu trúc document:**
```json
{
  "userId": "user_id_123",
  "labType": "mix_chemicals",
  "experimentName": "Trộn HCl và NaOH",
  "inputs": {
    "chemical1": "HCl",
    "chemical2": "NaOH",
    "volume1": 10,
    "volume2": 10
  },
  "results": {
    "product": "NaCl + H2O",
    "observation": "Tỏa nhiệt"
  },
  "successful": true,
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

**Trạng thái:** ⚪ Tự động tạo khi user làm lab lần đầu

---

### 4.7. Collection: `exam_results` ⚪ TỰ ĐỘNG TẠO

**Mục đích:** Lưu kết quả thi

**Cấu trúc document:**
```json
{
  "userId": "user_id_123",
  "examId": "exam1",
  "examTitle": "Đề thi thử số 1",
  "totalQuestions": 40,
  "correctAnswers": 35,
  "score": 87.5,
  "timeSpent": 3600,
  "answers": [...],
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

**Trạng thái:** ⚪ Tự động tạo khi user làm thi lần đầu

---

### 4.8. Collection: `user_activities` ⚪ TỰ ĐỘNG TẠO

**Mục đích:** Lưu lịch sử hoạt động

**Cấu trúc document:**
```json
{
  "userId": "user_id_123",
  "activityType": "game",
  "action": "complete",
  "itemId": "quiz_nhanh_level_1",
  "metadata": {...},
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

**Trạng thái:** ⚪ Tự động tạo khi user có hoạt động

---

## ✅ CHECKLIST DATABASE

### Dữ liệu BẮT BUỘC (Phải có trước khi chạy app):
- [x] **chemicals** - 118 nguyên tố (đã upload)
- [x] **users** - Tự động tạo khi đăng ký
- [x] **Firebase Rules** - Đã cấu hình bảo mật
- [x] **Quiz Data** - Có sẵn trong code
- [x] **Exam Data** - Có sẵn trong code
- [x] **Game Data** - Có sẵn trong code
- [x] **Lesson Content** - Có sẵn trong code

### Dữ liệu TỰ ĐỘNG (Tạo khi user sử dụng - KHÔNG CẦN TẠO TRƯỚC):
- [ ] **experiments** - Tự động tạo khi user làm thí nghiệm lần đầu
- [ ] **quiz_results** - Tự động tạo khi user làm quiz lần đầu
- [ ] **game_results** - Tự động tạo khi user chơi game lần đầu
- [ ] **lab_experiments** - Tự động tạo khi user làm lab lần đầu
- [ ] **exam_results** - Tự động tạo khi user làm thi lần đầu

## 🎯 KẾT LUẬN

**App đã sẵn sàng chạy!** Không cần upload thêm data nào.

- ✅ Dữ liệu tĩnh (quiz, exam, game, lesson) đã có trong code
- ✅ Dữ liệu động (chemicals, users) đã có trên Firebase
- ✅ Các collections khác sẽ tự động tạo khi user sử dụng

**Chỉ cần:** Build app và chạy thôi! 🚀


## 📋 PHẦN 5: LUỒNG DỮ LIỆU (DATA FLOW)

### 🎮 Luồng Game:

```
User chơi game
    ↓
Load level từ GameData (HARDCODE)
    ↓
User hoàn thành level
    ↓
UserDataService.saveGameResult()
    ↓
Lưu vào Firebase: game_results
    ↓
Cập nhật: users/{userId}/best_scores
    ↓
ProgressService.completeGame()
    ↓
Cập nhật: users/{userId} (totalPoints, gameProgress)
```

### 📚 Luồng Course:

```
User học bài
    ↓
Load nội dung từ LessonContent (HARDCODE)
    ↓
User hoàn thành bài
    ↓
UserDataService.saveLessonProgress()
    ↓
Lưu vào: users/{userId}/lesson_progress
    ↓
Cập nhật: users/{userId}/course_progress
    ↓
ProgressService.completeLesson()
    ↓
Cập nhật: users/{userId} (completedLessons, totalPoints)
```

### 🧪 Luồng Lab:

```
User làm thí nghiệm
    ↓
Load chemicals từ Firebase: chemicals
    ↓
User thực hiện thí nghiệm
    ↓
UserDataService.saveLabExperiment()
    ↓
Lưu vào Firebase: lab_experiments
    ↓
Cập nhật: users/{userId}/lab_stats
    ↓
ProgressService.completeLab()
    ↓
Cập nhật: users/{userId} (totalPoints, labProgress)
```

### 📝 Luồng Quiz:

```
User làm quiz
    ↓
Load câu hỏi từ QuizData (HARDCODE)
    ↓
User hoàn thành quiz
    ↓
FirestoreService.saveQuizResult()
    ↓
Lưu vào Firebase: quiz_results
    ↓
ProgressService.addPoints()
    ↓
Cập nhật: users/{userId} (totalPoints)
```

### 📝 Luồng Exam:

```
User làm đề thi
    ↓
Load đề từ ExamData (HARDCODE)
    ↓
User hoàn thành đề
    ↓
UserDataService.saveExamResult()
    ↓
Lưu vào Firebase: exam_results
    ↓
Cập nhật: users/{userId}/best_exam_scores
    ↓
ProgressService.addPoints()
    ↓
Cập nhật: users/{userId} (totalPoints)
```

### 🏆 Luồng Leaderboard:

```
User mở bảng xếp hạng
    ↓
LeaderboardService.getTopUsers()
    ↓
Query Firebase: users
    ↓
OrderBy: totalPoints (descending)
    ↓
Limit: 20 users
    ↓
Hiển thị bảng xếp hạng
```

---

## ⚠️ PHẦN 6: XÓA DATA CŨ (NẾU CẦN)

### Collections CẦN XÓA nếu là data test:

1. **test** - Collection test kết nối
2. **quizzes** - Quiz data cũ bằng tiếng Anh (KHÔNG DÙNG)
3. **quiz_results** - Kết quả quiz test cũ
4. **experiments** - Thí nghiệm test cũ
5. **game_results** - Kết quả game test cũ
6. **lab_experiments** - Thí nghiệm lab test cũ
7. **exam_results** - Kết quả thi test cũ
8. **user_activities** - Hoạt động test cũ

### Collections KHÔNG XÓA:

1. **chemicals** - 118 nguyên tố (CẦN THIẾT)
2. **users** - Thông tin users thật (CẦN THIẾT nếu có users thật)

### Cách xóa:

**Cách 1: Xóa từng document (An toàn)**
1. Vào Firebase Console → Firestore Database → Data
2. Click vào collection cần xóa
3. Click vào từng document
4. Click nút "Delete document"

**Cách 2: Xóa cả collection (Nhanh)**
1. Vào Firebase Console → Firestore Database → Data
2. Click vào collection cần xóa
3. Click nút "..." (3 chấm)
4. Chọn "Delete collection"
5. Nhập tên collection để xác nhận
6. Click "Delete"

**⚠️ LƯU Ý:** 
- Xóa collection sẽ XÓA TẤT CẢ documents bên trong
- KHÔNG THỂ KHÔI PHỤC sau khi xóa
- Nên backup trước khi xóa nếu không chắc chắn

---

## ✅ PHẦN 7: CHECKLIST HOÀN CHỈNH

### Trước khi chạy app:

- [x] **Firebase Project** - Đã tạo project
- [x] **Firebase Authentication** - Đã bật Email/Password
- [x] **Firestore Database** - Đã tạo database
- [x] **Firebase Rules** - Đã cấu hình bảo mật
- [x] **chemicals collection** - Đã upload 118 nguyên tố
- [x] **google-services.json** - Đã thêm vào android/app/
- [x] **firebase_options.dart** - Đã generate
- [x] **Quiz Data** - Có sẵn trong lib/data/quiz_data.dart
- [x] **Exam Data** - Có sẵn trong lib/data/exam_data.dart
- [x] **Game Data** - Có sẵn trong lib/data/game_data.dart
- [x] **Lesson Content** - Có sẵn trong lib/data/lesson_content.dart

### Sau khi chạy app:

- [ ] **users collection** - Tự động tạo khi user đăng ký
- [ ] **experiments** - Tự động tạo khi user làm thí nghiệm
- [ ] **quiz_results** - Tự động tạo khi user làm quiz
- [ ] **game_results** - Tự động tạo khi user chơi game
- [ ] **lab_experiments** - Tự động tạo khi user làm lab
- [ ] **exam_results** - Tự động tạo khi user làm thi
- [ ] **user_activities** - Tự động tạo khi user có hoạt động

### Kiểm tra app hoạt động:

- [ ] User đăng ký/đăng nhập thành công
- [ ] Xem được bảng tuần hoàn (118 nguyên tố)
- [ ] Làm quiz được (load từ hardcode)
- [ ] Chơi game được (load từ hardcode)
- [ ] Làm lab được (load chemicals từ Firebase)
- [ ] Làm đề thi được (load từ hardcode)
- [ ] Học bài được (load từ hardcode)
- [ ] Xem được tiến độ cá nhân
- [ ] Xem được bảng xếp hạng
- [ ] Kết quả được lưu lên Firebase

---

## 🎯 PHẦN 8: KẾT LUẬN

### ✅ App đã sẵn sàng chạy!

**Dữ liệu đã có:**
- ✅ 118 nguyên tố trên Firebase
- ✅ 200 câu quiz trong code
- ✅ 210 câu thi trong code
- ✅ 50 game levels trong code
- ✅ 10 bài học trong code
- ✅ Firebase Rules đã cấu hình

**Không cần làm gì thêm:**
- ❌ KHÔNG cần upload quiz lên Firebase
- ❌ KHÔNG cần upload exam lên Firebase
- ❌ KHÔNG cần upload game lên Firebase
- ❌ KHÔNG cần upload lesson lên Firebase
- ❌ KHÔNG cần tạo collections trước

**Chỉ cần:**
1. Build app: `flutter build apk` hoặc `flutter run`
2. Đăng ký tài khoản
3. Bắt đầu sử dụng!

**App sẽ tự động:**
- Tạo user document khi đăng ký
- Tạo collections khi user sử dụng lần đầu
- Lưu kết quả lên Firebase
- Cập nhật tiến độ real-time
- Xếp hạng users

### 🚀 Chúc bạn thành công!

**Nếu gặp vấn đề:**
1. Kiểm tra Firebase Rules đã publish chưa
2. Kiểm tra chemicals collection có 118 documents chưa
3. Kiểm tra google-services.json đã thêm chưa
4. Xem logs để debug: `flutter run --verbose`

**Liên hệ hỗ trợ:**
- Xem lại file này để hiểu rõ API
- Kiểm tra Firebase Console để xem data
- Debug từng bước theo luồng data flow

---

## 📚 PHỤ LỤC: TÀI LIỆU THAM KHẢO

### File quan trọng:

1. **Services:**
   - `lib/services/firestore_service.dart` - API cơ bản
   - `lib/services/user_data_service.dart` - API lưu kết quả
   - `lib/services/progress_service.dart` - API tiến độ
   - `lib/services/leaderboard_service.dart` - API xếp hạng

2. **Data:**
   - `lib/data/quiz_data.dart` - 200 câu quiz
   - `lib/data/exam_data.dart` - 210 câu thi
   - `lib/data/game_data.dart` - 50 game levels
   - `lib/data/lesson_content.dart` - 10 bài học

3. **Providers:**
   - `lib/providers/auth_provider.dart` - Quản lý auth
   - `lib/providers/quiz_provider.dart` - Quản lý quiz
   - `lib/providers/lab_provider.dart` - Quản lý lab
   - `lib/providers/progress_provider.dart` - Quản lý tiến độ

4. **Screens:**
   - `lib/screens/game/*.dart` - 5 game screens
   - `lib/screens/lab/*.dart` - 6 lab screens
   - `lib/screens/course/*.dart` - Course screens
   - `lib/screens/exam/*.dart` - Exam screens
   - `lib/screens/profile/*.dart` - Profile screens

### Firebase Console:

- **URL:** https://console.firebase.google.com
- **Project:** ChemLearn
- **Database:** Firestore Database
- **Rules:** Firestore Database → Rules tab
- **Data:** Firestore Database → Data tab

---

**📅 Cập nhật lần cuối:** 2024-01-05
**📝 Phiên bản:** 1.0
**✍️ Tác giả:** ChemLearn Team
