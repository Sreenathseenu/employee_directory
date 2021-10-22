import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/screens/auth/insurance.dart';
import 'package:moto_365/screens/auth/upload_instructions.dart';
import 'package:moto_365/screens/auth/vehicle_add.dart';

class JsonUpload extends StatefulWidget {
  final Map routeArgs;
  final String mode;
  JsonUpload(this.routeArgs, this.mode);
  @override
  _JsonUploadState createState() => _JsonUploadState();
}

class _JsonUploadState extends State<JsonUpload> {
  File file;
  File insureFile;
  File licenseFile;
  Map rcDocs;
  Map licenseDocs;
  Map insureDocs;
  bool _isImageSelected = false;
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        body: ListView(
            children: [
              
              Center(
                child: Text(
                  'UPLOAD DOCS FROM DIGILOCKER',
                  style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                color: Colors.white,
                height: 16,
                fontWeight: FontWeight.w600),
                ),
              ),
              
              Container(
                  
                  decoration: BoxDecoration(shape: BoxShape.circle,
                  color: Colors.white12
                  ),
                  height: 240,
                  child: Center(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload_outlined,color: Colors.white,size: 100,),
                        /*Text('UPLOAD DOCS',style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12,
        color: Theme.of(context).primaryColor,
        height: 12,
        fontWeight: FontWeight.w600),)*/
                      ],
                    )
                  )),
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: GestureDetector(
                    //color: Theme.of(context).primaryColor,
                    onTap: () async {
                      print('object');
                      showModalBottomSheet(context:context, builder: (context){
                        return Container(
                          child: ListView(
                            children: [
                              Container(
                                margin:EdgeInsets.all(16) ,
                                padding: EdgeInsets.all(8),
                                decoration:BoxDecoration(
                                  color:Colors.white12,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: ListTile(
                                  onTap: ()async{
                                    //file = await ImagePicker.pickImage(source: ImageSource.gallery );
                                    Navigator.of(context).pop();
                     file = await FilePicker.getFile(
        allowedExtensions: ['json', 'JSON'],
        type: FileType.custom);

                      print(file);
                      //print(json.decode(file));
                      setState(() {
                        _isImageSelected = true;
                      });
                      String jsonString = await file.readAsString();

                      var jsonQuestions = json.decode(jsonString);
                      rcDocs = jsonQuestions;
                      //print(jsonQuestions);*/
                                  },
                                  leading:rcDocs==null? Icon(Icons.cloud_upload_outlined,):Icon(Icons.check_circle_outline,color:Colors.green),
                                  title: Text(
                        
                        rcDocs==null?'UPLOAD RC':'CHANGE RC',
                        style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12,
        color: Theme.of(context).primaryColor,
        height: 12,
        fontWeight: FontWeight.w600),
                      ),
                                ),
                              ),Container(
                                margin:EdgeInsets.all(16) ,
                                padding: EdgeInsets.all(8),
                                decoration:BoxDecoration(
                                  color:Colors.white12,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: ListTile(
                                  onTap: ()async{
                                  Navigator.of(context).pop();  //file = await ImagePicker.pickImage(source: ImageSource.gallery );
                     licenseFile = await FilePicker.getFile(
        allowedExtensions: ['json', 'JSON'],
        type: FileType.custom);

                      print(licenseFile);
                      //print(json.decode(file));
                      setState(() {
                        _isImageSelected = true;
                      });
                      String jsonString = await licenseFile.readAsString();

                      var jsonQuestions = json.decode(jsonString);
                      licenseDocs = jsonQuestions;
                      //print(jsonQuestions);*/
                                  },
                                  leading:licenseDocs==null? Icon(Icons.cloud_upload_outlined,):Icon(Icons.check_circle_outline,color:Colors.green),
                                  title: Text(
                        
                       licenseDocs==null? 'UPLOAD LICENSE':'CHANGE LICENSE',
                        style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12,
        color: Theme.of(context).primaryColor,
        height: 12,
        fontWeight: FontWeight.w600),
                      ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                      //file = await ImagePicker.pickImage(source: ImageSource.gallery );
                     /* file = await FilePicker.getFile(
        allowedExtensions: ['json', 'JSON'],
        type: FileType.custom);

                      print(file);
                      //print(json.decode(file));
                      setState(() {
                        _isImageSelected = true;
                      });
                      String jsonString = await file.readAsString();

                      var jsonQuestions = json.decode(jsonString);
                      rcDocs = jsonQuestions;
                      //print(jsonQuestions);*/
                    },
                    child: Container(
                      child: Text(
                        
                        rcDocs==null?'UPLOAD DOCS':'CHANGE',
                        style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14,
        color: Theme.of(context).primaryColor,
        height: 12,
        fontWeight: FontWeight.w600),
                      ),
                    ),
                    ),
                  ),
                 
                ],
              ),
              
               FlatButton(
                 onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Instructions()));
                 },
                    child: Center(
                child: Text('Click here for instructions',
                  style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12,
        color: Colors.white70,
        height: 12,
        fontWeight: FontWeight.w600)),
                  ),
               ),
                  
                  
            ],
          ),
        floatingActionButton: FloatingActionButton(
          //backgroundColor: Colors.transparent,
          onPressed:() {
                            if(rcDocs!=null){
                            if(json.decode(rcDocs['payload'])['Certificate']['type']=='RVCER'){
                                                     widget.mode=='insure'?Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Insurance1(rcDocs))):

                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => VehicleAdd(
                                          insureDocs:insureDocs,
                                          licenseDocs:licenseDocs,
                                          routeArgs: widget.routeArgs,
                                          rcDocs: rcDocs,
                                          mode: widget.mode,
                                        )));}else{
                                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: Text('Invalid Document'),
                                    content: Text('It seems the document you uploade is not an RC Document of your vehicle'),
                                   
                                  ));
                                        }}else{
                                         widget.mode=='insure'?Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Insurance1(rcDocs))):  Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => VehicleAdd(
                                      
                                          routeArgs: widget.routeArgs,
                                          rcDocs: rcDocs,
                                          mode: widget.mode,
                                        )));
                                        }
         } ,
         child: Icon(Icons.arrow_forward,color: Colors.white,)
         ),
      ),
    );
  }
}
