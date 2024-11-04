class HomeModels {
  bool? success;
  String? message;
  Data? data;

  HomeModels({this.success, this.message, this.data});

  HomeModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Sessions>? sessions;
  List<Courses>? courses;

  Data({this.sessions, this.courses});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(Sessions.fromJson(v));
      });
    }
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
  }
}

class Sessions {
  String? id;
  String? title;
  String? level;
  String? bookingStartFrom;
  String? sessionTopics;
  String? slug;
  String? startAt;
  String? sessionDate;
  Instructor? instructor;

  Sessions(
      {this.id,
      this.title,
      this.level,
      this.bookingStartFrom,
      this.sessionTopics,
      this.slug,
      this.startAt,
      this.sessionDate,
      this.instructor});

  Sessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    level = json['level'];
    bookingStartFrom = json['booking_start_from'];
    sessionTopics = json['session_topics'];
    slug = json['slug'];
    startAt = json['start_at'];
    sessionDate = json['session_date'];
    instructor = json['instructor'] != null
        ? Instructor.fromJson(json['instructor'])
        : null;
  }
}

class Instructor {
  String? professionalRank;
  String? experience;
  int? sessionPrice;
  User? user;

  Instructor(
      {this.professionalRank, this.experience, this.sessionPrice, this.user});

  Instructor.fromJson(Map<String, dynamic> json) {
    professionalRank = json['professional_rank'];
    experience = json['experience'];
    sessionPrice = json['session_price'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  String? id;
  String? fullName;

  User({this.id, this.fullName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
  }
}

class Courses {
  String? id;
  String? title;
  String? slug;
  String? language;
  String? lessonTopics;
  String? level;
  Null? rating;
  Instructor? instructor;

  Courses(
      {this.id,
      this.title,
      this.slug,
      this.language,
      this.lessonTopics,
      this.level,
      this.rating,
      this.instructor});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    language = json['language'];
    lessonTopics = json['lesson_topics'];
    level = json['level'];
    rating = json['rating'];
    instructor = json['instructor'] != null
        ? Instructor.fromJson(json['instructor'])
        : null;
  }
}

class SessionInstructor {
  int? sessionPrice;
  User? user;

  SessionInstructor({this.sessionPrice, this.user});

  SessionInstructor.fromJson(Map<String, dynamic> json) {
    sessionPrice = json['session_price'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class SessionUser {
  String? fullName;
  String? email;
  String? id;

  SessionUser({this.fullName, this.email, this.id});

  SessionUser.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    id = json['id'];
  }
}
