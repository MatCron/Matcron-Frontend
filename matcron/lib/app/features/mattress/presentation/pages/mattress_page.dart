import 'package:flutter/material.dart';
import 'package:matcron/app/features/mattress/presentation/pages/import_page.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/constants/constants.dart';

class MattressPage extends StatefulWidget {
  const MattressPage({super.key});

  @override
  MattressPageState createState() => MattressPageState();
}

class MattressPageState extends State<MattressPage> {
  // Placeholder for the list of mattresses
  List<Map<String, String>> mattresses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor("#E5E5E5"),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {

              },
              decoration: InputDecoration(
                hintText: "Search mattresses",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0)
              ),
            ),
            const SizedBox(height: 10.0,),
            // Add Mattress and Import Mattress buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to add mattress page (to be implemented)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: matcronPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  child: const Text(
                    "+ Add Mattress",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to import mattress page
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const ImportMattressPage(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: matcronPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  child: const Text(
                    "Import Mattress",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),

            // Table headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Type",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Store",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Status",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.black26),

            // Placeholder for mattresses list
            Expanded(
              child: mattresses.isEmpty
                  ? Center(
                      child: Text(
                        "No mattresses available",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: mattresses.length,
                      itemBuilder: (context, index) {
                        final mattress = mattresses[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  mattress['type'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  mattress['store'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  mattress['status'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54,
                                  ),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
