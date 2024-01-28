import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'login_page.dart'; // Import your login page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Initialize FirebaseAuth and FirebaseStorage instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Declare variables to hold the current user and a list of image URLs
  User? _user;
  List<String> _imageUrls = [];

  // Override the initState method to perform initialization tasks
  @override
  void initState() {
    super.initState();
    _getUser();
    _loadImages();
  }
// Define the method to get the current user
  Future<void> _getUser() async {
    User? user = _auth.currentUser;
    setState(() {
      _user = user;
    });
  }

 // Define a method to load images for the current user
  Future<void> _loadImages() async {
    try {
      if (_user != null) {
        // Define the user's folder in Firebase Storage
        String userFolder = 'userImages/${_user!.uid}';
        // List files in the user's folder and retrieve download URLs
        ListResult result = await _storage.ref(userFolder).list();
        List<String> urls =
            await Future.wait(result.items.map((ref) => ref.getDownloadURL()));

// Update the state with the loaded image URLs
        setState(() {
          _imageUrls = urls;
        });
      }
    } catch (e) {
      print('Error loading images: $e');
    }
  }

// Define a method to pick an image file and upload it to Firebase Storage
  Future<void> _pickAndUploadImage() async {
    try {
      // Open the file picker to select an image
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

// If a file is picked and a user is authenticated, proceed with upload
      if (result != null && _user != null) {
        PlatformFile file = result.files.first;
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        String userFolder = 'userImages/${_user!.uid}';
        String filePath = '$userFolder/$fileName';

// Upload the image file to Firebase Storage and retrieve its download URL
        await _storage.ref(filePath).putData(file.bytes!);
        String downloadUrl = await _storage.ref(filePath).getDownloadURL();

// Update the state with the new download URL
        setState(() {
          _imageUrls.add(downloadUrl);
        });
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

// Build the UI for the HomePage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Image Wallet'),
        actions: [
          // Display a logout button if a user is authenticated
          _user != null
              ? IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () async {
                    // Sign out the user and navigate to the LoginPage
                    await _auth.signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage())); // Navigate to LoginPage
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
      body: GridView.builder(
        // Display images in a GridView
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: _imageUrls.length,
        itemBuilder: (context, index) {
          // Create a clickable image in the GridView
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => FullScreenImage(imageUrl: _imageUrls[index]))),
            child: Image.network(_imageUrls[index], fit: BoxFit.cover),
          );
        },
      ),
      // Display a floating action button to pick and upload images
      floatingActionButton: FloatingActionButton(
        onPressed: _pickAndUploadImage,
        child: Icon(Icons.add),
      ),
    );
  }
}

// Define a FullScreenImage widget to display an image in full screen
class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}