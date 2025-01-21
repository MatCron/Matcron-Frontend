import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Terms and Condition",
        style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white 
        ),

        backgroundColor: Color.fromARGB(255, 80, 194, 201),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to our Mattress Company, where we provide not only '
              'high-quality mattresses but also offer cleaning services and '
              'cutting-edge RFID technology to track your mattress. '
              '\n\n1. **Service Overview**: We wash and maintain the cleanliness of your mattress, '
              'ensuring that you enjoy the best sleep possible. Our RFID technology helps '
              'in tracking the history and maintenance records of your mattress. '
              '\n\n2. **Usage**: By using our services, you agree to our use of RFID technology '
              'to monitor and manage the servicing history of your mattress. '
              '\n\n3. **Privacy**: We respect your privacy. The information collected from the RFID '
              'tags is solely for service enhancement and is not shared with any third parties. '
              '\n\n4. **Service Terms**: Our mattress cleaning services are available on a subscription '
              'basis. You can choose the frequency of cleaning as per your convenience and needs. '
              '\n\n5. **Cancellation**: You may cancel the cleaning services at any time. However, we '
              'appreciate advance notice to adjust our scheduling. '
              '\n\n6. **Amendments**: We reserve the right to modify these terms and conditions at any time. '
              'Continued use of our services constitutes your acceptance of these changes.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                height: 1.5, // Line height
              ),
            ),
          ],
        ),
      ),
    );
  }
}
