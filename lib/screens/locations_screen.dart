import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/locations.controller.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final LocationsController controller = Get.put(LocationsController());

    return GetBuilder<LocationsController>(
      builder: (context) {
        return Scaffold(
          backgroundColor: const Color(0xFF3F3F3F),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50,),
                    const Text('Welcome...', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10,),
                    const Text('Discover all the locations that appear in the Rick an Morty TV Show', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300)),
                    const SizedBox(height: 25,),
                    TextField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) async {
                        controller.searchValue = value;
                        await controller.getLocationsSearch();
                      },
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 18),
                        fillColor: const Color(0xFF585858),
                        filled: true,
                        hintText: 'Search...',
                        hintStyle: const TextStyle(color: Color(0xFF969696), fontSize: 20, fontWeight: FontWeight.w400),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFFB4B4B4), size: 30,),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.transparent)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white)
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Locations', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700)),
                            Text('Total (${controller.locations.isEmpty ? 0 : controller.count})', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300)),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => controller.decreasePageNumber(), 
                          icon: const Icon(Icons.chevron_left, color: Colors.white,),
                        ),
                        Text('Page ${controller.pageNumber}', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),
                        IconButton(
                          onPressed: () => controller.noMoreLocations ? null : controller.increasePageNumber(), 
                          icon: const Icon(Icons.chevron_right, color: Colors.white,),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    controller.noMoreLocations ?
                    const Text('No more locations', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300)) :
                    controller.locations.isEmpty ? 
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Color(0xFF3F3F3F),
                      ),
                    ) : 
                    SizedBox(
                      height: 260,
                      child: ListView.builder(
                        itemCount: controller.locations.length,
                        itemBuilder: (context, index) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: Get.width),
                            child: ListTile(
                              leading: const Icon(Icons.location_on, color: Colors.white, size: 30,),
                              title: Text(
                                '${controller.locations[index].name! == 'unknown' ? 'Unknown' : controller.locations[index].name!} - ${controller.locations[index].type!}',
                                style: const TextStyle(
                                  color: Colors.white, 
                                  fontSize: 17, 
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  const Text(
                                    'Dimension: ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.locations[index].dimension! == '' ? 'Unknown' : controller.locations[index].dimension!,
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                        color: Colors.white,  // Change color as needed
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    )
                  ],
                );
              }
            ),
          )
        );
      }
    );
  }
}