class AttendanceModel {
  String name, roleNumber;
  var lecDate, subject, year, div, stream;
  bool isSelected;

  AttendanceModel(this.name, this.roleNumber, this.lecDate, this.subject,
      this.div, this.stream, this.year, this.isSelected);
}
