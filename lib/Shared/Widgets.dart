import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
Widget articleItemBuilder(article) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text('${article['title']}',
                        maxLines: 3,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                  ),
                  Text("'${article['publishedAt']}'",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          )
        ],
      ),
    );

Widget articleMainBuilder(list) => list.length < 1
    ? Center(child: CircularProgressIndicator())
    : ListView.separated(
        itemBuilder: (context, index) => articleItemBuilder(list[index]),
        separatorBuilder: (context, index) => Center(
              child: myDivider(),
            ),
        itemCount: list.length - 1);
