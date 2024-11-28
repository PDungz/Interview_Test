import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({super.key});

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  bool isLoading = false;

  List imageUrl = [
    'https://i.pinimg.com/474x/7a/c9/30/7ac930b819b2aa4bef88e4da00fdabd2.jpg',
    'https://i.pinimg.com/474x/91/e7/50/91e75029b1108bef489b879c8482cdac.jpg',
    'https://i.pinimg.com/474x/43/37/ac/4337ac8a66093044458581966d081b9b.jpg',
    'https://i.pinimg.com/474x/e0/ab/0d/e0ab0da9b232e43bea1ccdef54deb49e.jpg',
    'https://i.pinimg.com/236x/7f/2c/60/7f2c6071d7bac5914027ccca21b41bc2.jpg',
    'https://i.pinimg.com/236x/5f/b4/d5/5fb4d5734da114b96dbbac21d133333c.jpg',
    'https://i.pinimg.com/474x/91/e7/50/91e75029b1108bef489b879c8482cdac.jpg',
    'https://i.pinimg.com/474x/e0/ab/0d/e0ab0da9b232e43bea1ccdef54deb49e.jpg',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Loaded();
  }

  void _Loaded() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        setState(() {
          isLoading = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: imageUrl.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2 / 3,
          ),
          itemBuilder: (context, index) {
            return isLoading
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Image.network(imageUrl[index]),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
