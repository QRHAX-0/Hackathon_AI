import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../widgets/product_card.dart';
import '../screens/product_screen.dart';
import '../screens/chat_screen.dart';
import '../widgets/custom_nav_bar.dart'; // ✅ استيراد الـ Navigation Bar

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  String filter = "";
  String selectedCategory = "All";
  int _currentIndex = 0;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      products = await ApiService.fetchProducts();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Error: $e";
        isLoading = false;
      });
    }
  }

  void _showFilterDialog() {
    // استخراج جميع الفئات الفريدة من قائمة المنتجات
    Set<String> categories =
        products.map((product) => product.category).toSet();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter By Category"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // زر الفئة "All" لعرض جميع المنتجات
              ListTile(
                title: Text("All"),
                onTap: () {
                  setState(() {
                    selectedCategory = "All";
                  });
                  Navigator.pop(context);
                },
              ),
              // إنشاء قائمة الفئات المتاحة تلقائيًا
              ...categories
                  .map(
                    (category) => ListTile(
                      title: Text(category),
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  )
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // تصفية المنتجات قبل بناء الواجهة
    final filteredProducts =
        products.where((product) {
          return product.name.toLowerCase().contains(filter) &&
              (selectedCategory == "All" ||
                  product.category == selectedCategory);
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search for products...",
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.grey),
            ),
            onChanged: (value) {
              setState(() {
                filter = value.toLowerCase();
              });
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      0.75, // تعديل نسبة العرض إلى الارتفاع لتظهر المنتجات بشكل أوضح
                  crossAxisSpacing: 10, // مسافة بين الأعمدة
                  mainAxisSpacing: 10, // مسافة بين الصفوف
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];

                  return GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ProductScreen(product: product),
                          ),
                        ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      shadowColor: Colors.grey.withOpacity(0.3),
                      child: Column(
                        mainAxisSize:
                            MainAxisSize
                                .min, // ✅ اجعل الـ Column تأخذ أقل مساحة ممكنة
                        children: [
                          /// 🖼 **تكبير الصورة وجعلها مرنة داخل الكارد**
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: Image.network(
                                product.image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          /// 📝 **معلومات المنتج**
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 8,
                            ),
                            child: Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          /// 💰 **سعر المنتج**
                          Text(
                            "${product.price.toStringAsFixed(2)} USD",
                            style: TextStyle(
                              color: Color(0xFFFF6B35),
                              fontSize: 12,
                            ),
                          ),

                          SizedBox(height: 5),

                          /// 🟠 **تصغير الزر + حل مشكلة التمدد**
                          SizedBox(
                            width: 90,
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:Color(0xFFFF6B35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding:
                                    EdgeInsets.zero, // ✅ إزالة الحشوات الزائدة
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            ProductScreen(product: product),
                                  ),
                                );
                              },
                              child: Text(
                                "Read More",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 8), // ✅ تجنب التمدد الزائد
                        ],
                      ),
                    ),
                  );
                },
              ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
