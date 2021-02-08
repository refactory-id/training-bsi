# Flutter BLoC

BLoC merupakah salah satu state management cukup populer dalam kebutuhan state management dari flutter. BLoC juga dapat meningkatkan performa dari aplikasi karena BLoC hanya akan melakukan render ulang pada state yang digunakan saja dan state tersebut berbeda value dengan state sebelumnya, selain itu juga BLoC dapat menyimpan data atau state yang nantinya dapat digunakan oleh lebih dari satu page atau view di dalam aplikasi flutter. Gambaran ketika menggunakan BLoC pada aplikasi flutter:

![Gif](https://flutter.dev/assets/development/data-and-backend/state-mgmt/state-management-explainer-5495afe6c3d6162f145107fe45794583bc4f2b55be377c76a92ab210be74c033.gif)

Gambaran diatas merupakan salah satu penggunaan app state management seperti BLoC, dimana pada screen Catalog user memilih produk yang akan dibelinya sehingga produk termasuk ke dalam state cart. State dari cart tersebut ternyata digunakan pada screen Cart sehingga setiap ada perubahan state cart dari screen Catalog maka akan merubah juga pada screen Cart.

## Arcitecture

BLoC atau Bussiness Logic on Component memudahkan programmer flutter untuk memisahkan antara view dan bussiness logic, sehingga kode menjadi lebih maintainable karena view tidak memiliki tanggung jawab selain menampilkan UI berdasarkan state.

![images](https://bloclibrary.dev/assets/bloc_architecture_full.png)

Gambar architetcure diatas menjelaskan bahwa UI baik itu Page, Widget mapun Component akan mengirimkan UI Event seperti klik, select, text input, dsb. yang sebenarnya akan menjalan sebuah perintah untuk memanggil request data dari API melalui BLoC terlebih dahulu. BLoC akan memberikan bussiness logic berdasarkan event yang diminta dari UI, semisal event untuk mendapatkan semua list dari user maka akan memanggil event dengan kriteria tersebut. Setelah server memberikan response kepada aplikasi maka BLoC akan meengubah state aplikasi sambil menyimpan data dari server yang kemudian BLoC akan memberikan notifikasi bahwa state sudah berubah kepada UI.

## Installation

Tambahkan package flutter_bloc dan equatable pada pubspec.yaml:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_staggered_grid_view:
  cupertino_icons:
  flutter_bloc:
  equatable:
  dio:
```

## Equatable

Equatable merupakan sebuah package yang berguna dalam menangani state atau event di bloc, equatable disini akan memberikan kemudahan bagi state management dalam melakukan listener ketika ada perubahan state. Kemudahan yang diberkan oleh equatable adalah tidak akan melakukan notifikasi kepada bloc kalau ada persamaan antara state sebelumnya dengan state sekarang sehingga tidak perlu merender ulang widget kalau tidak ada perubahan state.

## BLoC State

BLoC State merupakan sebuh class BLoC yang menampung keadan atau posisi sekarang dari aplikasi, BLoC juga dapat menyimpan data jika memang state dari aplikasi akan menyimpan data seperti berhasil mendapatkan response dari REST API. 

```dart
abstract class ProductState extends Equatable {}

class LoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

class ErrorState extends ProductState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SuccessState extends ProductState {
  final List<ProductModel> products;

  SuccessState(this.products);

  @override
  List<Object> get props => [products];
}
```

## BLoC Event

BLoC Even merupakan sebuah pemicu untuk BLoC menjalankan bussiness logic pada aplikasi, berarti event akan menyesuaikan bussiness logic yang akan dijalankan termasuk state yang akan diberikan kepada aplikasi.

```dart
class GetAllProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}
```

## BLoC

BLoC disini berarti komponen terpenting, karena BLoC akan melakukan mapping dari event menjadi sebuah state, disesuaikan dengan bussines logic yang panggil berdasarkan eventnya.

```dart
class ProductBloc extends Bloc<GetAllProductEvent, ProductState> {
  final ProductRepo repo;

  ProductBloc(this.repo) : super(null);

  @override
  Stream<ProductState> mapEventToState(GetAllProductEvent event) async* {
    yield LoadingState();

    try {
      yield SuccessState((await repo.getAllProducts()));
    } catch (e) {
      yield ErrorState(e?.message ?? "Oops something went wrong!");
    }
  }
}
```

## BlocBuilder

BlocBuilder adalah widget flutter yang membutuhkan generic type Event dan State yang akan meresponse ketika ada perubahan state, BlocBuilder sama seperti dengan Consumer dari Provider.

```dart
BlocBuilder<ProductBloc, ProductState>(
  builder: (context, state) {
    if (state is LoadingState) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    } else if (state is ErrorState) {
      return Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              color: Colors.red,
              size: 48,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(state.message),
            )
          ],
        ),
      );
    } else if (state is SuccessState) {
      return Column(
        children: [
          Expanded(child: ProductsWidget(state.products)),
          ButtonWidget(
              text: "CLEAR CART",
              onClick: () => context.read<CartBloc>().add(ClearCartEvent()))
        ],
      );
    }

    return Container();
  },
);
```

## BlocProvider

BlocBuilder merupakan widget yang menyediakan bloc untuk semua widget, cara pemanggilannya cukup dengan menggunakan `BlocProvider.of<T>(context)`. BlocProvider digunakan untuk Dependency Injection Bloc kepada widget sehingga semua widget akan memakai bloc yang sama (singleton), tanpa harus memakai bloc yang berbeda yang mengakibatkan adanya perbedaan state antar widget.

```dart
BlocProvider<MenuBloc>(
  create: (_) => MenuBloc(),
  child: MyApp(),
);
```

## MultiBlocProvider

MultiBlocProvider merupakan widget yang akan menampung banyak BlocProvider ke dalam satu widget, MultiBlocProvider memudahkan dalam pembacaan kode karena mengurangi nested BlocProvider (didalam BlocProvider ada BlocProvider).

```dart
runApp(MultiBlocProvider(
  providers: [
    BlocProvider<MenuBloc>(
      create: (_) => MenuBloc(),
    ),
    BlocProvider<CartBloc>(
      create: (_) => CartBloc(),
    ),
    BlocProvider<ProductBloc>(
      create: (_) => ProductBloc(productRepo),
    ),
  ],
  child: MyApp(),
));
```

## Call BLoC Event with Read

Dalam memanggil sebuah BLoC Event dari sebuah aksi dari user sebaiknya menggunakan method read dari BLoC, kemudian panggil method add() yang berisikan Event yang akan dipanggil.

```dart
ButtonWidget(
  text: "CLEAR CART",
  onClick: () => context.read<CartBloc>().add(ClearCartEvent()));
```