
import 'package:flutter/material.dart';

class ProductPopup extends StatefulWidget {
  final void Function(String,String,String,String) addNewProduct;
  const ProductPopup(this.addNewProduct, {super.key});
  @override
  State<ProductPopup> createState() => _ProductPopupState();
}

class _ProductPopupState extends State<ProductPopup> {
  TextEditingController productName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController productId = TextEditingController();

  Future<void> addProduct() async{
      widget.addNewProduct(productId.text,productName.text,description.text,image.text);
      Navigator.pop(context);
      // Navigator.pop(context);
    }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(30), topRight: Radius.circular(30) )
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
          children: [
            Card(

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: TextFormField(
                  decoration: const InputDecoration(hintText:'Product ID',border: InputBorder.none ),
                  keyboardType: TextInputType.number,
                  controller: productId,
                ),
              ),
            ),
            Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: TextFormField(
                  decoration: const InputDecoration(hintText:'Product Name',border: InputBorder.none ),
                  controller: productName,
                ),
              ),
            ),
            Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: TextFormField(
                  decoration: const InputDecoration(hintText:'Image URL',border: InputBorder.none ),
                  controller: image,
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: TextFormField(
                  decoration: const InputDecoration(hintText:'Description',border: InputBorder.none ),
                  controller: description,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                        child: ElevatedButton(onPressed: (){addProduct();},style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),backgroundColor: Colors.pinkAccent,foregroundColor: Colors.white), child: const Text('Add Product'),))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
