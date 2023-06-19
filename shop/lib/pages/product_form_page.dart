import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final priceFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final imageUrlFocus = FocusNode();
  final imageUrlController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formData = <String, Object>{};

  @override
  void initState() {
    super.initState();
    imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        formData['id'] = product.id;
        formData['name'] = product.name;
        formData['price'] = product.price;
        formData['description'] = product.description;
        formData['imageUrl'] = product.imageUrl;

        imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    priceFocus.dispose();
    descriptionFocus.dispose();
    imageUrlFocus.dispose();
    imageUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  void _submitForm() {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    formKey.currentState?.save();

    Provider.of<ProductList>(context, listen: false).saveProduct(formData);
    Navigator.of(context).pop();
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.endsWith('.jpeg');

    return isValidUrl && endsWithFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Product'),
        actions: <Widget>[
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: formData['name']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(priceFocus);
                },
                onSaved: (name) => formData['name'] = name ?? '',
                validator: (paramName) {
                  final name = paramName ?? '';

                  if (name.trim().isEmpty) {
                    return 'Name is required';
                  }

                  if (name.trim().length < 3) {
                    return 'Name needs 3 letters at least.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: formData['price']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                focusNode: priceFocus,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(descriptionFocus);
                },
                onSaved: (price) =>
                    formData['price'] = double.parse(price ?? '0'),
                validator: (paramPrice) {
                  final priceString = paramPrice ?? '-1';
                  final price = double.tryParse(priceString) ?? -1;

                  if (price <= 0) {
                    return 'Price is required';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: formData['description']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                textInputAction: TextInputAction.next,
                focusNode: descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(imageUrlFocus);
                },
                onSaved: (description) =>
                    formData['description'] = description ?? '',
                validator: (paramDescription) {
                  final description = paramDescription ?? '';

                  if (description.trim().isEmpty) {
                    return 'Description is required';
                  }

                  if (description.trim().length < 10) {
                    return 'Name needs 10 letters at least.';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                      ),
                      textInputAction: TextInputAction.done,
                      focusNode: imageUrlFocus,
                      keyboardType: TextInputType.url,
                      controller: imageUrlController,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved: (imageUrl) =>
                          formData['imageUrl'] = imageUrl ?? '',
                      validator: (paramImageUrl) {
                        final imageUrl = paramImageUrl ?? '';

                        if (!isValidImageUrl(imageUrl)) {
                          return 'Please enter a valid URL.';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: imageUrlController.text.isEmpty
                        ? const Text('Put image URL')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(imageUrlController.text),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
