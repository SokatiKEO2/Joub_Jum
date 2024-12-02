import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/pages/menu_bar_pages/joub_jum.dart';
import 'package:joub_jum/pages/menu_bar_pages/select_friends.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'Provider.dart';

class CreateJoubJumPage extends StatefulWidget {
  final String location;
  final String placeId;

  const CreateJoubJumPage({
    super.key,
    required this.location,
    required this.placeId,
  });

  @override
  _CreateJoubJumPageState createState() => _CreateJoubJumPageState();
}

class _CreateJoubJumPageState extends State<CreateJoubJumPage> {
  late String location;
  late String placeId;
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _textController.text = DateFormat('dd/MM/yy').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final selectedTime =
      DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      final formattedTime = DateFormat('h:mm a').format(selectedTime);
      setState(() {
        _controller.text = formattedTime;
      });
    }
  }

  late Map<String, dynamic> setUpJoubJum;

  @override
  void initState() {
    super.initState();
    location = widget.location;
    placeId = widget.placeId;

    // Initialize the setUpJoubJum map here
    //TODO BACKEND FOR JOUBJUM
    setUpJoubJum = {
      "creator": "Ysara",
      "user": "Kati",
      "date": "",
      "time": "",
      "location": location,
      "imagePath":
      "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
      "placeId": placeId,
      "invitees": <Map<String, String>>[],
      "going": [
        {
          "name": "Ysara",
          "image": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
        }
      ]// Explicit type definition
    };
  }

  void _createJoubJum() {
    if (_formStateKey.currentState?.validate() == true) {
      _formStateKey.currentState?.save();

      try {
        Provider.of<InvitationsAndJoubJumsState>(context, listen: false)
            .createJoubJum(setUpJoubJum);

        Navigator.pop(context);
        navigateToNextScreen(context, const JoubJumPage());
      } catch (e) {
        debugPrint("Error creating JoubJum: $e");
      }
    }
  }

  void _addInvitee(Map<String, String> invitee) {
    setState(() {
      setUpJoubJum['invitees'] ??= <Map<String, String>>[];
      setUpJoubJum['invitees'].add({
        'name': invitee['name'].toString(),
        'image': invitee['imagePath'].toString(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final allFriendsState = Provider.of<InvitationsAndJoubJumsState>(context);
    final allFriends = allFriendsState.allFriends;
    return Scaffold(
      backgroundColor: const Color(0xFFE1D5C9),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: const Color(0xFFC49551),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFE1D5C9),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formStateKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Created by',
                                  ),
                                  initialValue: setUpJoubJum['user'],
                                  readOnly: true,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Location',
                                  ),
                                  initialValue: setUpJoubJum['location'],
                                  readOnly: true,
                                ),
                                TextFormField(
                                  controller: _textController,
                                  decoration: InputDecoration(
                                    hintText: 'DD/MM/YYYY',
                                    labelText: 'Select Date',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                    ),
                                  ),
                                  validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Parameter Required'
                                      : null,
                                  onSaved: (value) =>
                                  setUpJoubJum['date'] = value ?? '',
                                  readOnly: true,
                                ),
                                TextFormField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: '9:00 AM',
                                    labelText: 'Select Time',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.alarm),
                                      onPressed: () {
                                        _selectTime(context);
                                      },
                                    ),
                                  ),
                                  validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Parameter Required'
                                      : null,
                                  onSaved: (value) =>
                                  setUpJoubJum['time'] = value ?? '',
                                  readOnly: true,
                                ),
                                const SizedBox(height: 8),
                                _buildInviteesRow(context, allFriends),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _buildCreateJoubJumButton(),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildCreateJoubJumButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: ElevatedButton(
            onPressed: _createJoubJum,
            style: ElevatedButton.styleFrom(
              backgroundColor: appBarColor,
              foregroundColor: bodyColor,
            ),
            child: const Text('Create JoubJum'),
          ),
        ),
      ],
    );
  }

  Row _buildInviteesRow(BuildContext context, List<Map<String, String>> allFriends) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Invitees:',
          style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontFamily: mainFont),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
              ...setUpJoubJum['invitees']
                  .map<Widget>((invitee) => _buildAvatarName(invitee['name'], invitee['image']))
                  .toList(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () async {
                        final selectedFriend = await Navigator.push(context,
                          MaterialPageRoute(
                            builder: (_) => FriendSelectionPage(currentInvitees: setUpJoubJum['invitees'],),
                          ),
                        );
                        if (selectedFriend != null) {
                          _addInvitee(selectedFriend);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: const Color(0xFFC49551),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
      backgroundColor: const Color(0xFFC49551),
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildAvatarName(String name, String imagePath) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 13.0,
          backgroundImage: NetworkImage(imagePath),
        ),
        const SizedBox(width: 5.0),
        Text(
          name,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      ],
    );
  }
}

