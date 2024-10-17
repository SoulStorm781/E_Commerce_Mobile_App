import 'package:af_store/features/shop/models/banner_model.dart';
import 'package:af_store/routes/routes.dart';
import 'package:af_store/utils/constants/image_strings.dart';

class FDummyData {
  //banners

  static final List<BannerModel> banners = [
    BannerModel(
      imageUrl: FImages.productbanner1,
      targetScreen: FRoutes.cart,
      active: true,
    ),
    BannerModel(
      imageUrl: FImages.productbanner2,
      targetScreen: FRoutes.order,
      active: true,
    ),
    BannerModel(
      imageUrl: FImages.productbanner3,
      targetScreen: FRoutes.settings,
      active: true,
    ),
  ];
}
