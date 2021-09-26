import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';



class BusinessScrenn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   
   return BlocConsumer<NewsCubit,NewsStates>(
     listener: (context,state)=>NewsCubit(),
     builder: (context,state){
       var list = NewsCubit.get(context).business;
         
        return articleuilder(list);
               
     },
   );
  }
}