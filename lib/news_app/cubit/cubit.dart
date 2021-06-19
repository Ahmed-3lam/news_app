import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Modules/Business/BusinessScreen.dart';
import 'package:news_app/Modules/Science/ScienceScreen.dart';
import 'package:news_app/Modules/Sports/SportsScreen.dart';
import 'package:news_app/Network/dio_helper.dart';
import 'package:news_app/news_app/cubit/states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports_baseball), label: "sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "science"),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "country": "eg",
        "apiKey": "524da1af12584eaf8cdc43b2e98b84e7",
        "category": "business"
      },
    ).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "apiKey": "524da1af12584eaf8cdc43b2e98b84e7",
          "category": "sports"
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "apiKey": "524da1af12584eaf8cdc43b2e98b84e7",
          "category": "science"
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }
}
