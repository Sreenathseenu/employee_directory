import 'dart:convert';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:moto_365/models/urls.dart';

class ClubProvider with ChangeNotifier {
  List<dynamic> timeline = [];
  List<dynamic> timelineThread = [];
  Map events = {};
  List locations = [];
  bool isLoading = true;
  bool isLoadingTimeline = true;

  bool isModerator = false;
  List requests = [];
  List myEvents = [];
  List requestedEvents = [];
  String requestSend;

  final String _token;

  ClubProvider(this._token);
  Future<void> isRequested(id) async {
    try {
      final response =
          await http.get(Uri.parse("${Url.domain}/club/request-status?id=$id"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      requestSend = json.decode(response.body);
      print("${Url.domain}/club/request-status?id=$id");
      print(response.body);
      //print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> createComment({id, comment}) async {
    try {
      final response = await http.post(
        Uri.parse("${Url.domain}/club/create-comment/?id=$id"),
          body: json.encode({"comment": comment}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token'
          });

      print(response.statusCode);
    } catch (error) {
      print(error);
    }
  }

  Future<void> createSubComment({id, comment}) async {
    try {
      final response = await http.post(
         Uri.parse("${Url.domain}/club/create-sub-comment/?id=$id"),
          body: json.encode({"sub_comment": comment}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token'
          });
      print(response.body);
      print(response.statusCode);
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchSubComment(id) async {
    try {
      final response = await http
          .get(Uri.parse("${Url.domain}/club/sub-comment-list?id=$id"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      //master=json.decode(response.body)['data'];
      //print(response.body);
      //print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchEventWithId(id) async {
    try {
      print("startttt");
      final response =
          await http.get(Uri.parse("${Url.domain}/club/event/list?id=$id"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      print(response.body);
      events = json.decode(response.body)['event'];
      isLoading = false;
      print("${Url.domain}/club/event/list?id=$id");

      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print("errorrr \n : $error");
    }
  }

  Future<void> createEvent(
      {file, title, location, time, date, description, type}) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Url.domain}/club/create-event/'));
      request.headers.addAll({
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      request.files
          .add(await http.MultipartFile.fromPath("cover_image", file.path));
      request.fields["title"] = title;
      request.fields["location"] = location;
      request.fields["time"] = time;
      request.fields["date"] = date;
      request.fields["description"] = description;
      request.fields["event_type"] = type;

      var response = await request.send();
      print('image saved');
      print(response.statusCode);
      var res = await http.Response.fromStream(response);
      final id = json.decode(res.body)['data']['id'];
      FirebaseFirestore.instance.collection('chats/hkbsyyOPuAwAmxTIMxex/$id').add({
        'text': 'welcome',
        'created': Timestamp.now(),
        'user': 0,
        'username': 'moto365'
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchTimeline(location) async {
    // try {
    print(location);
    final response = await http
        .get(Uri.parse("${Url.domain}/club/event/timeline?location=$location"), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    });
    timeline = json.decode(response.body)['club'];
    timelineThread = json.decode(response.body)['forum'];
    isLoadingTimeline = false;
    print("${Url.domain}/club/event/timeline?location=$location");
    print(response.body);
    print(response.statusCode);

    print("timeline");
    notifyListeners();
    /* } catch (error) {
      print(error);
    }*/
  }

  Future<void> fetchLocation() async {
    try {
      final response =
          await http.get(Uri.parse("${Url.domain}/club/event/location-list"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      locations = json.decode(response.body)['data'];
      print("${Url.domain}/club/event/location-list");
      print(response.body);
      print(response.statusCode);
      print('location');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> checkModerator() async {
    try {
      final response =
          await http.get(Uri.parse("${Url.domain}/club/check-moderator"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      print("${Url.domain}/club/check-moderator");
      print(response.body);
      isModerator = json.decode(response.body);
      print(isModerator);
      print(isModerator.runtimeType);

      print(response.statusCode);
      //print('location');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> acceptUser(username) async {
    try {
      final response = await http.get(
         Uri.parse("${Url.domain}/club/accept-moderator"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token'
          });
      // masterWithSub=json.decode(response.body)['data'];
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> sendRequest(id) async {
    try {
      final response =
          await http.get(Uri.parse("${Url.domain}/club/send-request?id=$id"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      // masterWithSub=json.decode(response.body)['data'];
      print(response.body);
      print(response.statusCode);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchEvent() async {
    try {
      final response =
          await http.get(Uri.parse("${Url.domain}/club/show-all-event-request"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });

      // masterWithSub=json.decode(response.body)['data'];
      print('events');
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> acceptRequest(id, username) async {
    try {
      final response = await http.get(
        Uri.parse("${Url.domain}/club/accept-request?id=$id&username=$username"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token'
          });
      // masterWithSub=json.decode(response.body)['data'];
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> denyRequest(id, username) async {
    try {
      final response = await http.get(
        Uri.parse("${Url.domain}/club/deny-request?id=$id&username=$username"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token'
          });
      // masterWithSub=json.decode(response.body)['data'];
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchMyEvents() async {
    try {
      final response = await http.get(Uri.parse("${Url.domain}/club/my-events"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      myEvents = json.decode(response.body)['allowed_events'];
      requestedEvents = json.decode(response.body)['requested_events'];
      print("${Url.domain}/club/my-events");
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> joinEvents(id) async {
    try {
      final response =
          await http.get(Uri.parse("${Url.domain}/club/join-event?id=$id"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      // masterWithSub=json.decode(response.body)['data'];
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteEvents(id) async {
    try {
      final response =
          await http.get(Uri.parse("${Url.domain}/club/delete-event?id=$id"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      // masterWithSub=json.decode(response.body)['data'];
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteComment(id) async {
    try {
      final response =
          await http.get(Uri.parse("${Url.domain}/club/delete-comment?id=$id"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      // masterWithSub=json.decode(response.body)['data'];
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteSubComment(id) async {
    try {
      final response = await http
          .get(Uri.parse("${Url.domain}/club/delete-sub-comment?id=$id"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      //masterWithSub=json.decode(response.body)['data'];
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateComment({id, comment}) async {
    try {
      final response =
          await http.post(Uri.parse("${Url.domain}/club/update-comment?id=$id"), body: {
        "comment": comment
      }, headers: {
        // 'Content-type': 'application/json',
        //'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      // masterWithSub=json.decode(response.body)['data'];
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateSubComment({id, comment}) async {
    try {
      final response = await http.post(
         Uri.parse("${Url.domain}/club/update-sub-comment?id=$id"),
          body: json.encode({"comment": comment}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token'
          });
      // masterWithSub=json.decode(response.body)['data'];
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> getUserrequest() async {
    try {
      final response =
          await http.get(Uri.parse("${Url.domain}/club/show-all-event-request"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      requests = json.decode(response.body)['data'];
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> likeEvents({id, isLiked}) async {
    try {
      final response =
          await http.post(Uri.parse("${Url.domain}/club/like-event?id=$id"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      print(response.statusCode);
    } catch (error) {
      print(error);
    }
  }

  Future<void> unlikeEvents({id, isLiked}) async {
    try {
      final response =
          await http.get(Uri.parse("${Url.domain}/club/unlike-event?id=$id"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateEvent(
      {file, title, location, time, date, description, type, id}) async {
    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('${Url.domain}/club/create-event/$id/'),
      );
      request.headers.addAll({
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      request.fields["title"] = title;
      request.fields["location"] = location;
      request.fields["time"] = time;
      request.fields["date"] = date;
      request.fields["description"] = description;
      request.fields["event_type"] = type;
      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath("cover_image", file.path),
        );
      }

      var response = await request.send();
      /*final response=await http.patch('${Url.domain}/api/v1/forum/update-thread/$id/', headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    },
    body: json.encode({
      "title":title,
      "content":content,
      "video_url":url
    }) );*/
      print('image saved');
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
