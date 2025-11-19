import 'package:videocalling_medical/common/utils/app_imports.dart';



class IntroductionScreenPage extends StatelessWidget {
  const IntroductionScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final IntroductionController controller = Get.put(IntroductionController());

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Static background container
            Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF49BFAB),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Dynamic content with IntroductionScreen
            IntroductionScreen(
              globalBackgroundColor: Colors.transparent,
              rawPages: controller.introPages
                  .map((pageData) => _buildPageViewModel(pageData))
                  .toList(),
              onDone: () => controller.onDonePressed(),
              onSkip: () => controller.onSkipPressed(),
              showSkipButton: true,
              skip: Container(),

              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade200,
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: const Text(
              //     'SKIP',
              //     style: TextStyle(
              //       color: Color(0xFF4ECDC4),
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
              next: Container(
                padding: const EdgeInsets.all(12),
                decoration:  BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Color(0xFF30455C),
                ),
              ),
              done: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Color(0xFF6582A4),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              curve: Curves.fastLinearToSlowEaseIn,
              controlsMargin: const EdgeInsets.all(16),
              controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
              dotsDecorator: const DotsDecorator(
                size: Size(10.0, 10.0),
                color: Color(0xFF7086A5),
                activeSize: Size(22.0, 10.0),
                activeColor: Color(0xFF30455C),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              dotsContainerDecorator: const ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageViewModel(IntroPageData pageData) {
    return Column(
      children: [
        // Image section - only dynamic content
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              pageData.imagePath,
              fit: BoxFit.contain,

              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.medical_services,
                    size: 100,
                    color: Color(0xFF4ECDC4),
                  ),
                );
              },
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                buildRichTextTitle(pageData.title, pageData.highlightWords),
                (pageData.textImg?.isNotEmpty ?? false)
                    ? Container(
                    padding: EdgeInsets.only(left: 40,top: 10),
                    alignment: Alignment.topLeft,
                    child: Image.asset(pageData.textImg!))
                    : Container(),
                const SizedBox(height: 12),
                buildRichTextDisc(pageData.description, pageData.highlightWords),
              ],
            ),
          ),
        ),
      ],
    );

  }


  RichText buildRichTextTitle(String text, List<String> highlightWords) {
    final defaultStyle = const TextStyle(
      fontSize: 27,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    final highlightStyle = const TextStyle(
      fontSize: 27,
      fontWeight: FontWeight.bold,
      color: Colors.white, // your highlight color
    );

    List<TextSpan> spans = [];
    int start = 0;

    while (start < text.length) {
      bool matched = false;

      for (final phrase in highlightWords) {
        if (text.startsWith(phrase, start)) {
          spans.add(TextSpan(text: phrase, style: highlightStyle));
          start += phrase.length;
          matched = true;
          break;
        }
      }

      if (!matched) {
        spans.add(TextSpan(text: text[start], style: defaultStyle));
        start++;
      }
    }

    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(children: spans),
    );
  }
  RichText buildRichTextDisc(String text, List<String> highlightWords) {
    final defaultStyle = const TextStyle(
      fontSize: 20,
      height: 1.4,
      color: Colors.black,
    );

    final highlightStyle = const TextStyle(
      fontSize: 20,
      height: 1.4,
      fontWeight: FontWeight.bold,
      color: Colors.white, // your highlight color
    );

    List<TextSpan> spans = [];
    int start = 0;

    while (start < text.length) {
      bool matched = false;

      for (final phrase in highlightWords) {
        if (text.startsWith(phrase, start)) {
          spans.add(TextSpan(text: phrase, style: highlightStyle));
          start += phrase.length;
          matched = true;
          break;
        }
      }

      if (!matched) {
        spans.add(TextSpan(text: text[start], style: defaultStyle));
        start++;
      }
    }

    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(children: spans),
    );
  }


}