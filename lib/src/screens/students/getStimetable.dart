import 'package:virtual_edu/src/screens/faculty/ftimetabledata.dart';
import 'package:virtual_edu/src/screens/students/sTimetabledata.dart';

class GetStimetable {
  List<StimetableData> getSTimetabledata() {
    return [
      StimetableData(
        subject: "Operating System",
        facultyName: 'Hitesh Parmar',
        lecDate: "27-6-2022",
        lecSTime: "10:00 am",
        lecETime: "11:00 am",
        stream: "Msc",
        year: "3",
        div: "A",
      ),
      StimetableData(
        subject: "ADBMS",
        lecDate: "27-6-2022",
        facultyName: 'Krupali Busa',
        lecSTime: "11:00 am",
        lecETime: "12:00 am",
        stream: "Msc",
        year: "3",
        div: "A",
      ),
      StimetableData(
        subject: "AI",
        lecDate: "28-6-2022",
        facultyName: 'Nandita Goswami',
        lecSTime: "10:00 am",
        lecETime: "11:00 am",
        stream: "Msc",
        year: "3",
        div: "A",
      ),
      StimetableData(
        subject: "Machine Learning",
        lecDate: "28-7-2022",
        facultyName: 'Hitesh Parmar',
        lecSTime: "11:00 am",
        lecETime: "12:00 am",
        stream: "Msc",
        year: "3",
        div: "A",
      ),
      StimetableData(
        subject: "Data Structure",
        lecDate: "29-6-2022",
        facultyName: 'Nandita Goswami',
        lecSTime: "10:00 am",
        lecETime: "11:00 am",
        stream: "Msc",
        year: "3",
        div: "A",
      ),
      StimetableData(
        subject: "Software Engineering",
        lecDate: "29-6-2022",
        facultyName: 'Kalyani Patel',
        lecSTime: "11:00 am",
        lecETime: "12:00 am",
        stream: "Msc",
        year: "3",
        div: "A",
      ),
    ];
  }
}
