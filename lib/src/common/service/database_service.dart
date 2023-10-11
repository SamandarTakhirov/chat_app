import 'package:firebase_database/firebase_database.dart';

 class DatabaseService{
  const DatabaseService();

  static final _database = FirebaseDatabase.instance;

  Stream<DatabaseEvent> readAllData(String dataPath)=> _database.ref(dataPath).onValue.asBroadcastStream();

  DatabaseReference queryFromPath(String dataPath)=> _database.ref(dataPath);

  Future<void>create(
      String dataPath,
      Map<String,Object?>json,
      )async {
    final id = _database.ref(dataPath).push().key;
    json['id']=id;

    await _database.ref(dataPath).child(id!).set(json);


  }
  Future<void>delete(String dataPath,String id)=> _database.ref(dataPath).child(id).remove();

  Future<void>update({
    required String dataPath,
    required String id,
    required Map<String,Object?>json,
})=> _database.ref(dataPath).child(id).update(json);
}