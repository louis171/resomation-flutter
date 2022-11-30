class DeceasedData {
  final String dId;
  final String dTitle;
  final String dForenames;
  final String dSurname;
  final String dCommitalDate;
  final String dCommitalLocation;

  DeceasedData(this.dId, this.dTitle, this.dForenames, this.dSurname,
      this.dCommitalDate, this.dCommitalLocation);

  DeceasedData.fromJson(Map<String, dynamic> json)
      : dId = json['dId'],
        dTitle = json['dTitle'],
        dForenames = json['dForenames'],
        dSurname = json['dSurname'],
        dCommitalDate = json['dCommitalDate'],
        dCommitalLocation = json['dCommitalLocation'];

  Map<String, dynamic> toJson() => {
        'dId': dId,
        'dTitle': dTitle,
        'dForenames': dForenames,
        'dSurname': dSurname,
        'dCommitalDate': dCommitalDate,
        'dCommitalLocation': dCommitalLocation,
      };
}
