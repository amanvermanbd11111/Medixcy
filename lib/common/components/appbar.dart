import 'package:videocalling_medical/common/utils/app_imports.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  var title2;
  VoidCallback? onPressed;
  VoidCallback? onPressedClear;
  bool? isBackArrow;
  bool? titleCenter;
  bool? isTitle2;
  bool? sortIcon;
  TextStyle? textStyle;

  CustomAppBar(
      {super.key,
      required this.title,
      this.title2,
      this.isBackArrow,
      this.sortIcon,
      this.titleCenter,
      this.onPressed,
      this.isTitle2,
      this.onPressedClear,
      this.textStyle});

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.color1,
                AppColors.color2,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          height: 60 + MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: 60,
          child: Row(
            children: [
              if(titleCenter == false || titleCenter == null)
                const SizedBox(
                width:15,
              ),
              (isBackArrow ?? false)
                  ? InkWell(
                      onTap: onPressed,
                      child: Image.asset(
                        AppImages.backIcon,
                        height: 25,
                        width: 22,
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                width: (isBackArrow ?? false) ? 10 : 0,
              ),
              if(titleCenter == true)
                Spacer(),


              if(isTitle2 != true)
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle ??
                        const TextStyle(
                          color: AppColors.WHITE,
                          fontSize: 22,
                          fontFamily: AppFontStyleTextStrings.medium,
                        ),
                  ),
                ),

              if(isTitle2 == true)
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle ??
                        const TextStyle(
                          color: AppColors.WHITE,
                          fontSize: 22,
                          fontFamily: AppFontStyleTextStrings.medium,
                        ),
                  ),
                  Text(
                    title2 ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle ??
                         TextStyle(
                          fontFamily: AppFontStyleTextStrings.medium,
                          color: AppColors.WHITE,
                          fontSize: 9.5,
                        ),
                  ),
                ],
              ),


              // add city name here

              if(titleCenter == true)
                Spacer(),

              if(sortIcon == true && isTitle2 == true)
                 Spacer(),

              if(sortIcon == true)
              InkWell(
                onTap: onPressedClear,
                child:
                Container(
                    // width: 20,
                    child: Icon(Icons.sort,color: AppColors.WHITE,)),
                // Text(
                //   "clear".tr,
                //   style:
                //       const TextStyle(
                //         color: AppColors.WHITE,
                //         fontSize: 16,
                //         fontFamily: AppFontStyleTextStrings.regular,
                //       ),
                // ),
              ),

              if(sortIcon == true)
                SizedBox(width: 10,)

            ],
          ),
        ),
      ],
    );
  }
}


class MedAppBar extends StatelessWidget {
  String title;
  var title2;
  VoidCallback? onPressed;
  VoidCallback? onPressedClear;
  bool? isBackArrow;
  bool? titleCenter;
  bool? isTitle2;
  bool? sortIcon;
  bool? showSearchField;
  TextStyle? textStyle;
  TextEditingController? searchController;
  Function(String)? onSearchChanged;
  Function(String)? onSearchSubmitted;
  Animation<Color>? searchLoadingColor;

  MedAppBar(
      {super.key,
        required this.title,
        this.title2,
        this.isBackArrow,
        this.sortIcon,
        this.titleCenter,
        this.onPressed,
        this.isTitle2,
        this.onPressedClear,
        this.textStyle,
        this.showSearchField,
        this.searchController,
        this.onSearchChanged,
        this.onSearchSubmitted,
        this.searchLoadingColor});

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.color1,
                AppColors.color2,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          height: (showSearchField == true ? 135 : 60) + MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    if(titleCenter == false || titleCenter == null)
                      const SizedBox(
                        width:15,
                      ),
                    (isBackArrow ?? false)
                        ? InkWell(
                      onTap: onPressed,
                      child: Image.asset(
                        AppImages.backIcon,
                        height: 25,
                        width: 22,
                      ),
                    )
                        : const SizedBox(),
                    SizedBox(
                      width: (isBackArrow ?? false) ? 10 : 0,
                    ),
                    if(titleCenter == true)
                      Spacer(),


