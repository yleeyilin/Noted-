class CourseData {
  String? courseCode;
  String? course;

  CourseData({this.courseCode, this.course});

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      courseCode: json['courseCode'],
      course: json['course'],
    );
  }
}
