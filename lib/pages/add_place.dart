import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geo_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../widgets/image_input.dart';
import '../provider/great_places.dart';

class AddPlacePage extends StatefulWidget {
  @override
  _AddPlacePageState createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  final _titleController = TextEditingController();
  File _pickedImage;
  Placelocation location;

  void _selectImage(File pickedImage){
    _pickedImage=pickedImage;
  }
  
  void _getLocation(double lat, double long){
    location=Placelocation(latitude:lat,longitude:long);
  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage==null){
      return;
    }
    //vai para api
    Provider.of<GreatPlaces>(context).addPlace(_titleController.text, _pickedImage,location);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            SizedBox(height: 20),
            ImageInput(_selectImage),
            SizedBox(height: 20),
            LocationInput(_getLocation),
            SizedBox(height: 40),
            RaisedButton.icon(
              icon: Icon(Icons.add,color: Colors.white),
              label: Text('Add Place',style: TextStyle(color: Colors.white),),
              onPressed: _savePlace,
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
