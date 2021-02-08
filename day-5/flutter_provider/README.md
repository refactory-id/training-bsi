# Flutter Provider

Provider merupakah salah satu state management dari flutter yang dirasa simple dan mencukupi kebutuhan state management dari flutter. Provider juga dapat meningkatkan performa dari aplikasi karena provider hanya akan melakukan render ulang pada state yang digunakan saja, selain itu juga provider dapat menyimpan data atau state yang nantinya dapat digunakan oleh lebih dari satu page atau view di dalam aplikasi flutter. Gambaran ketika menggunakan provider pada aplikasi flutter:

![Gif](https://flutter.dev/assets/development/data-and-backend/state-mgmt/state-management-explainer-5495afe6c3d6162f145107fe45794583bc4f2b55be377c76a92ab210be74c033.gif)

Gambaran diatas merupakan salah satu penggunaan app state management seperti provider, dimana pada screen Catalog user memilih produk yang akan dibelinya sehingga produk termasuk ke dalam state cart. State dari cart tersebut ternyata digunakan pada screen Cart sehingga setiap ada perubahan state cart dari screen Catalog maka akan merubah juga pada screen Cart.

## Installation

Tambahkan package provider pada pubspec.yaml:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons:
  provider:
```

## ChangeNotifier

ChangeNotifier merupakan class yang simple didalam SDK Flutter yang menyediakan fitur pemberitahuan setiap ada perubahan state, setiap state didalam ChangeNotifier dapat didaftarkan untuk event ketika ada perubahan nilai dari state.

Pada saat menggunakan ChangeNotifier pastikan untuk membuat enkapsulasi pada state, karena yang dapat mengubah state secara langsung adalah kelas ChangeNotifier. Dalam aplikasi yang sudah kompleks mungkin ada beberapa ChangeNotifier, pastikan bahwa tidak ada duplikasi state untuk setiap ChangeNotifier.

### __Usage__

Penggunaan ChangeNotifier pada flutter:

```dart
class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Item> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Item item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
```

Perhatikan pada method `notifyListeners()`, method ini memberikan pemberitahuan kepada widget atau component yang menggunakan state dari CartModel bahwa ada perubahan value, sehingga widget atau component tersebut akan dirender ulang pada state yang digunakan.

## ChangeNotifierProvider

ChangeNotifierProvider merupakan widget yang menyediakan untuk menampung instance dari ChangeNotifier dan turunannya. 

### __Registing ChangeNotifier__

Perlu diketahui pada gambaran mengenai app state management diatas bahwa state cart akan digunakan di screen Catalog dan screen Cart, maka dari itu untuk membuat instance ChangeNotifier perlu di naikkan levelnya menjadi higher level class pada main method.

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    ),
  );
}
```

Sebagai catatan bahwa ChangeNotifierProvider sudah cukup pintar untuk tidak membangun ulang instance CartModel kecuali memang benar - benar diperlukan, termasuk juga otomatis akan memanggil `dispose()` di dalam CartModel jika memang instance CartModel sudah tidak digunakan lagi.

### __Registing Multiple ChangeNotifier__

Aplikasi yang kompleks mungkin saja membutuhkan lebih dari satu ChangeNotifier, maka dari itu untuk membangun instance ChangeNotifier yang lain dapat menggunakan MultiProvider.

```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => SomeOtherModel()),
      ],
      child: MyApp(),
    ),
  );
}
```

## Consumer

Sekarang CartModel sudah dapat dipanggil di dalam screen Catalog dan Cart, untuk memanggil CartModel bisa dengan menggunakan widget Consumer. Perlu diperhatikan ketika akan menggunakan Consumer dimana harus memberikan ChangeNotifier secara eksplisit pada Consumer menggunakan generic type `<CartModle>`.

```dart
return Consumer<CartModel>(
  builder: (context, cart, child) {
    return Text("Total price: ${cart.totalPrice}");
  },
);
```

### __Best Practise__

Sebagai catatan bahwa dalam memanggil Consumer tidak dilakukan pada top level di widget build, pastikan bahwa memanggil Consumer hanya untuk widget yang membutuhkan saja.

__DON'T DO THIS__

```dart
return Consumer<CartModel>(
  builder: (context, cart, child) {
    return HumongousWidget(
      // ...
      child: AnotherMonstrousWidget(
        // ...
        child: Text('Total price: ${cart.totalPrice}'),
      ),
    );
  },
);
```

__DO THIS__

```dart
return HumongousWidget(
  // ...
  child: AnotherMonstrousWidget(
    // ...
    child: Consumer<CartModel>(
      builder: (context, cart, child) {
        return Text('Total price: ${cart.totalPrice}');
      },
    ),
  ),
);
```

## Read

Terkadang ada beberapa kasus untuk tidak mengubah UI ketika state yang ada di dalam model diubah, sebagai contoh tombol Clear Cart yang akan menghapus state cart. Tombol ini ditekan pada screen Catalog dan tidak ingin melakukan pemberitahuan kepada screen Cart untuk meghilangkan view pada cart. Provider menyediakan sebuah method `context.read<CartModel>()` untuk melakukan hal tersebut.

```dart
context.read<CartProvider>().clearCart();
```