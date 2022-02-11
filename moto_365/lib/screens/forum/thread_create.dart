// import 'dart:io';
// //import 'package:flutter_tagging/flutter_tagging.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_tagging/flutter_tagging.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:moto_365/components/button.dart';
// import 'package:moto_365/components/gard.dart';
// import 'package:moto_365/providers/club_provider.dart';
// import 'package:moto_365/providers/forum_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:html_editor/html_editor.dart';

// class ThreadAdd extends StatefulWidget {
//   final bool mode;
//   final Map item;
//   ThreadAdd(this.id, this.mode, this.item);
//   static const routeName = '/thread_add';
//   final String id;

//   @override
//   _ThreadAddState createState() => _ThreadAddState();
// }

// class _ThreadAddState extends State<ThreadAdd> {
//   List<Language> _selectedLanguage = [];
//   List tags = [];

//   bool _isLoading = true;
//   bool isEvent=false;
//   bool isInit = true;
//   TextEditingController titleController = TextEditingController();
//   TextEditingController contentController = TextEditingController();
//   TextEditingController urlController = TextEditingController();
//   File file;
//   String imgUrl;
//   int selectedValue;
//   List all = [];
//   bool _isImageSelected = false;

//   final _form = GlobalKey<FormState>();
//   GlobalKey<HtmlEditorState> keyEditor = GlobalKey();

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (isInit) {
//       if (widget.mode) {
//         /* var fileImages =
//             widget.item['images'].map((item) => item['image']).toList();
//         var urlImages =
//             widget.item['images_url'].map((item) => item['url']).toList();
//         all = fileImages + urlImages;*/
//       }

//       Provider.of<ForumProvider>(context)
//           .fetchTags()
//           .then((value) => _isLoading = false);
//       Provider.of<ClubProvider>(context).fetchTimeline('kochi');

          
//     }
//     isInit = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final data = Provider.of<ForumProvider>(context);
//     final eventData = Provider.of<ClubProvider>(context);
//     if (widget.mode) {
//       titleController.text = widget.item['title'];
//       contentController.text = widget.item['content'];
//       urlController.text = widget.item['video_url'];
//     }

//     List<DropdownMenuItem> items = eventData.timeline
//         .map((e) => DropdownMenuItem(
//               child: Text("${e['title']}"),
//               value: e['id'],
//             ))
//         .toList();

//     return Grad(
//       child: Scaffold(
//         // backgroundColor: Colors.grey[900],
//         appBar: AppBar(
//             title: Text(widget.mode ? 'UPDATE' : 'Create',
//                 style: const TextStyle(
//                     color: const Color(0xffffffff),
//                     fontWeight: FontWeight.w600,
//                     fontFamily: "Montserrat",
//                     fontStyle: FontStyle.normal,
//                     fontSize: 24.0))),
//         body: _isLoading
//             ? Center(
//                 child: SpinKitSpinningLines(
//   color: Colors.deepOrange,
//   size: 50.0,
// ),
//               )
//             : Form(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: ListView(
//                     children: <Widget>[
//                       Text("Give a short thread title",
//                           style: const TextStyle(
//                               color: const Color(0xdeffffff),
//                               fontWeight: FontWeight.w600,
//                               fontFamily: "Montserrat",
//                               fontStyle: FontStyle.normal,
//                               fontSize: 14.0)),
//                       SizedBox(height: 10),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           fillColor:
//                               Theme.of(context).dialogTheme.backgroundColor,
//                           filled: true,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide(
//                                 width: 0.1,
//                                 color: Theme.of(context).backgroundColor),
//                           ),
//                           hintText: 'add title',
//                           hintStyle: TextStyle(fontSize: 12),

//                           /* prefix: DropdownButton(items:[ DropdownMenuItem(child: Text('+91'), value: '+91' ,), DropdownMenuItem(child: Text('+98'), value: '+98' ,)], onChanged:(value){
//                                       setState(() {
//                                         code = value;
//                                       });
//                                     } , value: code,),*/

//                           /*prefixIcon: Icon(Icons.phone,
//                                         size: 18, color: Colors.deepOrangeAccent)*/
//                         ),
//                         //initialValue: widget.mode?widget.item['title']:'',
//                         controller: titleController,
//                         validator: (value) {
//                           if (value.isEmpty) {
//                             return 'field should not be empty';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       Text("Upload header image",
//                           style: TextStyle(
//                             fontFamily: 'Montserrat',
//                             color: Color(0xddffffff),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             fontStyle: FontStyle.normal,
//                           )),
//                       SizedBox(height: 10),
//                       Container(
//                           height: 120,
//                           padding: EdgeInsets.only(left: 16),
//                           child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: 1,
//                               itemBuilder: (context, index) {
//                                 if (index == all.length) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       showModalBottomSheet(
//                                           context: context,
//                                           builder: (context) {
//                                             return Container(
//                                                 padding: EdgeInsets.all(16),
//                                                 child: Column(
//                                                   children: <Widget>[
//                                                     FlatButton(
//                                                         onPressed: () async {
//                                                           file = await FilePicker
//                                                               .getFile(
//                                                                   allowedExtensions: [
//                                                                 'jpg',
//                                                                 'png',
//                                                                 'jpeg'
//                                                               ],
//                                                                   type: FileType
//                                                                       .custom);

//                                                           print(file.path);
//                                                           setState(() {
//                                                             all.add(file);
//                                                             //file.add(file1);
//                                                             _isImageSelected =
//                                                                 true;
//                                                           });
//                                                           Navigator.of(context)
//                                                               .pop();
//                                                         },
//                                                         child: Text(
//                                                             'add from gallery')),
//                                                     FlatButton(
//                                                         onPressed: () {
//                                                           Navigator.of(context)
//                                                               .pop();
//                                                           showModalBottomSheet(
//                                                               enableDrag: true,
//                                                               context: context,
//                                                               builder:
//                                                                   (context) {
//                                                                 return Container(
//                                                                   margin: EdgeInsets.only(
//                                                                       bottom: MediaQuery.of(
//                                                                               context)
//                                                                           .padding
//                                                                           .bottom),
//                                                                   padding:
//                                                                       EdgeInsets
//                                                                           .all(
//                                                                               16),
//                                                                   child:
//                                                                       TextField(
//                                                                     onSubmitted:
//                                                                         (value) {
//                                                                       imgUrl =
//                                                                           value;
//                                                                       setState(
//                                                                           () {
//                                                                         all.add(
//                                                                             value);
//                                                                       });
//                                                                       Navigator.of(
//                                                                               context)
//                                                                           .pop();
//                                                                     },
//                                                                   ),
//                                                                 );
//                                                               });
//                                                         },
//                                                         child: Text('add url'))
//                                                   ],
//                                                 ));
//                                           });
//                                     },
//                                     child: Container(
//                                       margin:
//                                           EdgeInsets.symmetric(horizontal: 8),
//                                       color: Colors.grey[800],
//                                       height: 100,
//                                       width: 100,
//                                       child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           child:
//                                               Center(child: Icon(Icons.add))),
//                                     ),
//                                   );
//                                 } else {
//                                   return Container(
//                                     margin: EdgeInsets.symmetric(horizontal: 8),
//                                     color: Colors.grey[800],
//                                     height: 100,
//                                     width: 100,
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(8),
//                                       child: Image(
//                                         image: all[index] is String
//                                             ? NetworkImage(all[index])
//                                             : FileImage(all[index]),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               })),

//                       //SizedBox(height: 10),

//                       SizedBox(height: 20),
//                       HtmlEditor(
//                         height: 500,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).dialogTheme.backgroundColor,
//                         ),
//                         hint: "Your text here...",
//                         useBottomSheet: false,

//                         //showBottomToolbar: false,
//                         //value: "text content initial, if any",
//                         key: keyEditor,
//                         // height: 400,
//                       ),
//                       SizedBox(height: 20),
//                       FlutterTagging<Language>(
//                           initialItems: _selectedLanguage,
//                           textFieldConfiguration: TextFieldConfiguration(
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               filled: true,
//                               fillColor:
//                                   Theme.of(context).dialogTheme.backgroundColor,
//                               hintText: 'Search Tags',
//                               labelText: 'Select Tags',
//                             ),
//                           ),
//                           findSuggestions: data.getLanguages,
//                           additionCallback: (value) {
//                             return Language(
//                               name: value,
//                               position: 0,
//                             );
//                           },
//                           onAdded: (language) {
//                             return;
//                           },
//                           configureSuggestion: (lang) {
//                             return SuggestionConfiguration(
//                               title: Text(lang.name),
//                               // subtitle: Text(lang.position.toString()),
//                               additionWidget: Chip(
//                                 label: Text(''),
//                                 backgroundColor: Colors.transparent,
//                               ),
//                             );
//                           },
//                           configureChip: (lang) {
//                             return ChipConfiguration(
//                               label: Text(lang.name),
//                               backgroundColor: Colors.deepOrange,
//                               labelStyle: TextStyle(color: Colors.white),
//                               deleteIconColor: Colors.white,
//                             );
//                           },
//                           onChanged: () {
//                             print(_selectedLanguage);
//                             tags.clear();
//                             for (int i = 0; i < _selectedLanguage.length; i++) {
//                               tags.add(_selectedLanguage[i].id);
//                             }
//                             print(tags);
//                             if(tags.contains('fb673383-c2a1-4a5f-b91d-00f58f9fe225')){
//                               print('yess');
//             setState(() {
//               isEvent=true;
//             });
//           }else{
//             print("noooo");
//           }
//                           }),
//                           SizedBox(height:20),
//                         isEvent?Container(
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context)
//                                     .dialogTheme
//                                     .backgroundColor,
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Theme.of(context)
//                                       .dialogTheme
//                                       .backgroundColor,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               margin: EdgeInsets.symmetric(
//                                   horizontal: 16, vertical: 4),
//                               padding: EdgeInsets.symmetric(horizontal: 16),
//                               child: DropdownButton(
//                                   hint: Text('event'),
//                                   value: selectedValue,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       selectedValue = value;
                                      
