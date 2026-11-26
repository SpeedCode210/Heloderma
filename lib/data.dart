// Data shared between several screens (folders, treatments, summary).
// It is hardcoded for now; later it can come from a database.

class FolderInfo {
  String name;
  DateTime startTime;
  int visits;
  int documents;
  int treatments;
  String iconName;

  FolderInfo({
    required this.name,
    required this.startTime,
    required this.visits,
    required this.documents,
    required this.treatments,
    required this.iconName,
  });
}

class TreatmentInfo {
  String name;
  String details;
  List<String> days;

  TreatmentInfo({
    required this.name,
    required this.details,
    required this.days,
  });
}

final List<FolderInfo> allFolders = [
  FolderInfo(
    name: 'Hypertension',
    startTime: DateTime(2019),
    visits: 4,
    documents: 9,
    treatments: 1,
    iconName: 'assets/conditions/heart.svg',
  ),
  FolderInfo(
    name: 'Type 2 diabetes',
    startTime: DateTime(2021),
    visits: 6,
    documents: 14,
    treatments: 2,
    iconName: 'assets/conditions/drop-blue.svg',
  ),
];

final List<TreatmentInfo> hypertensionTreatments = [
  TreatmentInfo(
    name: 'Amlodipine',
    details: '5 mg · once a day · 1:00 PM',
    days: ['taken', 'taken', 'taken', 'missed', 'taken', 'taken', 'pending'],
  ),
];

final List<TreatmentInfo> diabetesTreatments = [
  TreatmentInfo(
    name: 'Metformin',
    details: '850 mg · twice a day · 8 AM, 8 PM',
    days: ['taken', 'taken', 'taken', 'taken', 'taken', 'missed', 'pending'],
  ),
  TreatmentInfo(
    name: 'Atorvastatin',
    details: '20 mg · once a day · 10:00 PM',
    days: ['taken', 'taken', 'missed', 'taken', 'taken', 'taken', 'pending'],
  ),
];

// Every medication of the user, all conditions together.
List<TreatmentInfo> get allTreatments => [
  ...hypertensionTreatments,
  ...diabetesTreatments,
];
