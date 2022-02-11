import 'package:flutter/material.dart';

class Insurance extends StatelessWidget {
  const Insurance();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Insurance1()));
      },
      child: Container(
        child: Image(
          image: AssetImage("assets/images/insurance.png"),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}

class Insurance1 extends StatelessWidget {
  const Insurance1();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Insurance2()));
      },
      child: Container(
        child: Image(
          image: AssetImage("assets/images/insurancePic1.png"),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}

class Insurance2 extends StatelessWidget {
  const Insurance2();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Insurance3()));
      },
      child: Container(
        child: Image(
          image: AssetImage("assets/images/insurancePic2.png"),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}

class Insurance3 extends StatelessWidget {
  const Insurance3();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Insurance4()));
      },
      child: Container(
        child: Image(
          image: AssetImage("assets/images/insurancePic3.png"),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}

class Insurance4 extends StatelessWidget {
  const Insurance4();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      child: ListView(
        children: [
          Container(
            child: Image(
              image: AssetImage("assets/images/insurancePic4.png"),
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}

class Insurance5 extends StatelessWidget {
  final Map vehicle;
  const Insurance5(this.vehicle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Insurance',
          style: TextStyle(
              color: Colors.white70, fontSize: 20, fontFamily: 'Montserrat'),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: <Widget>[
                Icon(Icons.drive_eta, color: Colors.white70, size: 20),
                Text(
                  "${vehicle['vehicle_model'] ?? ""}",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontFamily: 'Montserrat'),
                ),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Insurance Details",
                    style: const TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Financer',
                    style: const TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    vehicle['financer']??"",
                    style: const TextStyle(
                        color: const Color(0xdeffffff),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Insurance Company',
                    style: const TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    vehicle['insurance_company']??"",
                    style: const TextStyle(
                        color: const Color(0xdeffffff),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Policy Number',
                    style: const TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    vehicle['insurance_policy_number']??"",
                    style: const TextStyle(
                        color: const Color(0xdeffffff),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Man.Date',
                    style: const TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    vehicle['manufacturing_date']??"",
                    style: const TextStyle(
                        color: const Color(0xdeffffff),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Insurance6()));
                },
                child: Row(
                  children: [
                    Text(
                      "Raise Claim",
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class Insurance6 extends StatelessWidget {
  const Insurance6();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Insurance7()));
      },
      child: ListView(
        children: [
          Container(
            child: Image(
              image: AssetImage("assets/images/insurancePic6.png"),
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}

class Insurance7 extends StatelessWidget {
  const Insurance7();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Insurance8()));
      },
      child: ListView(
        children: [
          Container(
            child: Image(
              image: AssetImage("assets/images/insurancePic7.png"),
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}

class Insurance8 extends StatelessWidget {
  const Insurance8();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      child: ListView(
        children: [
          Container(
            child: Image(
              image: AssetImage("assets/images/insurancePic8.png"),
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