//                                     });
//                                   },
//                                   underline: Container(
//                                     height: 0.0,
//                                   ),
//                                   items: items),
//                             ):Container(height:0),
//                             SizedBox(height:20),


//                       Text('Add a video url',
//                           style: TextStyle(
//                               fontFamily: 'Montserrat',
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white)),
//                       SizedBox(height: 10),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           fillColor:
//                               Theme.of(context).dialogTheme.backgroundColor,
//                           filled: true,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide(
//                                 width: 0.1,
//                                 color: Theme.of(context).backgroundColor),
//                           ),
//                           hintText: 'add url',
//                           hintStyle: TextStyle(fontSize: 12),

//                           /* prefix: DropdownButton(items:[ DropdownMenuItem(child: Text('+91'), value: '+91' ,), DropdownMenuItem(child: Text('+98'), value: '+98' ,)], onChanged:(value){
//                                       setState(() {
//                                         code = value;
//                                       });
//                                     } , value: code,),*/

//                           /*prefixIcon: Icon(Icons.phone,
//                                         size: 18, color: Colors.deepOrangeAccent)*/
//                         ),
//                         //initialValue: widget.mode?widget.item['video_url']:'',
//                         controller: urlController,
//                         /* validator: (value) {
//                     if (!value.contains('http')||!value.contains('www')) {
//                       return 'enter a valid url';
//                     }
//                     return null;
//                   },*/
//                       ),
//                       SizedBox(height: 20),
//                       Container(
//                         width: 90,
//                         child: Button(
//                           onPress: () async {
//                             final txt = await keyEditor.currentState.getText();
//                             /* var isValid = _form.currentState.validate();
//                       if(file.path.endsWith('.jpeg')){
//                                       isValid=false;
//                                     }
//                               if (!isValid) {
//                                 return;
//                               }*/
//                             widget.mode
//                                 ? Provider.of<ForumProvider>(context,
//                                         listen: false)
//                                     .updateThread(
//                                         content: contentController.text,
//                                         file: file,
//                                         id: widget.id,
//                                         url: urlController.text,
//                                         title: titleController.text,
//                                         event: selectedValue)
//                                     .then((_) => Navigator.of(context).pop())
//                                 : Provider.of<ForumProvider>(context,
//                                         listen: false)
//                                     .createThread(
//                                         content: txt,
//                                         file: file,
//                                         id: widget.id,
//                                         url: urlController.text,
//                                         title: titleController.text,
//                                         urlImg: imgUrl,
//                                         tags: tags,
//                                         event: selectedValue)
//                                     .then((_) => Navigator.of(context).pop());
//                             setState(() {
//                               _isLoading = true;
//                             });

//                             print(txt);
//                           },
//                           text: widget.mode ? 'UPDATE' : 'CREATE',
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
