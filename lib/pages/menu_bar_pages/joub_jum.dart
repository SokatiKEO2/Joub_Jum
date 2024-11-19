import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';

import 'joub_jum_details.dart';

class JoubJumPage extends StatefulWidget {
  const JoubJumPage({super.key});

  @override
  State<JoubJumPage> createState() => _JoubJumPageState();
}

class _JoubJumPageState extends State<JoubJumPage> {
  // List to store invitation details
  final List<Map<String, dynamic>> _joubjums = [
    {
      "user": "Samnang",
      "date": "03/11/24",
      "time": "6:00 PM",
      "location": "Ambience Bar",
      "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
      "placeId": "ChIJT17FJIlRCTERKJ2gjPwJf6A",
      "invitees": [
        {"name": "Kati",
          "image": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
        },
        {"name": "Kati",
          "image": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
        },
        {"name": "Kati",
          "image": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
        }
      ]
    },
    {
      "user": "Panha",
      "date": "04/11/24",
      "time": "8:00 PM",
      "location": "Hub",
      "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
      "placeId": "ChIJ3VnQszZRCTER3Wc7W4e2DCw",
      "invitees": {"Pich", "Panha"}
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              itemCount: _joubjums.length,
              itemBuilder: (BuildContext context, int index) {
                return buildJoubJumCard(_joubjums[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildJoubJumCard(Map<String, dynamic> joubjum) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: GestureDetector(
          onTap: () => _onJoubJumTap(joubjum),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: buttonColor,
            ),
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.network(
                                joubjum['imagePath']!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0,),
                          Expanded(
                            child: Text(
                              'JoubJum with ${joubjum['user']}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0), // Space between title and details
                      Text(
                        'Date & Time: ${joubjum['date']}, ${joubjum['time']}\nLocation: ${joubjum['location']}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onJoubJumTap(Map<String, dynamic> joubjum) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JoubJumDetailsPage(joubjumDetails: joubjum),
      ),
    );
    if (result == 'delete') {
      setState(() {
        _onRejectPressed(joubjum);
      });
    }
  }

  void _onRejectPressed(Map<String, dynamic> joubjum) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cancel JoubJum from ${joubjum['user']}'),
      ),
    );
    setState(() {
      _joubjums.remove(joubjum);
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'JoubJums',
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color(0xFFcaffbf),
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
//   Widget buildJoubJumCard(Map<String, String> joubjum) {
//     return Flexible(
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 12.0),
//         child: GestureDetector(
//           onTap: () => _onInvitationTap(joubjum['user']!),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20.0),
//               color: boxColor,
//             ),
//             padding: const EdgeInsets.all(12.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 25.0,
//                             backgroundColor: Colors.transparent,
//                             child: ClipOval(
//                               child: Image.network(
//                                 joubjum['imagePath']!,
//                                 width: 50,
//                                 height: 50,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 8.0,),
//                           Expanded(
//                             child: Text(
//                               'JoubJum with ${joubjum['user']}',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontFamily: 'Raritas',
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10.0),
//                       Text(
//                         'Date & Time: ${joubjum['date']}, ${joubjum['time']}\nLocation: ${joubjum['location']}',
//                         style: const TextStyle(
//                           color: Colors.grey,
//                           fontSize: 18,
//                           fontFamily: 'Raritas'
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Icon(
//                   Icons.arrow_forward_ios,
//                   color: appBarColor,
//                   size: 24,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _onInvitationTap(String user) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Tapped on JoubJum with $user'),
//       ),
//     );
//   }
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       title: const Text(
//         'JoubJums',
//         style: TextStyle(fontSize: 25, fontFamily: "Raritas"),
//       ),
//       backgroundColor: appBarColor,
//       elevation: 0.0,
//       centerTitle: true,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios_new_outlined),
//         onPressed: () => Navigator.pop(context),
//       ),
//     );
//   }
// }
