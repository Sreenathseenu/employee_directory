import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:moto_365/providers/forum_provider.dart';
import 'package:provider/provider.dart';

class ClubCreate extends StatefulWidget {
  final bool mode;
  final Map item;
  ClubCreate({ this.mode, this.item}) ;

  @override
  _ClubCreateState createState() => _ClubCreateState();
}

class _ClubCreateState extends State<ClubCreate> {
  bool _isLoading=false;
  TextEditingController titleController = TextEditingController();
 
  TextEditingController locationController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  File file;
  bool _isImageSelected = false;
  DateTime _selectedDate;

  final _form = GlobalKey<FormState>();
   void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime(2070),) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final data=Provider.of<ClubProvider>(context);
    if(widget.mode){
      titleController.text=widget.item['title'];
      dateController.text=widget.item['date'];
      locationController.text=widget.item['location'];
      discriptionController.text=widget.item['description'];
      timeController.text=widget.item['time'];
    }
    return Grad(
          child: Scaffold(
        //backgroundColor: Colors.grey[900],
        appBar: AppBar(title: Text('Create')),
        body: _isLoading?Center(child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
),): Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Text('Give event title',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).dialogTheme.backgroundColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 0.1, color: Theme.of(context).backgroundColor),
                    ),
                    hintText: 'add title',
                    hintStyle: TextStyle(fontSize: 12),

                    /* prefix: DropdownButton(items:[ DropdownMenuItem(child: Text('+91'), value: '+91' ,), DropdownMenuItem(child: Text('+98'), value: '+98' ,)], onChanged:(value){
                                      setState(() {
                                        code = value;
                                      });
                                    } , value: code,),*/

                    /*prefixIcon: Icon(Icons.phone,
                                        size: 18, color: Colors.deepOrangeAccent)*/
                  ),
                  controller: titleController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'field should not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Upload image',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                                          child: Image(
                          image: _isImageSelected
                              ? FileImage(file)
                              : widget.mode?NetworkImage(widget.item['cover_image']):AssetImage(
                                  'assets/images/slice.png',
                                ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: FlatButton(
                    onPressed: () async{
                       file = (await FilePicker.platform.pickFiles(
               allowedExtensions:  ['jpg', 'png','jpeg'],
               type: FileType.custom
             )) as File;
             
            print(file.path);
            setState(() {
                _isImageSelected=true;
            });
           
                    },
                    child: Text(widget.mode?'CHANGE IMAGE': _isImageSelected ? 'CHANGE IMAGE' : 'ADD IMAGE', style: TextStyle(
      fontFamily: 'Montserrat',
      color: Color(0xfff05c2d),
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.75,
      
      )),
                  ),
                ),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).dialogTheme.backgroundColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 0.1, color: Theme.of(context).backgroundColor),
                    ),
                    hintText: 'add content',
                    hintStyle: TextStyle(fontSize: 12),

                    /* prefix: DropdownButton(items:[ DropdownMenuItem(child: Text('+91'), value: '+91' ,), DropdownMenuItem(child: Text('+98'), value: '+98' ,)], onChanged:(value){
                                      setState(() {
                                        code = value;
                                      });
                                    } , value: code,),*/

                    /*prefixIcon: Icon(Icons.phone,
                                        size: 18, color: Colors.deepOrangeAccent)*/
                  ),
                  controller: discriptionController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'field should not be empty';
                    }
                    return null;
                  },
                ),
                 SizedBox(height: 20),
                Text('Location',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).dialogTheme.backgroundColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 0.1, color: Theme.of(context).backgroundColor),
                    ),
                    hintText: 'add location',
                    hintStyle: TextStyle(fontSize: 12),

                    /* prefix: DropdownButton(items:[ DropdownMenuItem(child: Text('+91'), value: '+91' ,), DropdownMenuItem(child: Text('+98'), value: '+98' ,)], onChanged:(value){
                                      setState(() {
                                        code = value;
                                      });
                                    } , value: code,),*/

                    /*prefixIcon: Icon(Icons.phone,
                                        size: 18, color: Colors.deepOrangeAccent)*/
                  ),
                  controller: locationController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'field should not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text('time',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).dialogTheme.backgroundColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 0.1, color: Theme.of(context).backgroundColor),
                    ),
                    hintText: 'hh:mm:ss',
                    hintStyle: TextStyle(fontSize: 12),

                    /* prefix: DropdownButton(items:[ DropdownMenuItem(child: Text('+91'), value: '+91' ,), DropdownMenuItem(child: Text('+98'), value: '+98' ,)], onChanged:(value){
                                      setState(() {
                                        code = value;
                                      });
                                    } , value: code,),*/

                    /*prefixIcon: Icon(Icons.phone,
                                        size: 18, color: Colors.deepOrangeAccent)*/
                  ),
                  controller: timeController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'field should not be empty';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),
                Text('date',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                SizedBox(height: 10),
                Column(
        children: <Widget>[
          RaisedButton(child: Text('Add Date'), onPressed: _pickDateDialog),
          SizedBox(height: 20),
          Text(_selectedDate == null //ternary expression to check if date is null
              ? widget.mode? widget.item['date']:'No date chosen!'
              : 'Picked Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
        ],
      ),
                SizedBox(height: 20),
                
                Button(
                  onPress: () {
                    widget.mode?Provider.of<ClubProvider>(context, listen: false)
                        .updateEvent(
                            date: DateFormat('yyyy-MM-dd').format(_selectedDate),
                            description: discriptionController.text,
                            file: file,
                            location: locationController.text,
                            time: timeController.text,
                            title: titleController.text,
                            type: 'open'
                            )
                        .then((_) { 
                          data.fetchLocation().then((_) => Navigator.of(context).pop())
                          ;})
                    :Provider.of<ClubProvider>(context, listen: false)
                        .createEvent(
                            date: DateFormat('yyyy-MM-dd').format(_selectedDate),
                            description: discriptionController.text,
                            file: file,
                            location: locationController.text,
                            time: timeController.text,
                            title: titleController.text,
                            type: 'open'
                            )
                        .then((_) { 
                          data.fetchLocation().then((_) => Navigator.of(context).pop())
                          ;});
                        setState(() {
                           _isLoading=true;
                        });
                       
                  },
                  text:widget.mode?'UPDATE': 'CREATE',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
