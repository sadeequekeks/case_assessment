import 'package:case_assessment/core/service/service_export.dart';

class Serviceinjector {
  FirebaseService firebaseService = FirebaseService();
  AssessmentService authService = AssessmentService();
  UtilityService utilityService = UtilityService();
  DialogService dialogService = DialogService();
}

Serviceinjector si = Serviceinjector();
