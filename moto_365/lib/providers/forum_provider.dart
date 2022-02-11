import 'dart:convert';

import 'package:flutter/foundation.dart';
//import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:http/http.dart' as http;
import 'package:moto_365/models/urls.dart';

class ForumProvider with ChangeNotifier {
  ForumProvider(this._token) {
    // fetchTrending();

    fetchThread();
    fetchTags();
    // fetchMaster();
    // fetchMasterWithSub();
  }

  bool isLoadingLatest = false;
  bool isLoadingMasterWithSub = true;
  bool isLoadingThread = false;
  bool isLoadingThreadWithSub = true;
  List latest = [];
  List master = [];
  List masterWithSub = [];
  List query = [];
  List<dynamic> regions = [];
  Map single = {};
  List tags = [
    {"id": 'a', "name": 'Featured'},
    {"id": 'b', "name": 'Latest'}
  ];
  //List<Language> tagsList = [];
  List thread = [];
  List threadWithSub = [];
  List threadSearch = [];

  final String _token;

  void addQuery(q) {
    print(q);
    this.query.clear();
    this.query.add(q);
    notifyListeners();
    fetchThread();
    notifyListeners();
  }

  void addQueryTrending(q) {
    this.query.clear();
    this.query.add(q);
    notifyListeners();
    fetchTrending();
    notifyListeners();
  }

  void addQueryLatest(q) {
    this.query.clear();
    this.query.add(q);
    notifyListeners();
    fetchLatest();
    notifyListeners();
  }

  void removeQuery(q) {
    this.query.remove(q);
    notifyListeners();
    fetchThread();
    notifyListeners();
  }

