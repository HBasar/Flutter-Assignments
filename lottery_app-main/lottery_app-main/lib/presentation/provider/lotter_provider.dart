import 'package:flutter/foundation.dart';
import 'package:lottery_app/domain/use_cases/play_lottery_usecase.dart';
import '../../domain/entities/lottery_result.dart';
import '../../data/repositories/lottery_repository_impl.dart';

class LotteryProvider extends ChangeNotifier {
  final LotteryRepositoryImpl _repository = LotteryRepositoryImpl();

  late final PlayLotteryUseCase _playLotteryUseCase = PlayLotteryUseCase(
    _repository,
  );

  String? _userName;
  int? _selectedNumber;
  LotteryResult? _lotteryResult;
  String? _errorMessage;

  String? get userName => _userName;
  int? get selectedNumber => _selectedNumber;
  LotteryResult? get lotteryResult => _lotteryResult;
  String? get errorMessage => _errorMessage;

  bool get canPlay => _selectedNumber != null;

  void setUserName(String? name) {
    _userName = name;
    notifyListeners();
  }

  void setSelectedNumber(int? number) {
    _selectedNumber = number;
    _errorMessage = null;
    notifyListeners();
  }

  void playLottery() {
    _errorMessage = null;

    if (_selectedNumber == null) {
      _errorMessage = 'Please select a number';
      notifyListeners();
      return;
    }

    if (!_playLotteryUseCase.isValidNumber(_selectedNumber!)) {
      _errorMessage = 'Number must be between 1 and 10';
      notifyListeners();
      return;
    }

    try {
      _lotteryResult = _playLotteryUseCase.execute(
        userNumber: _selectedNumber!,
        userName: _userName,
      );
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void reset() {
    _userName = null;
    _selectedNumber = null;
    _lotteryResult = null;
    _errorMessage = null;
    notifyListeners();
  }
}
