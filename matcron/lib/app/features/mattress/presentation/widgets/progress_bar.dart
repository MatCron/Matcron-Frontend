import 'package:flutter/material.dart';
import 'package:matcron/core/constants/constants.dart';

class ProgressBar extends StatelessWidget {
  final int currentStep; // Step index: 1, 2, or 3
  final List<String> labels; // List of customizable labels for each step

  const ProgressBar({
    super.key,
    required this.currentStep,
    required this.labels, // Accept list of labels
  });

  Color _getCircleColor(int step) {
    return step <= currentStep ? matcronPrimaryColor : Colors.grey;
  }

  Color _getDotColor(int step) {
    return step < currentStep ? matcronPrimaryColor : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // First Circle
        _buildCircle(1),

        // Dots between Circle 1 and Circle 2
        _buildDots(1),

        // Second Circle
        _buildCircle(2),

        // Dots between Circle 2 and Circle 3
        _buildDots(2),

        // Third Circle
        _buildCircle(3),
      ],
    );
  }

  Widget _buildCircle(int step) {
  return Column(
    mainAxisSize: MainAxisSize.min, // Ensures the column size adjusts to the content
    children: [
      CircleAvatar(
        radius: 15.0,
        backgroundColor: _getCircleColor(step),
      ),
      const SizedBox(height: 4.0),
      // Add a SizedBox to give fixed height to the text
      SizedBox(
        width: 70.0,  // Adjust the height to suit your design
        child: Center(
          child: Text(
            currentStep == step
                ? (labels.isNotEmpty && labels.length >= step
                    ? labels[step - 1]
                    : "Step $step")
                : "",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: currentStep == step ? FontWeight.bold : FontWeight.normal,
              color: matcronPrimaryColor,
            ),
            textAlign: TextAlign.center, // Ensure text is centered
          ),
        ),
      ),
    ],
  );
}


  Widget _buildDots(int step) {
    return Transform.translate(
      offset: const Offset(0, -11), // Move dots upwards by 11 pixels
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0), // Space between dots
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getDotColor(step),
            ),
          ),
        ),
      ),
    );
  }
}
