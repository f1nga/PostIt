import 'package:flutter/material.dart';
import 'package:wallapop/src/routes/routes.dart';

class PostDetailSlider extends StatefulWidget {
  final List<String> images;

  const PostDetailSlider({super.key, required this.images});

  @override
  _PostDetailSliderState createState() => _PostDetailSliderState();
}

class _PostDetailSliderState extends State<PostDetailSlider> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        itemCount: widget.images.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(children: [
            Image.network(
              widget.images[index],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
             Positioned(
              top: 10,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white,),
                onPressed: () => Navigator.popAndPushNamed(context, Routes.home),
              ),
            ),
            Positioned(
              right: 10,
              child: PopupMenuButton<String>(
                color: Colors.white,
                onSelected: (String result) {
                  print(result);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'opcion1',
                    child: Text('Opción 1'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'opcion2',
                    child: Text('Opción 2'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'opcion3',
                    child: Text('Opción 3'),
                  ),
                ],
              ),
            ),
          ]);
        },
        onPageChanged: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}
