import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectLocation;

  LocationInput(this.onSelectLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  double lat;
  double long;

  Future<void> _getCurrentUserLocation() async {
    final locData= await Location().getLocation();
    // final staticMapImage=LocationHelper.generateLocationPreviewImage(
    //   latitude:locData.latitude,
    //   longitude:locData.longitude
    // );
    print(locData.latitude);
    print(locData.longitude);
    setState(() {
     //_previewImageUrl=staticMapImage;
     _previewImageUrl='asd';
     lat=locData.latitude;
     long=locData.longitude;
    });
    widget.onSelectLocation(lat,long);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text('No location choosen', textAlign: TextAlign.center)
              // : Image.network(
              //     _previewImageUrl,
              //     fit: BoxFit.cover,
              //     width: double.infinity,
              //   ),
              : Text('Latitude: $lat & Longitude: $long',textAlign: TextAlign.center)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: (){},
            )
          ],
        )
      ],
    );
  }
}
