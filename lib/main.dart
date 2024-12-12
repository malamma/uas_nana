import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Penjualan Mini Market',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://id.pinterest.com/pin/1023161609082213236/ng',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Selamat Datang di Mini Market',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Masuk'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Indomie',
      'price': 3000,
      'image':
          'https://i.pinimg.com/736x/55/6b/b3/556bb383645359b689da912b2705149f.jpg'
    },
    {
      'name': 'Teh Botol',
      'price': 5000,
      'image': 'https://id.pinterest.com/pin/358317714119969187/g'
    },
    {
      'name': 'Susu UHT',
      'price': 10000,
      'image': 'https://example.com/susuuht.png'
    },
    {
      'name': 'Roti Tawar',
      'price': 12000,
      'image': 'https://example.com/rotitawar.png'
    },
  ];

  List<Map<String, dynamic>> cart = []; // Daftar untuk menyimpan item keranjang

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product); // Menambahkan item ke keranjang
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Market'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigasi ke halaman keranjang
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cart: cart),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.network(
                product['image'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product['name'],
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Rp ${product['price']}',
                  style: TextStyle(color: Colors.grey[700])),
              trailing: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Tambah ${product['name']} ke keranjang?'),
                      content: Text(
                          'Apakah Anda ingin membeli ${product['name']} seharga Rp ${product['price']}?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Batal'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            addToCart(product); // Menambahkan item ke keranjang
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${product['name']} berhasil ditambahkan ke keranjang!'),
                              ),
                            );
                          },
                          child: Text('Tambah'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Beli'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cart;

  CartPage({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Belanja'),
      ),
      body: cart.isEmpty
          ? Center(
              child: Text(
                'Keranjang Belanja Anda kosong.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Image.network(
                      item['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Rp ${item['price']}',
                        style: TextStyle(color: Colors.grey[700])),
                  ),
                );
              },
            ),
    );
  }
}
