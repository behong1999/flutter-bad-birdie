// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Bad Birdie - Ứng dụng cho người mê cầu lông';

  @override
  String get homeTitle => 'Bad Birdie';

  @override
  String get welcomeTitle => 'Chào mừng đến với Bad Birdie!';

  @override
  String get welcomeDescription =>
      'Nâng cao kỹ năng cầu lông với luyện di chuyển chân, phân tích chiến thuật và tài liệu học tập.';

  @override
  String get trainingFeatures => 'Tính năng luyện tập';

  @override
  String get footworkTraining => 'Luyện di chuyển chân';

  @override
  String get footworkDescription =>
      'Thực hành bài tập và cải thiện di chuyển trên sân';

  @override
  String get tacticalBoard => 'Bảng chiến thuật';

  @override
  String get tacticalDescription =>
      'Lên kế hoạch chiến thuật và phân tích tình huống trận đấu';

  @override
  String get learningHub => 'Trung tâm học tập';

  @override
  String get learningDescription => 'Khám phá kênh YouTube và hướng dẫn';

  @override
  String get comingSoon => 'Sắp ra mắt';

  @override
  String get chooseCornersTitle => 'Chọn góc sân cần tập trung';

  @override
  String get chooseCornersDescription =>
      'Chọn ít nhất 1 góc cho buổi luyện di chuyển chân';

  @override
  String get frontLeft => 'Trước\nTrái';

  @override
  String get frontCenter => 'Trước\nGiữa';

  @override
  String get frontRight => 'Trước\nPhải';

  @override
  String get midLeft => 'Giữa\nTrái';

  @override
  String get midCenter => 'Giữa\nGiữa';

  @override
  String get midRight => 'Giữa\nPhải';

  @override
  String get backLeft => 'Sau\nTrái';

  @override
  String get backCenter => 'Sau\nGiữa';

  @override
  String get backRight => 'Sau\nPhải';

  @override
  String selectedCorners(num count, String corners) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã chọn $countString góc: $corners',
    );
    return '$_temp0';
  }

  @override
  String get trainingSettings => 'Cài đặt luyện tập';

  @override
  String get sets => 'Hiệp';

  @override
  String setsValue(int count) {
    return '$count hiệp';
  }

  @override
  String get shotsPerSet => 'Cú đánh mỗi hiệp';

  @override
  String shotsValue(int count) {
    return '$count cú';
  }

  @override
  String get speed => 'Tốc độ';

  @override
  String speedValue(String speed) {
    return 'x$speed';
  }

  @override
  String get restBetweenSets => 'Nghỉ giữa các hiệp';

  @override
  String restValue(int seconds) {
    return '${seconds}s';
  }

  @override
  String get nextMoveNotification => 'Thông báo nước đi tiếp theo';

  @override
  String get ringtone => 'Chuông';

  @override
  String get speech => 'Giọng nói';

  @override
  String get letsBegin => 'Bắt đầu thôi! 🏸';

  @override
  String get saveSettings => 'Lưu cài đặt';

  @override
  String get help => 'Trợ giúp';

  @override
  String get readyToTrain => 'Sẵn sàng luyện tập! 🏸';

  @override
  String get corners => 'Góc sân';

  @override
  String get notification => 'Thông báo';

  @override
  String get cancel => 'Hủy';

  @override
  String get startTraining => 'Bắt đầu luyện tập';

  @override
  String get settingsSaved => 'Đã lưu cài đặt thành công!';

  @override
  String get trainingSettingsHelp => 'Trợ giúp cài đặt luyện tập';

  @override
  String get setsHelp =>
      'Số hiệp luyện tập bạn muốn hoàn thành. Mỗi hiệp gồm nhiều cú đánh.';

  @override
  String get shotsHelp =>
      'Số lần di chuyển đến góc trong mỗi hiệp. Càng nhiều cú thì mỗi hiệp càng dài.';

  @override
  String get speedHelp =>
      'Tốc độ gọi góc sân:\n• 1,0x = Người mới (chậm)\n• 2,5x = Trung cấp\n• 4,0x = Chuyên nghiệp (rất nhanh)';

  @override
  String get restHelp =>
      'Thời gian nghỉ giữa mỗi hiệp. Dùng để lấy lại hơi và chuẩn bị hiệp tiếp theo.';

  @override
  String get notificationHelp =>
      '• Chuông: Tiếng bíp đơn giản\n• Giọng nói: Đọc tên cú đánh (\"Phông\", \"Đập\", v.v.)';

  @override
  String get gotIt => 'Đã hiểu!';

  @override
  String get trainingStartingSoon => 'Buổi luyện sắp bắt đầu! 🏸';

  @override
  String get shotsLabel => 'Cú đánh';

  @override
  String get stopLabel => 'Dừng';

  @override
  String get pauseLabel => 'Tạm dừng';

  @override
  String get resumeLabel => 'Tiếp tục';

  @override
  String get againLabel => 'Làm lại';

  @override
  String get exitLabel => 'Thoát';

  @override
  String get enterFullscreen => 'Toàn màn hình';

  @override
  String get exitFullscreen => 'Thoát toàn màn hình';

  @override
  String get directionLabel => 'Hướng';

  @override
  String get trainingCompletedLabel => 'Hoàn thành luyện tập';

  @override
  String get trainingStoppedLabel => 'Đã dừng luyện tập';

  @override
  String get shotClear => 'Phông';

  @override
  String get shotDrop => 'Bỏ nhỏ';

  @override
  String get shotSmash => 'Đập';

  @override
  String get shotLift => 'Hất';

  @override
  String get shotBlock => 'Kê lưới';

  @override
  String get shotKill => 'Vồ';

  @override
  String get shotDrive => 'Tạt';

  @override
  String get skipLabel => 'Bỏ qua';

  @override
  String get savePreset => 'Lưu cài đặt sẵn';

  @override
  String get loadPreset => 'Tải cài đặt sẵn';

  @override
  String get loadPresetHelp =>
      'Trên thanh trên cùng, chạm biểu tượng này để mở cài đặt đã lưu. Chọn một mục để áp dụng góc sân, cú đánh, tốc độ, thời gian nghỉ và chế độ thông báo.';

  @override
  String get savePresetHelp =>
      'Trên thanh trên cùng, chạm biểu tượng này để lưu cấu hình hiện tại thành cài đặt sẵn. Đặt tên để tải lại sau.';

  @override
  String get presets => 'Cài đặt sẵn';

  @override
  String get noPresetsYet =>
      'Chưa có cài đặt sẵn. Chạm biểu tượng lưu để thêm.';

  @override
  String get presetNameLabel => 'Tên cài đặt sẵn';

  @override
  String get save => 'Lưu';

  @override
  String get delete => 'Xóa';

  @override
  String defaultPresetName(int number) {
    return 'Cài đặt $number';
  }

  @override
  String presetSummary(int sets, int shots, String speed, int rest) {
    return '$sets×$shots cú · x$speed · nghỉ ${rest}s';
  }

  @override
  String presetSaved(String name) {
    return 'Đã lưu cài đặt \"$name\"';
  }

  @override
  String presetDeleted(String name) {
    return 'Đã xóa cài đặt \"$name\"';
  }

  @override
  String get selectCornersFirst => 'Chọn ít nhất một góc sân trước khi lưu';

  @override
  String get settings => 'Cài đặt';

  @override
  String get appearance => 'Giao diện';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get themeSystem => 'Theo hệ thống';

  @override
  String get themeLight => 'Sáng';

  @override
  String get themeDark => 'Tối';

  @override
  String get shotSelection => 'Chọn cú đánh';

  @override
  String get optional => 'tùy chọn';

  @override
  String get presetNameExists => 'Tên đã tồn tại. Hãy chọn tên khác.';

  @override
  String get shotSelectionHelp =>
      'Chọn loại cú đánh được gọi khi luyện tập. Để trống để dùng tất cả cú phù hợp với góc sân đã chọn.';

  @override
  String get singlesLabel => 'Đánh đơn';

  @override
  String get doublesLabel => 'Đánh đôi';

  @override
  String get undoLabel => 'Hoàn tác';

  @override
  String get clearBoard => 'Khôi phục mặc định';

  @override
  String get renamePlayerTitle => 'Đổi tên người chơi';

  @override
  String get toolPencil => 'Bút';

  @override
  String get toolArrow => 'Mũi tên';

  @override
  String get toolMarker => 'Thêm người chơi';

  @override
  String get tacticalBoardHelpMarkersTitle => 'Điểm đánh dấu người chơi';

  @override
  String get tacticalBoardHelpMarkers =>
      'Kéo điểm đánh dấu để di chuyển. Nhấn giữ khoảng 1 giây (không di chuyển) để đổi tên. Điểm xanh và đỏ đại diện mỗi đội.';

  @override
  String get tacticalBoardHelpPencil =>
      'Vẽ đường tự do để thể hiện lối đi hoặc khu vực.';

  @override
  String get tacticalBoardHelpArrow =>
      'Kéo trên sân để vẽ mũi tên chỉ hướng hoặc chuyển động.';

  @override
  String get tacticalBoardHelpColorsTitle => 'Màu sắc';

  @override
  String get tacticalBoardHelpColors =>
      'Chạm màu để chọn màu nét cho bút và mũi tên.';

  @override
  String get tacticalBoardHelpUndo =>
      'Hoàn tác thao tác vẽ hoặc thay đổi điểm đánh dấu gần nhất.';

  @override
  String get tacticalBoardHelpClear =>
      'Đặt lại vị trí mặc định của người chơi và xóa mọi nét vẽ.';
}
