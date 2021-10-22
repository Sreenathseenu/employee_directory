import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/gard.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HistoryDetails extends StatefulWidget {
  final data;
  const HistoryDetails({Key key, this.data}) : super(key: key);

  @override
  _HistoryDetailsState createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var i = 0; i < widget.data["services"].length; i++) {
      total = total + widget.data["services"][i]["total_price"];
    }
    Future<void> savePdf({total}) async {
      //var data = await rootBundle.load("assets/open-sans.ttf");
     
      final pdf = pw.Document();

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              //color: Colors.white,
              padding: pw.EdgeInsets.all(20.0),
              child: pw.Column(
                children: [
                  pw.Text(
                    "MOTO365 SERVICE REPORT",
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Table(
                    border: pw.TableBorder.all(),
                    children: [
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text('Name'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(widget.data["customer_name"]),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text('Email'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(widget.data["email"]),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text('Phone'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(widget.data["phone"]),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text('Brand'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(widget.data["brand"]),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text('Model'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(widget.data["model"]),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text('Registration'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(widget.data["reg_no"]),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text('Store Number'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(widget.data["store_phone"]),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text('Store'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(
                              "${widget.data["store"]}, ${widget.data["store_address"]}"),
                        ),
                      ]),

                      // TableRow(children: [
                      //   Text('Service Name'),
                      //   Text('Price'),
                      //   Text('Status'),
                      // ]),

                      // TableRow(children: [
                      //   Text('Service Name'),
                      //   Text('Price'),
                      //   Text('Status'),
                      // ]),
                    ],
                  ),
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Text(
                    "SERVICES",
                    style: pw.TextStyle(
                      //color: Colors.white,
                      fontSize: 18,
                      //fontFamily: 'Montserrat'
                    ),
                  ),
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Table(
                      border: pw.TableBorder.all(),
                      children: List.generate(widget.data["services"].length,
                          (index) {
                        return pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(
                                widget.data["services"][index]["service_name"]),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(
                                "${widget.data["services"][index]["total_price"]}"),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(
                                widget.data["services"][index]["status"]),
                          ),
                        ]);
                      })),
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Text(
                    "Grand Total : $total",
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ); // Center
          }));
      final output = await getExternalStorageDirectory();
      print("dirrr : ${output.path}");
      final file = File("${output.path}/example.pdf");

      await file.writeAsBytes(await pdf.save()).then((value) {
        print("done");
        // Scaffold.of(context).showSnackBar(SnackBar(
        //   content: Text('Invoice saved to ${output.path}/example.pdf',
        //       style: TextStyle(color: Colors.white)),
        //   duration: Duration(seconds: 3),
        //   backgroundColor: Colors.grey[900],
        // ));
      }); // Page
    }

    return Grad(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'PURCHASE HISTORY',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontFamily: 'Montserrat'),
            ),
          ),
          body: Container(
            //color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "SERVICE REPORT",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(
                  height: 20,
                ),
                Table(
                  border: TableBorder.all(color: Colors.white24),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Name'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.data["customer_name"]),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Email'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.data["email"]),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Phone'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.data["phone"]),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Brand'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.data["brand"]),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Model'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.data["model"]),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Registration'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.data["reg_no"]),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Store Number'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.data["store_phone"]),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Store'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "${widget.data["store"]}, ${widget.data["store_address"]}"),
                      ),
                    ]),

                    // TableRow(children: [
                    //   Text('Service Name'),
                    //   Text('Price'),
                    //   Text('Status'),
                    // ]),

                    // TableRow(children: [
                    //   Text('Service Name'),
                    //   Text('Price'),
                    //   Text('Status'),
                    // ]),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "SERVICES",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(
                  height: 20,
                ),
                Table(
                    border: TableBorder.all(color: Colors.white24),
                    children:
                        List.generate(widget.data["services"].length, (index) {
                      return TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              widget.data["services"][index]["service_name"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "${widget.data["services"][index]["total_price"]}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.data["services"][index]["status"]),
                        ),
                      ]);
                    })),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Grand Total : $total",
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(
                  height: 20,
                ),
                // Button(
                //   onPress: () {
                //     savePdf(total: total);
                //   },
                //   text: "Download Invoice",
                // )
              ],
            ),
          )),
    );
  }
}
