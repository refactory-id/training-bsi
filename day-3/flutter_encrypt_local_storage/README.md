# Flutter Encrypt Local Storage

Enkripsi data yang disimpan pada local storage pada aplikasi Flutter, hal ini sangat penting untuk menjaga kerahasian data user. Perlu diketahui local storage sebenarnya akan menyimpan data dalam bentuk file yang nantinya bisa saja di lihat oleh orang lain untuk menghidari hal tersebut, perlu dilakukan sebuah encryption untuk menjaga data user terlebih untuk data yang bersifat sensitif seperti credential.

## Local Storage

Local storage merupakan fitur yang tersedia di semua platfrom, local storage berguna untuk menyimpan data secara local yang berbasis key dan value. Penyimpanan local storage bersifat tetap namun user dapat menghapusnya dengan cara clear cache, clear data atapun dengan uninstall aplikasi. 

Local storage cukup berguna untuk menyimpan session dimana user tidak perlu login kembali ketika sudah pernah login sebelumnya, namun local storage belum tentu menyimpan data bentuk yang aman. Untuk menjaga keamanan data perlu dilakukan encryption yang berarti data yang disimpan akan di encrypt dalam bentuk yang tidak semua orang mengetahui data aslinya dan ketika data tersebut dibutuhkan maka data yang dihasilkan akan di decrypt dalam bentuk yang sudah bisa dibaca oleh orang. Hindari penyimpanan data dalam bentuk Hash seperti: md5, SHA, dsb. Penyimpanan data lokal dalam bentuk hash akan menyulitkan server ketika data yang dikirimkan adalah dalam bentuk hash, karena data dalam bentuk hash sulit atau bahkan tidak bisa di decrypt.

Beberapa local storage di dalam aplikasi Flutter:

1. SharedPrefences
2. Hive
3. Dsb.

### __Local Storage Hive__

Hive merupakan sebuah database ringan yang berbasis key dan value, cepat dalam melakukan pembukaan database dan ditulis dengan bahasa murni Dart.

Hive menjadi local storage yang popular pada aplikasi flutter, karena proses writenya yang lebih cepat dibandingkan dengan SharedPreferences. Berikut ini merupakan hasil benchmarking antara Hive, SharePreferences dan SQLite.

Pembacaan data dengan seribu perulangan:

![images](https://raw.githubusercontent.com/hivedb/hive/master/.github/benchmark_read.png)

Penulisan data dengan seribu perulangan:

![images](https://raw.githubusercontent.com/hivedb/hive/master/.github/benchmark_write.png)

Penggunaan local storage Hive cukup mudah, pertama tambahkan hive, hive_flutter dan path_provider pada pubspec.yaml:

```yaml
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons:
  path_provider:
  hive_flutter:
  hive:
```

Sebelum memakai Hive, lakukan initialisasi Hive terlebih dahulu di main function. Hal ini dilakukan agar nantinya ketika membuka Hive tidak perlu menggunakan await untuk setiap pemanggilannya, cukup di main function saja.

__main.dart__
```dart
void main() async {
  final box = await initHive();

  AppComponent.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => AuthProvider(AppComponent.injector.get(), box)),
    ],
    child: MyApp(),
  ));
}

Future<Box<dynamic>> initHive() async {
  WidgetsFlutterBinding.ensureInitialized();

  final path = (await getApplicationDocumentsDirectory()).path;

  Hive.init(path);

  return Hive.openBox("myBox");
}
```

Setelah melakukan inisialisasi, hive dapat digunakan. Hive mempunyai istilah Box yang merupakan wadah untuk menyimpan data pada Hive, mungkin seperti table jika di ibaratkan dalam  database tapi tidak terstruktur dan dapat berisikan apapun.

Penyimpanan data menggunakan Hive dapat dilakukan dengan menggunakan perintah put dengan argument key dan value dan putAll untuk menyimpan data dalam bentuk `Map<Key, Value>`, kurang lebih seperti dibawah ini untuk melakukan write pada local storage Hive:

```dart
final box = Hive.box('myBox');

box.put('name', 'Paul');
box.put('friends', ['Dave', 'Simon', 'Lisa']);
box.put(123, 'test');

box.putAll({'key1': 'value1', 42: 'life'});
```

Membaca data pada Hive dapat dilakukan dengan menggunakan perintah get yang meminta argument key dan secara option defaultValue untuk memberikan nilai selain null ketika datanya null, kurang lebih seperti bawah ini untuk melakukan read data pada Hive:

```dart
final box = Hive.box('myBox');

final name = box.get('name');
final List<String> friends = box.get('friends', defaultValue: <String>[])
```

Menghapus data pada Hive dapat dilakukan dengan menggunakan perintah delete dengan menerima argument key yang akan menghapus data berdasarkan key, deleteAll dengan menerima argument Iterable dari key yang akan menghapus data berdasarkan key yang ada didalam argument dan clear untuk menghapus semua data. Lebih detailnya bisa dilihat pada kode dibawah ini:

```dart
final box = Hive.box('myBox');

box.delete('name');
box.deleteAll(['friends', 123]);
box.clear();
```

### __Encrypted Data in Hive__

Ada banyak cara untuk melakukan encrypt data, salah satunya dengan menggunakan metode base64. Metode base64 ini mudah dipakai dan cukup efektif untuk menyembunyikan data. Lebih jelasnya bisa lihat kode dibawah ini:

```dart
import 'dart:convert';

String encode(String value) {
  return base64.encode(utf8.encode(value));
}

String decode(String value) {
  return utf8.decode(base64.decode(value));
}
```

Implementasi dari encrpyt data pada Hive yang paling simple ialah dengan menyimpan data pada Box ke dalam bentuk base64 atau dapat menggunakan perintah encode diatas baru kemudian disimpan pada Box. Lebih jelasnya bisa lihat kode dibawah ini:

```dart
void _saveUser(UserModel user) {
  Box<dynamic> box = Hive.box("flutter_encrypt_local_storage");
  
  box.putAll({
    "name": encode(user.name),
    "email": encode(user.email),
    "token": encode("Bearer ${user.token}")
  });
}
```

Semisal data yang disimpan pada Hive akan digunakan cukup hanya memanggil perintah decode diatas, kemudian data yang digunakan dapat dibaca dengan jelas. Lebih jelasnya bisa lihat kode dibawah ini:

```dart
Box<dynamic> box = Hive.box("flutter_encrypt_local_storage");

String rawName = box.get("name", defaultValue: "");
String name = decode(box.get("name", defaultValue: ""));
String rawEmail = box.get("email", defaultValue: "");
String email = decode(box.get("email", defaultValue: ""));
String rawToken = box.get("token", defaultValue: "");
String token = decode(box.get("token", defaultValue: ""));
```