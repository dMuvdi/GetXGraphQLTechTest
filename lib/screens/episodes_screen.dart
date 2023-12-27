import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/episodes_controller.dart';
import '../widgets/custom_dropdown.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final EpisodesController controller = Get.put(EpisodesController());

    return GetBuilder<EpisodesController>(
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
                    const Text('Discover all the episodes that appear in the Rick an Morty TV Show', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300)),
                    const SizedBox(height: 25,),
                    TextField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) async {
                        controller.searchValue = value;
                        await controller.getEpisodesBySearch();
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
                            const Text('Episodes', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700)),
                            Text('Total ${controller.count}', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300)),
                          ],
                        ),
                        const Spacer(),
                        Obx(() {
                          return CustomDropDown(
                            hintText: 'Season',
                            items: controller.seasons,
                            onChanged: (value) => controller.changeSeason(value!),
                            value: controller.season.value,
                            fillColor: Colors.white,
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    controller.episodes.isEmpty ? 
                    const Center(child: CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Color(0xFF3F3F3F),
                    )) :
                    SizedBox(
                      height: 260,
                      width: Get.width,
                      child: ListView.builder(
                        itemCount: controller.episodes.length,
                        itemBuilder: (context, index) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: Get.width),
                            child: ListTile(
                              leading: const Icon(Icons.tv, color: Colors.white, size: 30,),
                              title: Text(
                                controller.episodes[index].name!,
                                style: const TextStyle(
                                  color: Colors.white, 
                                  fontSize: 17, 
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                              subtitle: Text(
                                '${controller.episodes[index].airDate!} - ${controller.episodes[index].episode!}',
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
                );
              }
            ),
          )
        );
      }
    );
  }
}