import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_gaule_thakali/e_museum_item.dart';
import 'package:teen_gaule_thakali/providers/locale_provider.dart';
import 'package:teen_gaule_thakali/views/e_museum_details.dart';

class EMuseumCard extends StatefulWidget {
  const EMuseumCard({
    super.key,
    required this.id,
    required this.item, // Add EMuseumItem
  });

  final String id;
  final EMuseumItem item;

  @override
  State<EMuseumCard> createState() => _EMuseumCardState();
}

class _EMuseumCardState extends State<EMuseumCard> {

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final isEnglish = localeProvider.locale.languageCode == 'en';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EMuseumDetails(
              id: widget.id,
              item: widget.item, // Pass EMuseumItem to EMuseumDetails
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 130,
                    child: widget.item.photo.isNotEmpty
                        // ? Image.network(
                        //     widget.item.photo,
                        //     width: double.infinity,
                        //     height: 130,
                        //     fit: BoxFit.cover,
                        //     errorBuilder: (context, error, stackTrace) =>
                        //         Icon(Icons.error, size: 50),
                        //   )
                        ? Image.asset(
                          'assets/${widget.item.photo}',
                          width: double.infinity,
                          height: 130,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error, size: 50),
                          )
                        : Icon(Icons.image_not_supported, size: 50),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isEnglish ? widget.item.titleEn : widget.item.titleNe,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    isEnglish ? widget.item.descEn : widget.item.descNe,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  // Text(
                  //   widget.item.photo,
                  //   overflow: TextOverflow.ellipsis,
                  //   maxLines: 1,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}