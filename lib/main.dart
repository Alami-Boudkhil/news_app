import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_app/news_layout.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/components/cubit/cubit.dart';
import 'package:news_app/shared/components/cubit/states.dart';
import 'package:news_app/shared/network/local/cach_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();

  bool? isDark = CachHelper.getBool(key: 'isDark');
  runApp(MyApp(isDark));
  
}

class MyApp extends StatelessWidget {
  

  final bool? isDark;

  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()..getBusiness(),),
          
        BlocProvider(
        create: (context)=>AppCubit()..changeTheme(
          fromShared: isDark
        ),)
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){} ,
        builder:(context,state){ 
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.white,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange
            ),
            appBarTheme: const AppBarTheme(
              
              // systemOverlayStyle: SystemUiOverlayStyle(
              //   statusBarColor: Colors.white,
              //   statusBarIconBrightness: Brightness.dark
              // ),
              titleSpacing: 20,
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black
              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor:Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.00
            ),
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black
              )
            )
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: HexColor('333739'),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange
            ),
            appBarTheme: AppBarTheme(
              
              // systemOverlayStyle: SystemUiOverlayStyle(
              //   statusBarColor: Colors.white,
              //   statusBarIconBrightness: Brightness.dark
              // ),
              titleSpacing: 20,
              backgroundColor: HexColor('333739'),
              elevation: 0,
              iconTheme: const IconThemeData(
                color: Colors.white
              ),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            ),
            bottomNavigationBarTheme:  BottomNavigationBarThemeData(
              backgroundColor:HexColor('333739') ,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.00
            ),
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white
              )
            )
          ),
          
          themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
          
               
          home:  NewsLayout(),
        );
        }
      ),
    );
  }
}


