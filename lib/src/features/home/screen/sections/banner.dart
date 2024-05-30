part of "../home_screen.dart";

class Banner extends StatefulWidget {
  const Banner({Key? key}) : super(key: key);

  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: FutureBuilder(
        future: AppHomeController.to.getAllBanner(),
        builder: (context, AsyncSnapshot<BannerModel?> data) {
          if (data.hasData && data.data?.response != null) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider.builder(
                  itemCount: data.data?.response?.length ?? 0,
                  itemBuilder: (context, index, realIndex) {
                    print(
                        "Image url : ${ApiUrls.download_base_url + (data.data?.response?[index].image ?? "")} ");

                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        data.data?.response?[index].image != null
                            ? ApiUrls.download_base_url +
                                data.data!.response![index].image!
                            : "",
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    //     viewportFraction: 0.86,
                    //aspectRatio: 2,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    enlargeFactor: 1.5,

                    viewportFraction: 0.9,
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
