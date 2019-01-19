import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/scoped-models/connected_products.dart';

mixin ProductsModel on ConnectedProductsModel {

  bool _showFavorites = false;

  List<Product> get allProducts{
    return List.from(products);
  }

  List<Product> get displayedProducts{
    if ( _showFavorites ){
      return products.where((product) => product.isFavorite).toList();
    }
      return List.from(products);
  }

  int get selectedProductIndex{
    return selProductIndex;
  }
  Product get selectedProduct{
    return selectedProductIndex!=null ? products[selectedProductIndex] : null;
  }

  bool get displayedFavoritesOnly{
    return _showFavorites;
  }

  void updateProduct(String title, String description, String image, double price){
    final Product updatedProduct = Product(
      title:title, 
      description: description, 
      imageUrl: image, 
      price: price, 
      email: selectedProduct.email,
      id: selectedProduct.id,);

    products[selProductIndex] = updatedProduct;

    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(selectedProductIndex);
    notifyListeners();
  }

  void selectProduct(int index){
    selProductIndex = index;
    notifyListeners();
  }

  void toggleProductFavoriteStatus(){
    final Product updatedProduct = Product( title: selectedProduct.title, 
                                            description: selectedProduct.description,
                                            imageUrl: selectedProduct.imageUrl,
                                            price: selectedProduct.price,
                                            isFavorite:  !selectedProduct.isFavorite,
                                            email:selectedProduct.email,
                                            id: selectedProduct.id);
    products[selectedProductIndex] = updatedProduct; 
    
    notifyListeners();
  }

  void toggleDisplayMode(){
    _showFavorites = ! _showFavorites;
    notifyListeners();
  }
}
