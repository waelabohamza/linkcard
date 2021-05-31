import 'package:flutter/material.dart';
import 'package:linkcard/component/cacheimagenetwork.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/component/mydrawer.dart';
import 'package:linkcard/linkapi.dart';
import 'package:linkcard/pages/subcategories/subcategories.dart';
import "package:cached_network_image/cached_network_image.dart";

class Categories extends StatefulWidget {
  final catid;
  final imageurl;
  Categories({Key key, this.catid, this.imageurl}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Crud crud = new Crud();
  GlobalKey<ScaffoldState> appbarkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double mdh = MediaQuery.of(context).size.height ; 
    return Scaffold(
      key: appbarkey,
      // appBar: myAppBar(appbarkey, "categories", context),
      drawer: MyDrawer(),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
           Container( child: Text("w"),height: mdh)  , 
          cacheImege(context, "$linkupload/categories/${widget.imageurl}",
              250.0, double.infinity),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              child: FutureBuilder(
                future: crud.readDataWhere(linksubcategories, widget.catid),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data[0] == "falid") {
                      return Center(
                          child: Text("لا يوجد اي اقسام في هذا القسم"));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return buildSubCategories(snapshot.data[i], i);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  /*

 Container(
        padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
        child: FutureBuilder(
          future: crud.readDataWhere(linksubcategories, widget.catid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data[0] == "falid") {
                return Center(child: Text("لا يوجد اي اقسام في هذا القسم"));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return buildSubCategories(snapshot.data[i] ,  i, () {});
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      )

  */

  buildSubCategories(subCategories, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SubCategories(
            subcat: subCategories['subcategories_id'],
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Card(
            child: Column(
          children: [
            Container(
              child: CachedNetworkImage(
                imageUrl:
                    "$linkupload/subcategories/${subCategories['subcategories_image']}",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fill,
                height: 100,
              ),
             ),
            // Container(
            //     margin: EdgeInsets.only(top: 20),
            //     child: Text(
            //       "${subCategories['subcategories_name']}",
            //       style: Theme.of(context).textTheme.headline6,
            //     ))
          ],
        )),
      ),
    );
  }
}
