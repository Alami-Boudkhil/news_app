import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';



class SportsScrenn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text('sports screen'));
   return BlocConsumer<NewsCubit,NewsStates>(
     listener: (context,state)=>NewsCubit(),
     builder: (context,state){
       
      var list = NewsCubit.get(context).sports;

      return articleuilder(list);
               
     },
   );
  }
}