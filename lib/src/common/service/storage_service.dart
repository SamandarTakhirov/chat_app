// import 'package:firebase_storage/firebase_storage.dart';
//
// abstract class StorageService {
//   static final storage = FirebaseStorage.instance;
//
//   static Future<String> uploadFile(File file) async {
//     final image = storage.ref(Folder.postImages).child(
//         "image_${DateTime.now().toIso8601String()}${file.path.substring(
//           file.path.lastIndexOf("."),)}");
//     final task = image.putqFile(file);
//     await task.whenComplete(() {});
//     return image.getDownloadURL();
//   }
// }

