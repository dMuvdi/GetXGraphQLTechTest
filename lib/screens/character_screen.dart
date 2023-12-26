import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../screens/navigation_screen.dart';
import '../controllers/character_controller.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final CharacterController controller = Get.put(CharacterController());

    return GetBuilder<CharacterController>(
      builder: (context) {
        return Scaffold(
          backgroundColor: const Color(0xFF3F3F3F),
          body: Stack(
            children: [
              // Background image
              Positioned(
                top: 0,
                child: Container(
                  height: 300,
                  width: Get.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(controller.character!.image == 'no image' ? 'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg': controller.character!.image),
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xFF3F3F3F)
                        ],
                        stops: [0.4, 1],
                      )
                    ),
                  ),
                ),
              ),
              // AppBar with elevation
              AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () { 
                    controller.character = null;
                    Get.off(() => const NavigationScreen(), transition: Transition.leftToRight); 
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 265,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.character!.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        controller.character!.type! == '' ? 'No type' : controller.character!.type!, 
                        style: const TextStyle(
                          color: Colors.white, 
                          fontSize: 25, 
                          fontWeight: FontWeight.w300
                        ),
                      ),
                      const SizedBox(height: 14,),
                      InfoCard(
                        status: controller.character!.status!,
                        gender: controller.character!.gender!,
                        createdAt: DateFormat('MMM dd, y').format(controller.character!.created!),
                        species: controller.character!.species!,
                        origin: controller.character!.origin!.name!,
                      ),
                      const SizedBox(height: 20,),
                      const Text(
                        'Location', 
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 23, 
                          fontWeight: FontWeight.w500
                        ),
                      ),                   
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: Get.width),
                        child: ListTile(
                          leading: const Icon(Icons.location_on, color: Colors.white, size: 30,),
                          title: Text(
                            '${controller.character!.location!.name! == 'unknown' ? 'Unknown' : controller.character!.location!.name!} - ${controller.character!.location!.type!}',
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
                                  controller.character!.location!.dimension! == '' ? 'Unknown' : controller.character!.location!.dimension!,
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
                      ),
                      const SizedBox(height: 10,),
                      const Text(
                        'Episodes it appears in...', 
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 25, 
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.status,
    required this.gender,
    required this.createdAt,
    required this.species,
    required this.origin,
  });

  final String status;
  final String gender;
  final String createdAt;
  final String species;
  final String origin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      width: Get.width * 0.88,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF585858),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              const Text(
                'Status: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                status == 'unknown' ? 'Unknown' : status,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                  color: Colors.white,  // Change color as needed
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Gender: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                gender == '' ? 'Unknown' : gender,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                  color: Colors.white,  // Change color as needed
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Created At: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                createdAt,
                style: const TextStyle(
                  color: Colors.white,  // Change color as needed
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Species: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                species == '' ? 'Unknown' : species,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                  color: Colors.white,  // Change color as needed
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Origin: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  origin == '' ? 'Unknown' : origin,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    color: Colors.white,  // Change color as needed
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }
}