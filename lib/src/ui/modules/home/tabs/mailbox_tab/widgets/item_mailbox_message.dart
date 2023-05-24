// import 'package:flutter/material.dart';

// class ItemMailboxMessage extends StatelessWidget {
//   const ItemMailboxMessage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Row(
//         children: [
//           SizedBox(
//             height: 90,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 controller.currentUser!.image,
//                 fit: BoxFit.cover,
//                 height: 60,
//                 width: 60,
//               ),
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 15,
//               ),
//               Text(
//                 controller.currentUser!.nickname,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 controller.currentUser!.nickname,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Row(
//                 children: [
//                   const Icon(Icons.poll_outlined),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                       "${controller.currentUser!.productsSolded.length} Ventas"),
//                 ],
//               ),
//             ],
//           ),
//           const Spacer(),
//           DefaultLineButton(
//             onPressed: () => Navigator.pushNamed(
//               context,
//               Routes.chat,
//               arguments: ChatArguments(
//                 post: post,
//                 user: controller.currentUser!,
//               ),
//             ),
//             title: "Chat",
//             textColor: primaryColor,
//           ),
//         ],
//       ),
//       onTap: () => Navigator.pushNamed(
//         context,
//         Routes.profileResume,
//         arguments: controller.user,
//       ),
//     );
//     ;
//   }
// }
