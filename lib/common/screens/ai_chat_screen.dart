import 'dart:convert';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:videocalling_medical/common/utils/app_apis.dart';
import '../components/appbar.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_widgets.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  TextEditingController textController = TextEditingController();
  List<ChatMessage> messages = [];
  final PageController controller = PageController();

  bool AILoading = false;

  callAIFunction() async {
    setState(() {
      AILoading = true;
    });
    String userInput = textController.text;

    if (userInput.isEmpty) {
      print("Enter a value");
      return;
    }

    setState(() {
      messages.add(
          ChatMessage(role: 0, text: userInput, index: messages.length + 1));
      textController.clear();
    });

    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
        'POST',
        Uri.parse(
            '${Apis.AIApiAddress}${Apis.AIApiKey}'),
      );

      request.body = json.encode({
        "contents": messages
            .map((msg) => {
          "role": msg.role == 0 ? "user" : "model",
          "parts": [
            {"text": msg.text}
          ]
        })
            .toList()
      });

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(await response.stream.bytesToString());
        String aiResponse = jsonResponse['candidates'][0]['content']['parts'][0]
        ['text'] ??
            "No response";

        setState(() {

          messages.add(ChatMessage(
              role: 1, text: aiResponse, index: messages.length + 1));
          AILoading = false;

        });
      }
      else {
        setState(() {
          AILoading = false;
        });
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      setState(() {
        AILoading = false;
      });
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: CustomAppBar(
          title: 'AI_Chat'.tr,
          isBackArrow: true,
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: AppColors.WHITE,
      body: Column(
        children: [
          messages.isNotEmpty
              ? Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      bool isUser = messages[index].role == 0;

                      // return
                      // ChatBubble(messages[index]);
                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: isUser ? 40 : 10,
                              right: 10),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: isUser
                                ? LinearGradient(
                                colors: [
                                  AppColors.chatColor1,
                                  AppColors.LIGHT_BLUE_ACCENT
                                ],
                                stops: [
                                  0.3,
                                  1
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)
                                : null,
                            color: isUser
                                ? Theme.of(context)
                                .primaryColor
                                .withOpacity(0.8)
                                : AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(isUser ? 12 : 0),
                                bottomRight: Radius.circular(isUser ? 0 : 12),
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                          ),
                          child: isUser
                              ? Text(
                            messages[index].text.trimRight(),
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: AppFontStyleTextStrings.regular,
                              color: Colors.white,
                            ),
                          )
                              : index + 1 == messages.length
                              ?

                          TypewriterAnimatedTextKit(
                            text: [messages[index].text.trimRight()],
                            textStyle: TextStyle(
                              fontSize: 14.0,
                              fontFamily:
                              AppFontStyleTextStrings.medium,
                              color: Colors.black,
                            ),
                            speed: Duration(milliseconds: 10),
                            isRepeatingAnimation: false,
                          )

                              : Text(
                            messages[index].text.trimRight(),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily:
                              AppFontStyleTextStrings.medium,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  AILoading == false?
                  Container()
                      :
                  Align(
                    alignment:  Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 0,
                              bottom: 0,
                              left: 10,
                              right: 10),
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            gradient: null,
                            color: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular( 0),
                                bottomRight: Radius.circular( 12),
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                          ),
                          child:
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 40,
                                width: 85,
                                child: TypingIndicator(
                                  showIndicator: true,
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
              : Container(),

          messages.isNotEmpty
              ? Container()
              : Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/ai chat img.png",
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Welcome_to_AI_Chat".tr,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: AppFontStyleTextStrings.semiBold,
                        color: AppColors.color2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "How_can_i_help_you".tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: AppFontStyleTextStrings.regular,
                        color: AppColors.BLACK,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Container(
              // height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // color: AppColors.WHITE,
              ),
              child: TextField(
                minLines: 1,
                maxLines: 1,
                controller: textController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.transparentColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.transparentColor),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.transparentColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.transparentColor),
                    ),
                    hintText: "send_text_field_hint".tr,
                    filled: true,
                    hintStyle: const TextStyle(
                      fontFamily: AppFontStyleTextStrings.regular,
                      fontSize: 15,
                    ),
                    suffixIcon: IconButton(
                      icon:  const Icon(Icons.send,color:AppColors.color2,size: 30,),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        callAIFunction();
                      },
                    )),
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                  callAIFunction();
                },
                // onChanged: (val) {
                //   markAsTyping();
                //   message.value = val;
                //   if (val.length == 0) {
                //     showButton.value = false;
                //   } else {
                //     showButton.value = true;
                //   }
                // },
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class ChatMessage {
  final int role;
  final String text;
  final int index;

  ChatMessage({required this.role, required this.text, required this.index});
}