  Future<void> createSubForum({title, region, master}) async {
    try {
      const url = "${Url.domain}/forum//sub-forum/create/";
      final response = await http.post(Uri.parse(url),
          body: json.encode(
              {"title": title, "region": region, "masterforum": master}),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });

      // print(response.statusCode);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteThread(id) async {
    try {
      final response = await http.post(Uri.parse("${Url.domain}/forum/destroy/$id"),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });

      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchRegion() async {
    try {
      const url = "${Url.domain}/forum/region/list";
      final response = await http.get(Uri.parse(url),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      regions = json.decode(response.body)['data'];
      // print(response.body);
      //print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchMaster() async {
    try {
      const url = "${Url.domain}/forum/master-forum/list";
      final response = await http.get(Uri.parse(url),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      master = json.decode(response.body)['data'];
      //isLoading=false;
      // print(response.body);
      print('master');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchMasterWithSub() async {
    try {
      const url = "${Url.domain}/forum/list";
      final response = await http.get(Uri.parse(url),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      masterWithSub = json.decode(response.body)['data'];
      isLoadingMasterWithSub = false;
      //print(response.body);
      //print(response.statusCode);
      print('master with sub');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchTrending() async {
    try {
      isLoadingThread = true;
      notifyListeners();
      const url = "${Url.domain}/forum/trending";
      final response = await http.get(Uri.parse(url),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      thread = json.decode(response.body)['data'];
      isLoadingThread = false;
      //print(response.body);
      //print(response.statusCode);
      print('thread');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchThread() async {
    isLoadingThread = true;
    //notifyListeners();
    print(query);
    String url = query.isEmpty
        ? "${Url.domain}/forum/thread-list"
        : "${Url.domain}/forum/thread-list?q=$query";
    print(url);
    final response = await http.get(Uri.parse(url),
        headers: _token == null
            ? {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                //'Authorization': 'Bearer $_token'
              }
            : {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                //'Authorization': 'Bearer $_token'
              });
    thread = json.decode(response.body)['data'];
    threadSearch = thread;
    print(response.body);
    //print(response.statusCode);
    print(thread);
    print(response.body);
    isLoadingThread = false;
    notifyListeners();
  }

  Future<void> fetchThreadWithSub(id) async {
    try {
      final response =
          await http.get(Uri.parse("${Url.domain}/forum/subforum-thread-list/$id"),
              headers: _token == null
                  ? {
                      'Content-type': 'application/json',
                      'Accept': 'application/json',
                      //'Authorization': 'Bearer $_token'
                    }
                  : {
                      'Content-type': 'application/json',
                      'Accept': 'application/json',
                      'Authorization': 'Bearer $_token'
                    });
      threadWithSub = json.decode(response.body)['data'];
      isLoadingThreadWithSub = false;
      //print(response.body);
      //print(response.statusCode);
      print('thread with sub');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchLatest() async {
    try {
      isLoadingThread = true;
      notifyListeners();
      final response = await http.get(Uri.parse("${Url.domain}/forum/latest-threads"),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      thread = json.decode(response.body)['data'];

      print(response.body);
      //print(response.statusCode);
      print(thread);
      print(response.body);
      isLoadingThread = false;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchThreadSearch(query) async {
    try {
      isLoadingThread = true;
      notifyListeners();
      final response =
          await http.get(Uri.parse("${Url.domain}/forum/thread-search/?q=$query"),
              headers: _token == null
                  ? {
                      'Content-type': 'application/json',
                      'Accept': 'application/json',
                      //'Authorization': 'Bearer $_token'
                    }
                  : {
                      'Content-type': 'application/json',
                      'Accept': 'application/json',
                      'Authorization': 'Bearer $_token'
                    });
      threadSearch = json.decode(response.body)['data'];

      print(response.body);
      //print(response.statusCode);
      print(thread);
      print(response.body);
      isLoadingThread = false;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> createThread(
      {id, file, title, content, url, tags, urlImg, event}) async {
    try {
      var files = '';
      var urls = '';

      if (file != null) {
        var requestFile = http.MultipartRequest(
          'POST',
          Uri.parse('${Url.domain}/forum/image/'),
        );
        requestFile.headers.addAll(_token == null
            ? {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                //'Authorization': 'Bearer $_token'
              }
            : {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $_token'
              });
        requestFile.files.add(
          await http.MultipartFile.fromPath("image", file.path),
        );
        var responseFile = await requestFile.send();
        var x = json.decode(await responseFile.stream.bytesToString());
        files = x['data']['id'];
      }

      if (urlImg != null) {
        var requestUrl = await http.post(Uri.parse("${Url.domain}/forum/image-url/"),
            body: json.encode({"url": urlImg}),
            headers: _token == null
                ? {
                    'Content-type': 'application/json',
                    'Accept': 'application/json',
                    //'Authorization': 'Bearer $_token'
                  }
                : {
                    'Content-type': 'application/json',
                    'Accept': 'application/json',
                    'Authorization': 'Bearer $_token'
                  });
        var y = json.decode(requestUrl.body);
        urls = y['data']['url'];
      }
      final response = await http.post(Uri.parse("${Url.domain}/forum/thread/create/$id/"),
          body: json.encode({
            "title": title,
            "content": content,
            "video_url": url,
            "tag": tags,
            "header_image": files,
            "header_image_url": urls,
            "event": event
          }),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      print(response.statusCode);
      print(response.body);
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateThread({id, file, title, content, url, event}) async {
    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('${Url.domain}/forum/update-thread/$id/'),
      );
      request.headers.addAll({
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      request.fields["title"] = title;
      request.fields["content"] = content;
      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath("header_image", file.path),
        );
      }
      request.fields["video_url"] = url;
      request.fields["event"] = event;
      var response = await request.send();
      /*final response=await http.patch('${Url.domain}/forum/update-thread/$id/', headers: {
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
    } catch (error) {
      print(error);
    }
  }

  Future<void> createComment({id, content}) async {
    try {
      final response = await http.post(Uri.parse("${Url.domain}/forum/comment/$id/"),
          body: json.encode({"content": content}),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      print(response.statusCode);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteComment({id}) async {
    try {
      final response =
          await http.post(Uri.parse("${Url.domain}/forum/delete/$id/"), headers: {
        //'Content-type': 'application/json',
        //'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      print(response.body);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteReplyComment({id}) async {
    try {
      final response = await http.post(Uri.parse("${Url.domain}/forum/remove/$id/"),
          headers: _token == null
              ? {
                  //'Content-type': 'application/json',
                  //'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  //'Content-type': 'application/json',
                  //'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      print(response.body);
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateComment({id, content}) async {
    try {
      final response = await http.post(Uri.parse("${Url.domain}/forum/comment-edit/$id/"),
          body: {"content": content},
          headers: _token == null
              ? {
                  //'Content-type': 'application/json',
                  //'Accept': 'application/json',

                  //'Authorization': 'Bearer $_token'
                }
              : {
                  //'Content-type': 'application/json',
                  //'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      print(response.body);
    } catch (error) {
      print(error);
    }
  }

  Future<void> replyComment({id, content}) async {
    try {
      final response = await http.post(Uri.parse("${Url.domain}/forum/reply/$id/"),
          body: json.encode({"content": content}),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      print(response.body);
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateReplyComment({id, content}) async {
    try {
      final response = await http.post(Uri.parse("${Url.domain}/forum/reply-edit/$id/"),
          body: {"content": content},
          headers: _token == null
              ? {
                  //'Content-type': 'application/json',
                  //'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  //'Content-type': 'application/json',
                  //'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      print(response.body);
    } catch (error) {
      print(error);
    }
  }

  Future<void> likeThread({id}) async {
    try {
      final response = await http.post(Uri.parse("${Url.domain}/forum/like-thread/$id/"),
          // body: json.encode({"liked": isLiked}),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      print(response.statusCode);
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateLike({id, isLiked}) async {
    try {
      final response =
          await http.post(Uri.parse("${Url.domain}/forum/update-thread-like/$id/"),
              body: json.encode({"liked": isLiked}),
              headers: _token == null
                  ? {
                      'Content-type': 'application/json',
                      'Accept': 'application/json',
                      //'Authorization': 'Bearer $_token'
                    }
                  : {
                      'Content-type': 'application/json',
                      'Accept': 'application/json',
                      'Authorization': 'Bearer $_token'
                    });
      print(response.statusCode);
    } catch (error) {
      print(error);
    }
  }

  Future<void> likeComment({id}) async {
    try {
      final response = await http.post(Uri.parse("${Url.domain}/forum/comment-like/$id/"),
          //body: json.encode({"liked": isLiked}),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      print(response.statusCode);
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchSingleThread(id) async {
    try {
      final response = await http.get(Uri.parse("${Url.domain}/forum/thread-single/$id"),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                });
      single = json.decode(response.body)['data'];
      //isLoading=false;
      // print(response.body);
      //print(response.statusCode);
      print('single thread');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchTags() async {
    try {
      isLoadingLatest = true;
      notifyListeners();
      final response = await http.get(Uri.parse("${Url.domain}/forum/tags/"),
          headers: _token == null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  //'Authorization': 'Bearer $_token'
                });
      tags = tags + json.decode(response.body)['data'];
      // for (int i = 0; i < tags.length; i++) {
      //   tagsList.add(Language(
      //       name: tags[i]['name'], position: i + 1, id: tags[i]['id']));
      // }
      //isLoading=false;
      // print(response.body);
      //print(response.statusCode);
      print('tags : $tags');
      isLoadingLatest = false;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

//   Future<List<Language>> getLanguages(String query) async {
//     await Future.delayed(Duration(milliseconds: 500), null);

//     return tagsList
//         .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }
// }

// class Language extends Taggable {
//   /// Creates Language
//   Language({
//     this.name,
//     this.position,
//     this.id,
//   });

//   final String id;

//   ///
//   final String name;

//   ///
//   final int position;

//   @override
//   List<Object> get props => [name];

//   /// Converts the class to json string.
//   String toJson() => '''  {
//     "name": $name,\n
//     "position": $position\n
//     "id": $id\n
//   }''';
}
