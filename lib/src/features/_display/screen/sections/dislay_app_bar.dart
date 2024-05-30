part of "../app_display_screen.dart";

class _DisplayAppBar extends StatefulWidget {

  VoidCallback? onLogoClick ;

  GlobalKey<ScaffoldState>? scaffoldKey;

  _DisplayAppBar({Key? key, this.scaffoldKey ,this.onLogoClick}) : super(key: key);

  @override
  State<_DisplayAppBar> createState() => _DisplayAppBarState();
}

class _DisplayAppBarState extends State<_DisplayAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  padding: EdgeInsets.only(left: 16, top: 20),
                  onPressed: () {
                    print(
                        "Current Index : ${widget.scaffoldKey?.currentState}");
                    widget.scaffoldKey?.currentState?.openDrawer();
                  },
                  icon: AppImageView(
                    image: Assets.assetsImagesMenu,
                    height: 90,
                    width: 80,
                  ).getImage()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: AnyImageView(

                  onTap: widget.onLogoClick,
                  imagePath: Assets.imagesLogo,
                  height: 60,
                  width: 60,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  padding: EdgeInsets.only(right: 16, top: 20),
                  onPressed: () {
                    Get.to(() => ProductList(
                          forSearch: true,
                        ));
                  },
                  icon: Icon(Icons.search)),
            )
          ],
        ),
      ),
    );
  }
}
