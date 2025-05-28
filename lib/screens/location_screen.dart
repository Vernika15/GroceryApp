import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/screens/home_screen.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';
import 'package:online_groceries_app/widget/auth_background_container.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  bool _isFetchingLocation = true;
  bool _locationFetched = false;

  Future<void> _fetchLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      setState(() {
        _isFetchingLocation = true;
      });

      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      debugPrint(
        "Current location: Lat: ${position.latitude}, Lng: ${position.longitude}",
      );

      setState(() {
        _isFetchingLocation = false;
        _locationFetched = true;
      });

      await Future.delayed(Duration(seconds: 2));
      // Navigator.pushReplacementNamed(context, '/home');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      debugPrint('Error fetching location: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to fetch location: $e')));
      setState(() {
        _isFetchingLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackgroundContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Image.asset('assets/images/back_arrow.png'),
                    ),
                  ),
                  SizedBox(height: 50),
                  Image.asset('assets/images/location_image.png'),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          'Fetching Your Location',
                          style: textStyle26(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Switch on your location to stay in tune with what’s happening in your area',
                            textAlign: TextAlign.center,
                            style: textStyle16(
                              color: AppColors.subTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 80),
                        if (_isFetchingLocation)
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        else if (_locationFetched)
                          Image.asset(
                            'assets/images/tick_image.png',
                            width: 50,
                            height: 50,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
