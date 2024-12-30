import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matcron/app/main.dart'; // Replace with your actual main.dart import
import '../tests/Robots/matress_type_robot.dart';
import '../tests/Robots/login_robot.dart';
import '../tests/Robots/mattress_type_form_robot.dart';
import 'package:matcron/app/injection_container.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  try {
    print('Initializing dependencies...');
    await initializeDependencies();
    print('Dependencies initialized successfully.');
  } catch (e) {
    print('Error during dependency initialization: $e');
    return;
  }
  group("mattress page and sub page testing ", (){
    late LoginRobot loginRobot;
    late MattressTypeRobot mattressRobot;

  })
}