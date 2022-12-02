// ignore_for_file: unused_local_variable, unnecessary_type_check
main() {
  print('Hello World!\n');

  int a = 3;
  double b = 3.1;
  var c = 'Hello World!';
  bool d = false;
  print(c is String || d);
  print('\n');

  var names = ['Ana', 'Bia', 'Carlos'];
  names.add('Daniel');
  names.add('Junior');
  names.add('Uriel');
  print(names.length);
  print(names.elementAt(0));
  print(names[5]);
  print('\n');

  var group = {0, 1, 2, 3, 4, 5, 6};
  print(group.length);
  print(group is Set);
  print('\n');

  Map<String, double> studentsGrade = {'Ana': 9.7, 'Bia': 9.2, 'Carlos': 7.8};
  for (var key in studentsGrade.keys) {
    print('key = $key');
  }
  print('\n');
  for (var values in studentsGrade.values) {
    print('value = $values');
  }
  print('\n');
  for (var entries in studentsGrade.entries) {
    print('${entries.key} = ${entries.value}');
  }
  print('\n');

  dynamic x = 'Teste';
  x = 123;
  x = false;
  print(x);
  print('\n');

  final w = 3;
  const q = 5;
}
