part of "../app_display_screen.dart";

class _AppBottomBar extends StatefulWidget {
  Function(int) onTabChange;

  _AppBottomBar({Key? key, required this.onTabChange}) : super(key: key);

  @override
  State<_AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<_AppBottomBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.bottomBarBGColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _iconButton(
            image: Assets.imagesHome,
            index: 0,
          ),
          _iconButton(
            image: Assets.imagesFav,
            index: 1,
          ),
          _iconButton(
            image: Assets.imagesProducts,
            index: 2,
          ),
          _iconButton(
            image: Assets.imagesOrder,
            index: 3,
          ),
          Badge(
            label: Obx(() {
              return /*CartController.to.cartLst.isEmpty
                  ? Container(
                      color: Colors.transparent,
                    )
                  : */
                  Text(
                "${CartController.to.cartLst.length > 10 ? "9+" : CartController.to.cartLst.length}",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            offset: Offset(-4, -4),
            child: _iconButton(
              image: Assets.imagesCart,
              index: 4,
            ),
          ),
        ],
      ),
    );
  }

  IconButton _iconButton({String? image, var index = 0}) {
    return IconButton(
        onPressed: () {
          print("Current Index : ${index}");

          setState(() {
            _currentIndex = index!;
            widget.onTabChange(_currentIndex);
          });
        },
        icon: AppImageView(
                image: image,
                width: 25,
                height: 25,
                color: _currentIndex == index
                    ? AppColors.primaryColor
                    : AppColors.whiteColor.withOpacity(0.6))
            .getImage());
  }
}
