import 'package:get_storage/get_storage.dart';

mixin PredictionManager {
  Future<bool> savePredictionClass(String? predictionClass) async {
    final box = GetStorage();
    await box.write(PredictionManagerKey.predictionClass.toString(), predictionClass);
    print("Saved prediction class to Cache: PredictionManager");
    return true;
  }

  String? getPredictionClass() {
    final box = GetStorage();
    print("Retrieved prediction Class from Cache: PredictionManager");
    return box.read(PredictionManagerKey.predictionClass.toString());
  }

}

enum PredictionManagerKey { predictionClass}
