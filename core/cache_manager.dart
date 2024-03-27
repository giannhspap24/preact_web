import 'package:get_storage/get_storage.dart';

mixin CacheManager {

  //Save token to cache memory
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  //Return token from cache memory
  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  //Delete token from cache memory, token is then null
  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }

  //Return global URL
  String getGlobalURl(){
    //final String globalUrl = 'http://localhost:8080/preact/HelloServlet';
    //final String globalUrl = 'http://192.168.56.101:8080/preact/HelloServlet';
    //final String globalUrl = 'http://195.251.234.22:8080/preact/HelloServlet';
    return 'http://localhost:8080/preact/HelloServlet';
  }
}

enum CacheManagerKey { TOKEN }
