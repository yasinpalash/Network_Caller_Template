// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:network_caller/controllers/create_list.dart';
//
// class ProductForm extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//
//   // Controllers for the text fields
//   final TextEditingController productNameController = TextEditingController();
//   final TextEditingController productCodeController = TextEditingController();
//   final TextEditingController imgController = TextEditingController();
//   final TextEditingController unitPriceController = TextEditingController();
//   final TextEditingController qtyController = TextEditingController();
//   final TextEditingController totalPriceController = TextEditingController();
//   final CreateListController createListController =
//       Get.put(CreateListController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product Form'),
//         backgroundColor: Colors.teal,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildTitle('Product Details'),
//               SizedBox(height: 20),
//               _buildTextField(
//                 controller: productNameController,
//                 label: 'Product Name',
//                 icon: Icons.label,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a product name';
//                   }
//                   return null;
//                 },
//               ),
//               _buildTextField(
//                 controller: productCodeController,
//                 label: 'Product Code',
//                 icon: Icons.code,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a product code';
//                   }
//                   return null;
//                 },
//               ),
//               _buildTextField(
//                 controller: imgController,
//                 label: 'Image URL',
//                 icon: Icons.image,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an image URL';
//                   }
//                   return null;
//                 },
//               ),
//               _buildTextField(
//                 controller: unitPriceController,
//                 label: 'Unit Price',
//                 icon: Icons.attach_money,
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a unit price';
//                   }
//                   return null;
//                 },
//               ),
//               _buildTextField(
//                 controller: qtyController,
//                 label: 'Quantity',
//                 icon: Icons.production_quantity_limits,
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter quantity';
//                   }
//                   return null;
//                 },
//               ),
//               _buildTextField(
//                 controller: totalPriceController,
//                 label: 'Total Price',
//                 icon: Icons.attach_money_outlined,
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the total price';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 30),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       createListController.createList(
//                           productCodeController.text,
//                           productCodeController.text,
//                           imgController.text,
//                           unitPriceController.text,
//                           qtyController.text,
//                           totalPriceController.text);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     backgroundColor: Colors.teal,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: Text('Submit', style: TextStyle(fontSize: 18)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTitle(String title) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//         color: Colors.teal,
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//     required String? Function(String?) validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: Colors.teal),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(color: Colors.teal),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(color: Colors.teal),
//           ),
//         ),
//         keyboardType: keyboardType,
//         validator: validator,
//       ),
//     );
//   }
// }
