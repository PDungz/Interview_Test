import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          decoration: const BoxDecoration(color: Color(0xFFF4F4F4)),
          child: Column(
            children: [
              const Center(
                child: Text("Profile"),
              ),
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 12),
                          height: MediaQuery.of(context).size.width * 0.28,
                          width: MediaQuery.of(context).size.width * 0.28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.28),
                            border: Border.all(
                                color: const Color(0xFFF6BD3F), width: 4),
                          ),
                          child: ClipOval(
                            child: Container(
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://i.pinimg.com/236x/5f/b4/d5/5fb4d5734da114b96dbbac21d133333c.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.circular(12), // Hình tròn
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.add_a_photo,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Phùng Văn Dũng',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const CustomTextFiel(
                title: 'Enter your full name',
                iconPre: Icon(Icons.person),
                iconSuf: Icon(Icons.edit),
              ),
              const SizedBox(height: 12),
              DatePickerDisplay(
                selectedDate: selectedDate,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
              ),
              const SizedBox(height: 12),
              const CustomGender(),
              const SizedBox(height: 12),
              const CustomTextFiel(
                title: 'Enter your phone number',
                iconPre: Icon(Icons.phone),
                iconSuf: Icon(Icons.edit),
              ),
              const SizedBox(height: 12),
              const CustomTextFiel(
                title: 'Enter your email',
                iconPre: Icon(Icons.email),
                iconSuf: Icon(Icons.edit),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: Colors.black,
                      ),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFiel extends StatelessWidget {
  final String title;
  final Icon iconPre;
  final Icon iconSuf;
  const CustomTextFiel({
    super.key,
    required this.title,
    required this.iconPre,
    required this.iconSuf,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Material(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: iconPre,
          ),
        ),
        suffixIcon: Material(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(onPressed: () {}, icon: iconSuf)),
        ),
      ),
    );
  }
}

class DatePickerDisplay extends StatelessWidget {
  final void Function()? onTap;
  final DateTime? selectedDate;

  const DatePickerDisplay({
    super.key,
    this.onTap,
    this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4, right: 12),
              child: Icon(
                Icons.calendar_today,
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: onTap,
                child: Text(
                  selectedDate == null
                      ? "Select Date"
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.edit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomGender extends StatefulWidget {
  const CustomGender({super.key});

  @override
  State<CustomGender> createState() => _CustomGenderState();
}

class _CustomGenderState extends State<CustomGender> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.accessibility_rounded,
            ),
          ),
          Expanded(
            child: DropdownButton<String>(
              hint: const Text('Male'),
              underline: const SizedBox.shrink(),
              value: _selectedItem,
              items: ['Male', 'Female', 'Other']
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
              },
              icon: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width *
                        0.4), // Tạo khoảng cách cho icon
                child: const Icon(Icons.arrow_drop_down),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
    );
  }
}
