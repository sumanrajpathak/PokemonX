import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_demo/core/consts/colors.dart';
import 'package:web_demo/utils/adaptive.dart';
import 'package:web_demo/utils/utils.dart';

import '../model/pokemon_model.dart';

class PokeCard extends StatelessWidget {
  final String name;
  final List<PokeType>? type;
  final String image;

  const PokeCard({
    Key? key,
    required this.name,
    required this.type,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 4,
                right: 4,
                child: CachedNetworkImage(
                  imageUrl: image,
                  height: isDisplayDesktop(context)
                      ? widthOfScreen(context) * 0.2
                      : widthOfScreen(context) * 0.3,
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Text(
                  name.capitalize(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 16,
                child: Row(
                  children: [
                    ...?type?.map(
                      (e) => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        margin: const EdgeInsets.only(
                          right: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          e.type!.name!,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