class TypingIndicator extends StatefulWidget {
  const TypingIndicator({
    super.key,
    this.showIndicator = false,
    this.bubbleColor = const Color(0xFF646b7f),
    this.flashingCircleDarkColor = const Color(0xFF333333),
    this.flashingCircleBrightColor = const Color(0xFFaec1dd),
  });

  final bool showIndicator;
  final Color bubbleColor;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;

  late Animation<double> _indicatorSpaceAnimation;

  late Animation<double> _smallBubbleAnimation;
  late Animation<double> _mediumBubbleAnimation;
  late Animation<double> _largeBubbleAnimation;

  late AnimationController _repeatingController;
  final List<Interval> _dotIntervals = const [
    Interval(0.25, 0.8),
    Interval(0.35, 0.9),
    Interval(0.45, 1.0),
  ];

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(
      vsync: this,
    )..addListener(() {
      setState(() {});
    });

    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ).drive(Tween<double>(
      begin: 0.0,
      end: 60.0,
    ));

    _smallBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    );
    _mediumBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.2, 0.6, curve: Curves.easeOut),
    );
    _largeBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _repeatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    if (widget.showIndicator) {
      _showIndicator();
    }
  }

  @override
  void didUpdateWidget(TypingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showIndicator != oldWidget.showIndicator) {
      if (widget.showIndicator) {
        _showIndicator();
      } else {
        _hideIndicator();
      }
    }
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    _repeatingController.dispose();
    super.dispose();
  }

  void _showIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 750)
      ..forward();
    _repeatingController.repeat();
  }

  void _hideIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 150)
      ..reverse();
    _repeatingController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _indicatorSpaceAnimation,
      builder: (context, child) {
        return SizedBox(
          height: _indicatorSpaceAnimation.value,
          child: child,
        );
      },
      child: Stack(
        children: [
          AnimatedBubble(
            animation: _largeBubbleAnimation,
            left: 0,
            bottom: 0,
            bubble: StatusBubble(
              repeatingController: _repeatingController,
              dotIntervals: _dotIntervals,
              flashingCircleDarkColor: widget.flashingCircleDarkColor,
              flashingCircleBrightColor: widget.flashingCircleBrightColor,
              bubbleColor: widget.bubbleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBubble extends StatelessWidget {
  const AnimatedBubble({
    super.key,
    required this.animation,
    required this.left,
    required this.bottom,
    required this.bubble,
  });

  final Animation<double> animation;
  final double left;
  final double bottom;
  final Widget bubble;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      bottom: bottom,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.scale(
            scale: animation.value,
            alignment: Alignment.bottomLeft,
            child: child,
          );
        },
        child: bubble,
      ),
    );
  }
}

class StatusBubble extends StatelessWidget {
  const StatusBubble({
    super.key,
    required this.repeatingController,
    required this.dotIntervals,
    required this.flashingCircleBrightColor,
    required this.flashingCircleDarkColor,
    required this.bubbleColor,
  });

  final AnimationController repeatingController;
  final List<Interval> dotIntervals;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;
  final Color bubbleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlashingCircle(
            index: 0,
            repeatingController: repeatingController,
            dotIntervals: dotIntervals,
            flashingCircleDarkColor: flashingCircleDarkColor,
            flashingCircleBrightColor: flashingCircleBrightColor,
          ),
          FlashingCircle(
            index: 1,
            repeatingController: repeatingController,
            dotIntervals: dotIntervals,
            flashingCircleDarkColor: flashingCircleDarkColor,
            flashingCircleBrightColor: flashingCircleBrightColor,
          ),
          FlashingCircle(
            index: 2,
            repeatingController: repeatingController,
            dotIntervals: dotIntervals,
            flashingCircleDarkColor: flashingCircleDarkColor,
            flashingCircleBrightColor: flashingCircleBrightColor,
          ),
        ],
      ),
    );
  }
}

class FlashingCircle extends StatelessWidget {
  const FlashingCircle({
    super.key,
    required this.index,
    required this.repeatingController,
    required this.dotIntervals,
    required this.flashingCircleBrightColor,
    required this.flashingCircleDarkColor,
  });

  final int index;
  final AnimationController repeatingController;
  final List<Interval> dotIntervals;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: repeatingController,

      builder: (context, child) {
        final circleFlashPercent = dotIntervals[index].transform(
          repeatingController.value,
        );
        final circleColorPercent = sin(pi * circleFlashPercent);

        return Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(
              flashingCircleDarkColor,
              flashingCircleBrightColor,
              circleColorPercent,
            ),
          ),
        );
      },
    );
  }
}


