import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_bloc.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_event.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_state.dart';
import 'package:matcron/app/features/mattress/presentation/pages/assign_page.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/components/header/header.dart';
import 'package:matcron/core/constants/constants.dart';

class AddMattressPage extends StatefulWidget {
  final List<MattressTypeEntity> mattressTypes;

  const AddMattressPage(this.mattressTypes, {super.key});

  @override
  AddMattressPageState createState() => AddMattressPageState();
}

class AddMattressPageState extends State<AddMattressPage> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String? selectedMattressType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RemoteMattressBloc, RemoteMattressState>(
        builder: (_, state) {
          if (state is RemoteMattressesLoading) {
            return Scaffold(
              backgroundColor: HexColor("#E5E5E5"),
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(matcronPrimaryColor),
                ),
              ),
            );
          }

          if (state is RemoteMattressInitial) {
            return _buildPage(context);
          }

          // Use addPostFrameCallback for navigation
          if (state is RemoteMattressesDone) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssignPage(state.uid),
                ),
              );
            });
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor("#E5E5E5"),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header(title: 'Mattress'),
              const SizedBox(height: 20.0),

              // Block with rounded edges and picture
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/images/assign_page.png',
                    height: 175,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 70.0),

              // Rounded input bar for location
              _buildRoundedTextField(
                controller: locationController,
                hintText: "Enter Location",
              ),
              const SizedBox(height: 30.0),

              // Dropdown for mattress type
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedMattressType,
                    hint: const Text("Select Mattress Type"),
                    isExpanded: true,
                    onChanged: (value) {
                      if (value == '+ Add custom Type') {
                        // Navigate to custom type page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const Placeholder(), // Replace with your page
                          ),
                        );
                      } else {
                        setState(() {
                          selectedMattressType = value;
                        });
                      }
                    },
                    items: [
                      ...widget.mattressTypes.map(
                        (type) => DropdownMenuItem<String>(
                          value: type.id,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${type.name} ",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "(${type.length} x ${type.width} x ${type.height})",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const DropdownMenuItem<String>(
                        value: '+ Add custom Type',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                                color:
                                    Colors.grey), // Line before Add Custom Type
                            Text(
                              '+ Add custom Type',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Date input field
              _buildRoundedTextField(
                controller: dateController,
                hintText: "Select Date",
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      dateController.text =
                          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    });
                  }
                },
              ),
              const SizedBox(height: 35.0),

              // Generate RFID button
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_validateFields()) {
                      _generateRfid();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: matcronPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  child: const Text(
                    "Generate RFID",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedTextField({
    required TextEditingController controller,
    required String hintText,
    bool readOnly = false,
    void Function()? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 20.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  bool _validateFields() {
    if (locationController.text.isEmpty) {
      _showError("Please enter a location.");
      return false;
    }
    if (selectedMattressType == null) {
      _showError("Please select a mattress type.");
      return false;
    }
    if (dateController.text.isEmpty) {
      _showError("Please select a date.");
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _generateRfid() {
    var m = MattressEntity(
        orgId: '3e176182-beca-11ef-a25f-0242ac180002',
        mattressTypeId: '458b7349-1af2-4833-b23f-011372c3b6b3',
        lifeCyclesEnd: DateTime.now(),
        batchNo: '',
        location: locationController.text);

    context.read<RemoteMattressBloc>().add(GenerateRfid(m));
  }
}
