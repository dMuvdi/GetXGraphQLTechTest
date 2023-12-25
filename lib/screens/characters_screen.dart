import 'package:flutter/material.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const Text('Discover all the characters that appear in the Rick an Morty TV Show', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300)),
                const SizedBox(height: 25,),
                TextField(
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: (value) => print(value),
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
                const Text('Characters', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700)),
                const Text('Total (344)', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300)),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 260,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              opacity: 0.5,
                              image: NetworkImage('https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                              fit: BoxFit.cover
                            )
                          ),
                          child: Center(child: Text('Rick Sanchez', style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600))),
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
}