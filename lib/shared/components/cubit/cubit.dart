import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/cubit/states.dart';
import 'package:news_app/shared/network/local/cach_helper.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark=false;

  void changeTheme({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(AppChangeThemeState());
    }else{
      isDark = !isDark;
      CachHelper.putBool(key: 'isDark',value: isDark).then((value) {
       emit(AppChangeThemeState());
    });
    }
    
   

  }
}