
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  
  NewsCubit (): super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business
      ),
      label: 'Business'

    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports
      ),
      label: 'Sports'
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science
      ),
      label: 'Science'
    ),
    
  ];
 
  List<Widget> screens = [
    BusinessScrenn(),
    SportsScrenn(),
    ScienceScrenn(),
   
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    if(index==1){
      getSports();
    }
    if(index==2){
      getscience();
    }
    emit(NewsButtomNavStates());
  }

List <dynamic> business = [];

  void getBusiness(){
    emit(NewsBusinessLoadingState());
    
      DioHelper.getData(
      url: 'v2/top-headlines', 
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'fec20b09f2d24678b119444cc4449f55'
      }
    ).then((value) {
     business = value.data['articles'];
     print(business[0]['title']);
     emit(NewsGetBusinessSuccessState());
    }).catchError((error){     
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  
    }
    


List <dynamic> sports = [];

  void getSports(){
    emit(NewsSportsLoadingState());
    
    if(sports.isEmpty){

       DioHelper.getData(
      url: 'v2/top-headlines', 
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'fec20b09f2d24678b119444cc4449f55'
      }
    ).then((value) {
     sports = value.data['articles'];
     print(sports[0]['title']);
     emit(NewsGetSportsSuccessState());
    }).catchError((error){     
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
    }
    else {
      emit(NewsGetSportsSuccessState());
    }
      
    
   
  }

List <dynamic> science = [];

  void getscience(){
    emit(NewsScienceLoadingState());
   
    if(science.isEmpty){

      DioHelper.getData(
      url: 'v2/top-headlines', 
      query: {
        'country':'eg',
        'category':'science',
        'apiKey':'fec20b09f2d24678b119444cc4449f55'
      }
    ).then((value) {
     science = value.data['articles'];
     print(science[0]['title']);
     emit(NewsGetScienceSuccessState());
    }).catchError((error){     
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });

    }else{
      emit(NewsGetScienceSuccessState());
    }
      
    
    
  }

List <dynamic> search = [];
 
 void getSearch(String value){
    emit(NewsSearchLoadingState());
    search = [];
      DioHelper.getData(
      url: 'v2/everything', 
      query: {
        'q':value,
        'apiKey':'fec20b09f2d24678b119444cc4449f55'
      }
    ).then((value) {
     search = value.data['articles'];
     print(search[0]['title']);
     emit(NewsGetSearchSuccessState());
    }).catchError((error){     
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  
    }

}
