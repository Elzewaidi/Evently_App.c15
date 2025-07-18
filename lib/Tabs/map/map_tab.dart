import 'package:eventlyapp/Tabs/widget/map_event_item.dart';
import 'package:eventlyapp/l10n/app_localizations.dart';
import 'package:eventlyapp/providers/location_provider.dart';
import 'package:eventlyapp/utils/app_assets.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../Model/event.dart';
import '../../providers/event_list_provider.dart';

class MapTap extends StatefulWidget {
  static const String routeName = 'MapTap';

  MapTap({super.key});

  @override
  State<MapTap> createState() => _MapTapState();
}

class _MapTapState extends State<MapTap> {
  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initCircles();
    });
  }

  GoogleMapController? mapController;

  void _initCircles() {
    var eventListProvider = Provider.of<EventListProvider>(
      context,
      listen: false,
    );
    for (var event in eventListProvider.eventsList) {
      setState(() {
        if (event.late != null && event.long != null) {
          setState(() {
            _circles?.add(
              Circle(
                circleId: CircleId(event.id),
                center: LatLng(event.late!, event.long!),
                radius: 5,
                fillColor: AppColors.blackColor,
                strokeWidth: 10,
                strokeColor: AppColors.blackColor.withValues(alpha: .5),
              ),
            );
          });
        }
      });
    }
  }

  Set<Circle> _updateCircleByColor(Event event) {
    return _circles =
        _circles!.map((Circle circle) {
          if (circle.circleId.value == event.id) {
            return Circle(
              circleId: circle.circleId,
              center: circle.center,
              radius: circle.radius,
              fillColor: AppColors.primaryLight,
              strokeWidth: circle.strokeWidth,
              strokeColor: AppColors.primaryLight.withValues(alpha: 0.5),
            );
          } else {
            return Circle(
              circleId: circle.circleId,
              center: circle.center,
              radius: circle.radius,
              fillColor: AppColors.blackColor,
              strokeWidth: circle.strokeWidth,
              strokeColor: AppColors.blackColor.withValues(alpha: 0.5),
            );
          }
        }).toSet();
  }

  _centerMap(LatLng newLaLng) {
    mapController?.animateCamera(CameraUpdate.newLatLng(newLaLng));
  }

  Set<Circle>? _circles = {};

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var locationProvider = Provider.of<LocationProvider>(context);

    return eventListProvider.eventsList.isEmpty
        ? SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.no_event_found,
              style: AppStyles.bold20Primary(context),
            ),
          ],
        ),
      ),
    )
        : Stack(
      children: [
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target:
            locationProvider.userLocation ??
                LatLng(31.0818406, 29.8935053),
            zoom: 17,
          ),
          circles: _circles ?? {},
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
        ),
        Positioned(
          top: 50,
          right: 16,
          child: InkWell(
            onTap: () {
              _centerMap(locationProvider.userLocation!);
            },
            child: Image.asset(AseetsMnger.iconMap, width: 50, height: 50),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: height * .25,
            width: width * .35,

            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: PageScrollPhysics(),
              shrinkWrap: true,
              itemCount: eventListProvider.eventsList.length,
              padding: EdgeInsets.symmetric(vertical: height * .01),
              itemBuilder:
                  (context, index) =>
                  InkWell(
                    onTap: () {
                      var selectedEvent =
                      eventListProvider.eventsList[index];
                      _centerMap(
                        LatLng(selectedEvent.late!, selectedEvent.long!),
                      );

                      setState(() {
                        _circles = _updateCircleByColor(selectedEvent);
                      });
                    },
                    child: MapEventItem(
                      event: eventListProvider.eventsList[index],
                    ),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