                    if(isTitle2 != true)
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle ??
                              const TextStyle(
                                color: AppColors.WHITE,
                                fontSize: 22,
                                fontFamily: AppFontStyleTextStrings.medium,
                              ),
                        ),
                      ),

                    if(isTitle2 == true)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle ??
                                const TextStyle(
                                  color: AppColors.WHITE,
                                  fontSize: 22,
                                  fontFamily: AppFontStyleTextStrings.medium,
                                ),
                          ),
                          Text(
                            title2 ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle ??
                                TextStyle(
                                  fontFamily: AppFontStyleTextStrings.medium,
                                  color: AppColors.WHITE,
                                  fontSize: 9.5,
                                ),
                          ),
                        ],
                      ),


                    // add city name here

                    if(titleCenter == true)
                      Spacer(),

                    if(sortIcon == true && isTitle2 == true)
                      Spacer(),

                    if(sortIcon == true)
                      InkWell(
                        onTap: onPressedClear,
                        child:
                        Container(
                          // width: 20,
                            child: Icon(Icons.sort,color: AppColors.WHITE,)),
                        // Text(
                        //   "clear".tr,
                        //   style:
                        //       const TextStyle(
                        //         color: AppColors.WHITE,
                        //         fontSize: 16,
                        //         fontFamily: AppFontStyleTextStrings.regular,
                        //       ),
                        // ),
                      ),

                    if(sortIcon == true)
                      SizedBox(width: 10,)

                  ],
                ),
              ),

              // Search field
              if(showSearchField == true)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search, color: Color(0xFF4ECDC4)),
                          filled: true,
                          fillColor: AppColors.WHITE,
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: AppColors.WHITE),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Search by name',
                          hintStyle: TextStyle(
                            color: AppColors.LIGHT_GREY_TEXT,
                            fontSize: 13,
                            fontFamily: AppFontStyleTextStrings.regular,
                          ),
                          suffixIcon: searchLoadingColor != null ? Container(
                            height: 20,
                            width: 20,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  valueColor: searchLoadingColor,
                                ),
                              ),
                            ),
                          ) : null,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: AppColors.WHITE),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: AppColors.WHITE),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: AppColors.WHITE),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onSubmitted: onSearchSubmitted,
                      onChanged: onSearchChanged,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}


class CustomSearchScreenAppBar extends StatelessWidget {
  String title;
  String title1;
  TextEditingController textController;
  Animation<Color> valueColor;
  Function(String) onSubmitted;
  VoidCallback onPressed;
  VoidCallback? onPressed1;
  bool? isBackArrow;

