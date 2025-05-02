import 'package:flutter/material.dart';

class MattressDimensionsPage extends StatelessWidget {
  const MattressDimensionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarColor= theme.colorScheme.primary;
    final backgroundColor =theme.colorScheme.surface;
    final primaryColor = theme.colorScheme.primary;

    // Dynamic styles
    final titleStyle = TextStyle(
      fontSize: screenWidth * 0.06, 
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.onPrimary,
    );
    final labelStyle = TextStyle(
      fontSize: screenWidth * 0.035, 
      color: theme.colorScheme.onSurface,
      fontStyle: FontStyle.italic,
    );
    final valueStyle = TextStyle(
      fontSize: screenWidth * 0.04, 
      color:theme.colorScheme.onSurface.withOpacity(0.32),
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
           automaticallyImplyLeading: false,
        leading: IconButton(
          
          icon: Text(
            "<",
            style: TextStyle(
              fontSize: screenWidth * 0.08,
              color: theme.colorScheme.surface, 
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Mattress Dimensions", style: titleStyle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Here are the detailed dimensions of your mattress. Use this information to ensure proper fitting in your bed frame and bedding.",
                style: TextStyle(fontSize: screenWidth * 0.04, color: theme.colorScheme.onSurface),
              ),
              SizedBox(height: screenHeight * 0.02),

              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color:theme.colorScheme.onSurface.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Image.asset(
                    'assets/images/bedmeasuring.png',
                    width: screenWidth * 0.8, 
                    height: screenHeight * 0.2,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDimensionColumn("Length", "80 inches", labelStyle, valueStyle, primaryColor),
                  _buildDimensionColumn("Width", "60 inches", labelStyle, valueStyle, primaryColor),
                  _buildDimensionColumn("Depth/Height", "10 inches", labelStyle, valueStyle, primaryColor),
                ],
              ),

              SizedBox(height: screenHeight * 0.04),

              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color:theme.colorScheme.onSecondary,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Text(
                  "All measurements are approximate and can vary slightly. Ensure to measure your bed frame and confirm that these dimensions meet your room’s space requirements.",
                  style: TextStyle(fontSize: screenWidth * 0.035, color: theme.colorScheme.onSurface),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDimensionColumn(
    String label,
    String value,
    TextStyle labelStyle,
    TextStyle valueStyle,
    Color primaryColor,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(value, style: valueStyle),
        ),
      ],
    );
  }
}
