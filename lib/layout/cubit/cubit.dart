// ignore_for_file: unnecessary_import

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favoritees_model.dart';
import 'package:shop_app/models/favoritess_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorities/favorities_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      // printFullText(homeModel!.data!.banners[0].image!);
      // // ignore: avoid_print
      // print(homeModel!.status);

      // ignore: avoid_function_literals_in_foreach_calls
      homeModel!.data!.products.forEach(
        (element) {
          favorites.addAll({
            element.id!: element.inFavorites!,
          });
        },
      );

      // ignore: avoid_print
      print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token, //not important bc he didn't ask it in postman
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      printFullText(homeModel!.data!.banners[0].image!);
      // ignore: avoid_print
      print(homeModel!.status);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!; //this used to change
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // ignore: avoid_print
      print(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      } //to make sure that there is no error with the status
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token, //not important bc he didn't ask it in postman
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      printFullText(value.data.toString());
      // ignore: avoid_print
      print(homeModel!.status);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }
}
