import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/static_map_provider.dart';

import '../../helper/ensure-visible.dart';

class LocationInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Uri _staticMapUri;
  final FocusNode _addressInputFocus = FocusNode();

  @override
  void initState() {
    _addressInputFocus.addListener(_updateLocation);
    getStaticMap();
    super.initState();
  }

  @override
  void dispose() {
    _addressInputFocus.dispose();
    super.dispose();
  }

  void getStaticMap() {
    final StaticMapProvider staticMapProvider =
        StaticMapProvider('AIzaSyDo9ANuxA9wGTY9PGwTd-s8nnQnEkuMCvQ');

    final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers(
        [Marker('position', 'position', 41.40338, 2.17403)],
        center: Location(41.40338, 2.17403),
        width: 500,
        height: 300,
        maptype: StaticMapViewType.roadmap);

    setState(() {
      _staticMapUri = staticMapUri;
    });
  }

  void _updateLocation() {}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EnsureVisibleWhenFocused(
          focusNode: _addressInputFocus,
          child: TextFormField(
            focusNode: _addressInputFocus,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Image.network(_staticMapUri.toString())
      ],
    );
  }
}