  CustomSearchScreenAppBar({
    super.key,
    required this.title,
    required this.title1,
    required this.textController,
    required this.valueColor,
    required this.onSubmitted,
    required this.onPressed,
    this.isBackArrow,
    this.onPressed1,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            gradient: LinearGradient(
              colors: [
                AppColors.color1,
                AppColors.color2,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          height: 125 + MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    (isBackArrow ?? false)
                        ? InkWell(
                            onTap: onPressed1,
                            child: Image.asset(
                              AppImages.backIcon,
                              height: 25,
                              width: 22,
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      width: (isBackArrow ?? false) ? 10 : 0,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: AppFontStyleTextStrings.regular,
                        color: AppColors.WHITE,
                      ),
                    ),
                    AppTextWidgets.mediumText(
                      text: title1,
                      color: AppColors.WHITE,
                      size: 25,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.WHITE,
                        ),
                        child: TextField(
                          controller: textController,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.WHITE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'search_doctor_name'.tr,
                              hintStyle: TextStyle(
                                fontFamily: AppFontStyleTextStrings.regular,
                                color: AppColors.LIGHT_GREY_TEXT,
                                fontSize: 13,
                              ),
                              suffixIcon: Container(
                                height: 20,
                                width: 20,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(13),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.5,
                                      valueColor: valueColor,
                                    ),
                                  ),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.WHITE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.WHITE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.WHITE),
                                borderRadius: BorderRadius.circular(15),
                              )),
                          onSubmitted: onSubmitted,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: onPressed,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.WHITE,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Image.asset(
                            AppImages.searchIcon,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomHomeScreenAppBar extends StatelessWidget {
  String title;
  String title1;
  TextEditingController textController;
  Animation<Color> valueColor;
  Function(String) onSubmitted;
  Function(String) onChanged;
  VoidCallback onPressed;
  VoidCallback? onPressedSort;

  CustomHomeScreenAppBar({
    super.key,
    required this.title,
    required this.title1,
    required this.textController,
    required this.valueColor,
    required this.onSubmitted,
    required this.onChanged,
    required this.onPressed,
    this.onPressedSort
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            gradient: LinearGradient(
              colors: [
                AppColors.color1,
                AppColors.color2,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          height: 125 + MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.WHITE,
                        fontFamily: AppFontStyleTextStrings.regular,
                      ),
                    ),
                    Expanded(
                      child: AppTextWidgets.mediumText(
                        text: title1,
                        over: TextOverflow.ellipsis,
                        color: AppColors.WHITE,
                        size: 25,
                      ),
                    ),
                    // InkWell(
                    //   onTap: onPressedSort,
                    //   child: Container(
                    //     width: 40,
                    //     height: 40,
                    //     decoration: BoxDecoration(
                    //       // color: AppColors.WHITE,
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Center(
                    //       child:
                    //       Icon(Icons.sort,color: AppColors.WHITE,),
                    //       // Image.asset(
                    //       //   AppImages.searchIcon,
                    //       // ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.WHITE,
                        ),
                        child: TextField(
                          controller: textController,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.WHITE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'search_doctor_name'.tr,
                              hintStyle: TextStyle(
                                color: AppColors.LIGHT_GREY_TEXT,
                                fontSize: 13,
                                fontFamily: AppFontStyleTextStrings.regular,
                              ),
                              suffixIcon: Container(
                                height: 20,
                                width: 20,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(13),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.5,
                                      valueColor: valueColor,
                                    ),
                                  ),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.WHITE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.WHITE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.WHITE),
                                borderRadius: BorderRadius.circular(15),
                              )),
                          onSubmitted: onSubmitted,
                          onChanged: onChanged,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: onPressed,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.WHITE,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Image.asset(
                            AppImages.searchIcon,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomSearchScreenAppBar2 extends StatelessWidget {
  String title;
  String title1;
  String hintText;
  TextEditingController textController;
  Animation<Color> valueColor;
  Function(String) onSubmitted;
  VoidCallback onPressed;
  VoidCallback? onPressed1;
  bool? isBackArrow;

  CustomSearchScreenAppBar2({
    super.key,
    required this.title,
    required this.title1,
    required this.textController,
    required this.valueColor,
    required this.onSubmitted,
    required this.onPressed,
    required this.hintText,
    this.isBackArrow,
    this.onPressed1,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.color1,
                AppColors.color2,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          height: Platform.isIOS ? 140 : 110,
          width: MediaQuery.of(context).size.width,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
              children: [

                (isBackArrow ?? false)
                    ? InkWell(
                  onTap: onPressed1,
                  child: Image.asset(
                    AppImages.backIcon,
                    height: 25,
                    width: 22,
                  ),
                )
                    : const SizedBox(),
                SizedBox(
                  width: (isBackArrow ?? false) ? 10 : 0,
                ),
                Row(
                  children: [
                    Container(
                      width: Get.width-70,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.WHITE,
                      ),
                      child: TextField(
                        controller: textController,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: AppColors.WHITE),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: hintText,
                            hintStyle: TextStyle(
                              fontFamily: AppFontStyleTextStrings.medium,
                              color: AppColors.LIGHT_GREY_TEXT,
                              fontSize: 15,
                            ),
                            suffixIcon: Container(
                              height: 20,
                              width: 20,
                              child: Center(
                                child:
                                InkWell(
                                  onTap: onPressed,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.WHITE,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        AppImages.searchIcon,
                                      ),
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(13),
                                //   child: CircularProgressIndicator(
                                //     strokeWidth: 1.5,
                                //     valueColor: valueColor,
                                //   ),
                                // ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: AppColors.WHITE),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: AppColors.WHITE),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: AppColors.WHITE),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        onSubmitted: onSubmitted,
                      ),
                    ),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    // InkWell(
                    //   onTap: onPressed,
                    //   child: Container(
                    //     width: 50,
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       color: AppColors.WHITE,
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     child: Center(
                    //       child: Image.asset(
                    //         AppImages.searchIcon,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MedixyAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isBackArrow;
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;
  final String? searchHint;

  const  MedixyAppBar({
    super.key,
    required this.title,
    this.onPressed,
    this.isBackArrow = false,
    this.searchController,
    this.onSearchChanged,
    this.searchHint,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Arrow + Title Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                if (isBackArrow)
                  InkWell(
                    onTap: onPressed,
                    child: const Icon(Icons.arrow_back,
                        color: Colors.black, size: 26),
                  ),
                if (isBackArrow) const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: searchHint ?? "Search Specialization",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 15,
                  ),
                  prefixIcon:
                  const Icon(Icons.search, color: Colors.teal, size: 22),
                  border: InputBorder.none,
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


