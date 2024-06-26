import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/controllers/cart_controller.dart';
import 'package:lesson64_statemanagement/models/product.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController();
    final _priceController = TextEditingController();

    final product = Provider.of<Product>(context, listen: false);
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("Edit Product"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textController,
                        decoration: const InputDecoration(
                            label: Text("editing product"),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                            label: Text("editing price"),
                            border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                  actions: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    FilledButton(onPressed: () {}, child: const Text("Edit"))
                  ],
                ));
      },
      leading: CircleAvatar(
        backgroundColor: product.color,
      ),
      title: Text(
        product.title,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Text("\$${product.price}"),
      trailing: Consumer<CartController>(
        builder: (context, controller, child) {
          print(product.title);

          return controller.isInCart(product.id)
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.removeFromCart(product.id);
                      },
                      icon: const Icon(Icons.remove_circle),
                    ),
                    Text(
                      controller.getProductAmount(product.id).toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.addToCart(product);
                      },
                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                )
              : IconButton(
                  onPressed: () {
                    controller.addToCart(product);
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                );
        },
      ),
    );
  }
}
