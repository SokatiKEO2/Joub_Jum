import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';
import '../../models/fetch_place_data.dart';

class JoubJumDetailsPage extends StatefulWidget {
  final Map<String, dynamic> joubjumDetails;

  const JoubJumDetailsPage({super.key, required this.joubjumDetails});

  @override
  State<JoubJumDetailsPage> createState() => _JoubJumDetailsPageState();
}

class _JoubJumDetailsPageState extends State<JoubJumDetailsPage> {
  late Map<String, dynamic> _joubjumDetails;

  void goToPlace(Map<String, dynamic> joubjum) {
    var result = fetchPlace(joubjum['placeId']);
    Navigator.pop(context);
    Navigator.pop(context, result);
  }

  @override
  void initState() {
    super.initState();
    _joubjumDetails = widget.joubjumDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                color: drawerTop,
              ),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: drawerBottom,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      // Adjusts height to fit contents
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Created by:',
                              style: TextStyle(
                                color: textForeground,
                                fontSize: 20,
                                fontFamily: mainFont,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(
                                  _joubjumDetails['imagePath']!,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              _joubjumDetails['user']!,
                              style: const TextStyle(
                                color: textForeground,
                                fontSize: 20,
                                fontFamily: mainFont,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Location: ${_joubjumDetails['location']!}',
                                style: const TextStyle(
                                  color: textForeground,
                                  fontSize: 20,
                                  fontFamily: mainFont,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  goToPlace(_joubjumDetails);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.white,
                                ),
                                child: const Text(
                                  '⚲',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Text(
                          'Date: ${_joubjumDetails['date']!}',
                          style: const TextStyle(
                            color: textForeground,
                            fontSize: 20,
                            fontFamily: mainFont,
                          ),
                        ),
                        const Divider(),
                        Text(
                          'Time: ${_joubjumDetails['time']!}',
                          style: const TextStyle(
                            color: textForeground,
                            fontSize: 20,
                            fontFamily: mainFont,
                          ),
                        ),
                        const Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Going:',
                              style: TextStyle(
                                color: textForeground,
                                fontSize: 20,
                                fontFamily: mainFont,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            // Space between "Going:" label and avatars
                            Expanded(
                              child: Wrap(
                                spacing: 10.0,
                                // Space between each avatar-name pair
                                runSpacing: 10.0,
                                // Space between lines if wrapping occurs
                                children: _joubjumDetails['invitees']
                                    .map<Widget>((invitee) =>
                                        _buildAvatarName(invitee['name'],
                                            invitee['image']))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            buildButtons()
          ],
        ),
      ),
    );
  }

  Row buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context, 'delete'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2.0,
            backgroundColor: Colors.red,
          ),
          child: const Text(
            'Cancel JoubJum',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: mainFont,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarName(String name, String image) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 13.0,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: Image.network(
              image,
              width: 26,
              height: 26,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 5.0),
        Text(
          name,
          style: const TextStyle(
            color: textForeground,
            fontSize: 20,
            fontFamily: mainFont,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'JoubJum Detail',
        style: TextStyle(fontSize: 25, fontFamily: mainFont),
      ),
      backgroundColor: appBarColor,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
