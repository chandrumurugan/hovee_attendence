import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class LogoGif extends StatefulWidget {
  final bool? issplash;
  const LogoGif({super.key, this.issplash});

  @override
  State<LogoGif> createState() => _LogoGifState();
}

class _LogoGifState extends State<LogoGif> with TickerProviderStateMixin {
  late final GifController gif_controller;

  late bool gifCompleted;
  @override
  void initState() {
    // TODO: implement initState
    gif_controller = GifController(vsync: this);
    gifCompleted = false;
    super.initState();
  }

  @override
  void dispose() {
    gif_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // !gifCompleted
        //         ?
        Gif(
      image: const AssetImage('assets/appConstantImg/hovee_att_logo.gif'),
      height: widget.issplash!=null && widget.issplash!?
        200:50,
      width: widget.issplash!=null && widget.issplash!?200:150,

      controller:
          gif_controller, // if duration and fps is null, original gif fps will be used.
      //fps: 20,
      duration: const Duration(seconds: 3),
      autostart: Autostart.no,
      placeholder: (context) => const Image(
        image: AssetImage('assets/appConstantImg/colorlogoword.png'),
        //height: 40,
        width: 130,
      ),

      onFetchCompleted: () {
        gif_controller.reset();
        gif_controller.forward();

        Future.delayed(const Duration(seconds: 3), () {
          // print("\n\n\nqqqqqqqqqq\n\n\n");
          gifCompleted = true;
          setState(() {
            gif_controller.stop();
          });
        });

        //gif_controller.stop();
      },
    );
    // : Image(
    //     image: AssetImage('assets/logo/hovee.png'),
    //     //height: 40,
    //     width: 130,
    //   );
  }
}

// class LogoGif1 extends StatefulWidget {
//   const LogoGif1({super.key});

//   @override
//   _LogoGif1State createState() => _LogoGif1State();
// }

// class _LogoGif1State extends State<LogoGif> with TickerProviderStateMixin {
//   late final GifController gif_controller;

//   late bool gifCompleted;
//   @override
//   void initState() {
//     // TODO: implement initState
//     gif_controller = GifController(vsync: this);
//     gifCompleted = false;
//     super.initState();
//   }

//   @override
//   void dispose() {
//     gif_controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return
//         // !gifCompleted
//         //         ?
//         Gif(
//       image: const AssetImage('assets/appConstantImg/hovee_att_logo _n.gif'),
//       height: 50,
//       width: 150,

//       controller:
//           gif_controller, // if duration and fps is null, original gif fps will be used.
//       //fps: 20,
//       duration: const Duration(seconds: 3),
//       autostart: Autostart.no,
//       placeholder: (context) => const Image(
//         image: AssetImage('assets/appConstantImg/colorlogoword.png'),
//         //height: 40,
//         width: 130,
//       ),

//       onFetchCompleted: () {
//         gif_controller.reset();
//         gif_controller.forward();

//         Future.delayed(const Duration(seconds: 3), () {
//           // print("\n\n\nqqqqqqqqqq\n\n\n");
//           gifCompleted = true;
//           setState(() {
//             gif_controller.stop();
//           });
//         });

//         //gif_controller.stop();
//       },
//     );
//     // : Image(
//     //     image: AssetImage('assets/logo/hovee.png'),
//     //     //height: 40,
//     //     width: 130,
//     //   );
//   }
// }

