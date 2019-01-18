import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/model/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex; 

  List<Product> get products{
    return List.from(_products);
  }
  int get selectedProductIndex{
    return _selectedProductIndex;
  }
  Product get selectedProduct{
    return _selectedProductIndex!=null ? _products[_selectedProductIndex] : null;
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void updateProduct(Product updateProduct) {
    _products[_selectedProductIndex] = updateProduct;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index){
    _selectedProductIndex = index;
    notifyListeners();
  }

  void toggleProductFavoriteStatus(){
    final Product updatedProduct = Product( title: selectedProduct.title, 
                                            description: selectedProduct.description,
                                            imageUrl: selectedProduct.imageUrl,
                                            price: selectedProduct.price,
                                            isFavorite:  !selectedProduct.isFavorite);
    _products[selectedProductIndex] = updatedProduct; 
    _selectedProductIndex = null;
    
    notifyListeners();
  }
}
