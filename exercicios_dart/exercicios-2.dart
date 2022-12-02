// ignore_for_file: unused_local_variable, unnecessary_type_check
int sum(int a, int b) {
  return a + b;
}

int exec(int a, int b, int Function(int, int) fn) {
  return fn(a, b);
}

imprimirProduct(int qtd, {String? name, double? price}) {
  for (var i = 0; i < qtd; i++) {
    print('The product ${name} have price \$${price}');
  }
}

class Product {
  String? name;
  double? price;

  //Product(this.name, this.price);
  //Product({this.name, this.price});
  Product({this.name, this.price = 2.00});

  /* Product(String name, double price) {
    this.name = name;
    this.price = price;
  } */
}

main() {
  final result1 = sum(2, 3);
  print('The value of sum is: ${sum(1, 2)}');
  print('The value of sum is: $result1');
  print('\n');

  final result2 = exec(2, 3, (a, b) => a * b + 100);
  print('The result is: $result2');
  print('\n');

  var product1 = new Product(name: 'Test', price: 3.49);
  product1.name = 'Pen';
  product1.price = 4.49;
  print('The product ${product1.name} have price \$${product1.price}');

  var product2 = new Product(price: 1.32, name: 'Pencil');
  print('The product ${product2.name} have price \$${product2.price}');

  var product3 = new Product(name: 'paper');
  imprimirProduct(2, price: product3.price, name: product3.name);
  print('\n');
}
