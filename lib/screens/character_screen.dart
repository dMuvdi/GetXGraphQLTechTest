import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../screens/navigation_screen.dart';
import '../controllers/character_controller.dart';
import '../widgets/info_card.dart';

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
                top: 240,
                child: SizedBox(
                  height: Get.height - 265,
                  width: Get.width,
                  child: ListView(
                    children: [
                      Padding(
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
                            SizedBox(
                              height: 200,
                              width: Get.width,
                              child: ListView.builder(
                                itemCount: controller.character!.episodes!.length,
                                itemBuilder: (context, index) {
                                  return ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: Get.width),
                                    child: ListTile(
                                      leading: const Icon(Icons.tv, color: Colors.white, size: 30,),
                                      title: Text(
                                        controller.character!.episodes![index].name!,
                                        style: const TextStyle(
                                          color: Colors.white, 
                                          fontSize: 17, 
                                          fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${controller.character!.episodes![index].airDate!} - ${controller.character!.episodes![index].episode!}',
                                        style: const TextStyle(
                                          color: Colors.white, 
                                          fontSize: 15, 
                                          fontWeight: FontWeight.w300
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ),
                          ],
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