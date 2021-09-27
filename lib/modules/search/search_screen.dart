import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    var searchController = TextEditingController();
    
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:(context,state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20,end: 20,bottom: 20,top: 5),
              child: TextFormField(
                controller: searchController,
                keyboardType: TextInputType.text,
                onChanged: (String value){
                  NewsCubit.get(context).getSearch(value);
                  print('debugg:'+value);
                },
                validator: (value){
                  if(value.toString().isEmpty){
                    return 'search must not be empty';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText:'search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                
              ),
            ),
            Expanded(
              child: articleuilder(list,isSearch: true),
            ),        
          ],
        ),
      );
  }
    );
  }
}