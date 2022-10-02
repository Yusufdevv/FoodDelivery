import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/widgets/location_search_box.dart';

import '../../blocs/autocomplete/autocomplete_bloc.dart';
import '../../blocs/geolocation/geolocation_bloc.dart';
import '../../blocs/place/place_bloc.dart';
import '../../widgets/gmap.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  static const String routeName = '/location';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const LocationScreen(),
        settings: const RouteSettings(name: routeName));
  }

  // final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceLoading) {
            return Stack(
              children: [
                // # google map
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: BlocBuilder<GeolocationBloc, GeolocationState>(
                    builder: (context, state) {
                      if (state is GeolocationLoading) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (state is GeolocationLoaded) {
                        return GMap(
                            lat: state.position.latitude,
                            lng: state.position.longitude);
                      } else {
                        return const Text('Something went wrong.');
                      }
                    },
                  ),
                ),
                // # Save button
                const SaveButton(),
                // # location
                const Location(),
              ],
            );
          } else if (state is PlaceLoaded) {
            return Stack(
              children: [
                // # google map
                GMap(lat: state.place.lat, lng: state.place.lon),
                // # Save button
                const SaveButton(),
                // # location
                const Location(),
              ],
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}

// # floating button
// Positioned(
//   bottom: 45,
//   right: 10,
//   child: FloatingActionButton(
//     backgroundColor: Theme.of(context).primaryColor,
//     onPressed: () {},
//     child: const Icon(Icons.my_location),
//   ),
// )

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 50,
        right: 20,
        left: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 70,
          ),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: () {},
              child: const Text('Save')),
        ));
  }
}

class Location extends StatelessWidget {
  const Location({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 50,
        right: 20,
        left: 20,
        child: SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
                height: 50,
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                children: [
                  const LocationSearchBox(),
                  BlocBuilder<AutocompleteBloc, AutocompleteState>(
                    builder: (context, state) {
                      if (state is AutocompleteLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is AutocompleteLoaded) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          height: 300,
                          color: state.autocomplete.isNotEmpty
                              ? Colors.black.withOpacity(0.6)
                              : Colors.transparent,
                          child: ListView.builder(
                              itemCount: state.autocomplete.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    state.autocomplete[index].description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: Colors.white),
                                  ),
                                  onTap: () {
                                    context.read<PlaceBloc>().add(
                                        LoadPlaceEvent(
                                            placeId: state
                                                .autocomplete[index].placeId));
                                  },
                                );
                              }),
                        );
                      } else {
                        return const Center(
                            child: Text('Someting went wrong.'));
                      }
                    },
                  )
                ],
              )),
            ],
          ),
        ));
  }
}
