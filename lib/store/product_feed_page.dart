import 'package:beespokeai/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:beespokeai/store/product.dart';



//cart items properties
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

// cart 
class Cart {
  final List<CartItem> items = [];
}

class ProductFeedPage extends StatefulWidget {
  const ProductFeedPage({super.key});

  @override
  _ProductFeedPageState createState() => _ProductFeedPageState();
}

class _ProductFeedPageState extends State<ProductFeedPage> {
  List<Product> allProducts = [];  //to store all the products fetched through api
  List<Product> displayedProducts = [];  // will store the searched products only 
  List<String> searchHistory = [];  // will store the search history of the user
  String? selectedCategory;     // will save the selection of the category
  final Cart _cart = Cart();    // to add items to the cart

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

// fetching the api using HTTP get request and mapping and storing it to the allProducts after parsing.
  Future<void> _loadProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          allProducts = jsonData.map((item) => Product.fromJson(item)).toList();
          displayedProducts = List.from(allProducts);
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print(error);
    }
  }

// filter products by category
  void _filterProductsByCategory(String? category) {
    if (category != null) {
      setState(() {
        selectedCategory = category;
        displayedProducts = allProducts
            .where((product) => product.category == category)
            .toList();
      });
    } else {
      // No category filter applied, display all products
      setState(() {
        selectedCategory = null;
        displayedProducts = List.from(allProducts);
      });
    }
  }


// search products 
  void _searchProducts(String query) {
    if (query.isNotEmpty) {
      setState(() {
        displayedProducts = allProducts
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()) ||
                product.description.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });

      // in the search history as we type along it will filter the history 
      final filteredHistory = searchHistory
          .where(
              (history) => history.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        searchHistory = filteredHistory;
      });

      if (!searchHistory.contains(query)) {
        setState(() {
          searchHistory.insert(0, query);
        });
      }
    } else {
      // No search query, display all products
      setState(() {
        displayedProducts = List.from(allProducts);
      });
    }
  }


// truncating the description to make it look evenly with other product cards
  String truncateDescription(String description, int maxLength) {
    if (description.length <= maxLength) {
      return description;
    }
    return '${description.substring(0, maxLength)}...';
  }

// Function to add products to the shopping cart
  void _addToCart(Product product) {
    final existingItemIndex = _cart.items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingItemIndex != -1) {
      // Product already in cart, increase quantity
      _cart.items[existingItemIndex].quantity++;
    } else {
      // Product not in cart, add as a new item
      _cart.items.add(CartItem(product: product));
    }

// printing message in the bottom once user added a product to the cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to cart: ${product.title}'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/logo.png',
                width: 240,
                height: 55), 
            const SizedBox(
                width: 8), 
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 186, 143, 239),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              // search option at the top
              child: TextField(
                onChanged: _searchProducts,
                decoration: const InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            if (searchHistory.isNotEmpty)
              Container(
                color: Colors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(searchHistory[index]),
                      onTap: () {
                        // Trigger a search with the selected history item
                        _searchProducts(searchHistory[index]);
                      },
                    );
                  },
                ),
              ),
              // filter the product by category
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Filter by Category',
                ),
                value: selectedCategory,
                onChanged: _filterProductsByCategory,
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    //default category
                    child: Text('All Categories'),
                  ),
                  ...allProducts
                      .map((product) => product.category)
                      .toSet()
                      .toList()
                      .map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: displayedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = displayedProducts[index];
                  return Card(
                    elevation: 4, 
                    margin: const EdgeInsets.all(
                        8), 
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(
                          16),
                      title: Text(
                        product.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        truncateDescription(product.description,
                            100), 
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            // showing price
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              _addToCart(
                                  product); 
                            },
                          ),
                        ],
                      ),
                      // image will be used 
                      leading: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(product.image),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      //drawer 
      drawer: MyDrawer(
        child: ListView(),
      ),
    );
  }
}
