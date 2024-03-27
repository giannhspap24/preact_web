import 'package:get_storage/get_storage.dart';

mixin PatientManager {

  //Save patientID into Cache
  Future<bool> savePatientID(String? patientID) async {
    final box = GetStorage();
    await box.write(PatientManagerKey.patientID.toString(), patientID);
    print("Saved patientID into Cache: PatientManager");
    return true;
  }

  //Get patientID from Cache
  String? getPatientID() {
    print("Retrieved patientID from Cache: PatientManager");
    final box = GetStorage();
    return box.read(PatientManagerKey.patientID.toString());
  }

 //Save patient name to Cache
  Future<bool> savePatientName(String? patientName) async {
    final box = GetStorage();
    await box.write(PatientManagerKey.patientName.toString(), patientName);
    print("Saved patient name into Cache: PatientManager");
    return true;
  }
  //Get patient name from Cache
  String? getPatientName() {
    print("Retrieved patientID from Cache: PatientManager");
    final box = GetStorage();
    return box.read(PatientManagerKey.patientName.toString());
  }

}

enum PatientManagerKey { patientID, patientName}
