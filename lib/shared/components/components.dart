import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view.dart';


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


Widget buildArticleItem(article,context){
  dynamic image;
  if (article['urlToImage']==null){
    image = const AssetImage('assets/images/shape.png');
  }else{
    image = NetworkImage(article['urlToImage']);
  }
  return InkWell(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(article['url']),
        ),
     );
    },
    child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            
            Container(
              width:120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                
                image:DecorationImage(
                  
                  image:image,
                  fit: BoxFit.cover
                )
              )
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Expanded(
                      child: Text(
                         article['title'],
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(article['publishedAt'],style: const TextStyle(color: Colors.grey),)
                  ],
                ),
              ))
          ],
        ),
      ),
  );
}


Widget articleuilder(list,{isSearch = true }){

  if (list.isEmpty ){
    print (list);
    if(isSearch){
      return Container();
    }else
    {return const Center(child:CircularProgressIndicator());}
  }else {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context,index)=>buildArticleItem(list[index],context), 
      separatorBuilder: (context,index) => myDivider(),
      itemCount: list.length);
         }
}