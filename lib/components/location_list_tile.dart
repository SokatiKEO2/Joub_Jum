import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LocationListTile extends StatelessWidget {
  const LocationListTile({
    super.key,
    required this.location,
    required this.press,
  });

  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 5,
          leading: SvgPicture.asset("assets/icons/location_pin.svg"),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: 'Raritas', fontSize: 20),
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
          // color: secondaryColor5LightTheme,
        ),
      ],
    );
  }
}
