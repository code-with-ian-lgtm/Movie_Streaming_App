import 'package:flutter/material.dart';

class Profile {
  final String name;
  final String imageUrl;

  Profile({required this.name, required this.imageUrl});
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Profile> profiles = [
    Profile(name: 'Code with Ian', imageUrl: 'https://i.pinimg.com/236x/b2/a0/29/b2a029a6c2757e9d3a09265e3d07d49d.jpg'),
    Profile(name: 'User 2', imageUrl: 'https://i.pinimg.com/236x/1b/a2/e6/1ba2e6d1d4874546c70c91f1024e17fb.jpg'),
    Profile(name: 'User 3', imageUrl: 'https://i.pinimg.com/236x/61/54/76/61547625e01d8daf941aae3ffb37f653.jpg'),
    Profile(name: 'User 4', imageUrl: 'https://i.pinimg.com/236x/af/0c/43/af0c439f59d291b2a3ece1c958d6b3bf.jpg'),
  ];

  int selectedProfileIndex = -1; 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Select Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Profiles',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  final profile = profiles[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedProfileIndex = index; 
                      });
                    },
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedProfileIndex == index
                                        ? Colors.blue 
                                        : Theme.of(context).colorScheme.secondary,
                                    width: 4,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    profile.imageUrl,
                                    width: 80, 
                                    height: 80, 
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        color: Theme.of(context).colorScheme.inversePrimary, 
                                        alignment: Alignment.center,
                                        child: const Icon(Icons.error, color: Colors.white),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              if (selectedProfileIndex == index)
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue, 
                                    ),
                                    width: 24,
                                    height: 24,
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            profile.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center, 
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            //Add profile section
            ElevatedButton(
             
              onPressed: (){}, 
              child: Text("Add Profile"))

          ],
        ),
      ),
    );
  }
}
