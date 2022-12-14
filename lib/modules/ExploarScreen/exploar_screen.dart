import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/hoelTest.dart';

import '../../layout/cubit/states.dart';
import '../../shared/components/constants.dart';
import '../map/map.dart';

class exploar_screen extends StatelessWidget {
  exploar_screen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var maxpricetController = TextEditingController();
  var minpricetController = TextEditingController();
  var addressController = TextEditingController();
  var distanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context).searchModel;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              appTranslation(context).search,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MapInitial();
                    }));
                  },
                  icon: const Icon(Icons.my_location))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is SearchFilterLoadingState) const LinearProgressIndicator(),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  // onChanged: (val)=>AppCubit.get(context).getSearch(
                  //     name: textController.text
                  // ),
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter your product name';
                    }
                    return null;
                  },
                  onFieldSubmitted: (String text) {},
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Container(
                      width: 170,
                      child: TextFormField(
                        controller: minpricetController,
                        // onChanged: (val)=>AppCubit.get(context).getSearch(
                        //     name: textController.text
                        // ),
                        keyboardType:TextInputType.number ,
                        decoration: const InputDecoration(
                          labelText: 'Min Price',
                          prefixIcon: Icon(Icons.price_change),
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your product name';
                          }
                          return null;
                        },
                        onFieldSubmitted: (String text) {},
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      width: 170,
                      child: TextFormField(
                        controller: maxpricetController,
                        // onChanged: (val)=>AppCubit.get(context).getSearch(
                        //     name: textController.text
                        // ),
                        keyboardType:TextInputType.number ,
                        decoration: const InputDecoration(
                          labelText: 'Max Price',
                          prefixIcon: Icon(Icons.price_change),
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your product name';
                          }
                          return null;
                        },
                        onFieldSubmitted: (String text) {},
                      ),
                    ),

                  ],
                ),
                // TextFormField(
                //   keyboardType: TextInputType.text,
                //   controller: addressController,
                //   // onChanged: (val)=>AppCubit.get(context).getSearch(
                //   //     name: textController.text
                //   // ),
                //   decoration: const InputDecoration(
                //     labelText: 'address',
                //     prefixIcon: Icon(Icons.map),
                //     border: OutlineInputBorder(),
                //   ),
                //   validator: (String? value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your product name';
                //     }
                //     return null;
                //   },
                //   onFieldSubmitted: (String text) {},
                // ),
                // TextFormField(
                //   keyboardType: TextInputType.number,
                //   controller: distanceController,
                //   // onChanged: (val)=>AppCubit.get(context).getSearch(
                //   //     name: textController.text
                //   // ),
                //   decoration: const InputDecoration(
                //     labelText: 'Distamce',
                //     prefixIcon: Icon(Icons.social_distance),
                //     border: OutlineInputBorder(),
                //   ),
                //   validator: (String? value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your product name';
                //     }
                //     return null;
                //   },
                //   onFieldSubmitted: (String text) {},
                // ),
                Center(
                  child: SizedBox(
                        width: 290,
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        AppCubit.get(context).getSearch(
                          name: nameController.text,
                          maxPrice: int.parse(maxpricetController.text.toString()),
                          minPrice: int.parse(minpricetController.text.toString()),
                         // distance: int.parse(distanceController.text.toString()),
                         // address: addressController.text,
                        );
                      },
                      child: const Text('Search'),
                    ),
                  ),
                ),
                //  if (state is SearchFilterLoadingState)
                const SizedBox(
                  height: 35,
                ),

                //  const LinearProgressIndicator(),

                if (state is SearchFilterSuccessState)
                  Text('Total Response ( ${cubit!.data!.length} )',style: TextStyle(color: Colors.blue),),
                const SizedBox(
                  height: 10,
                ),
                if (state is SearchFilterSuccessState)
                  Expanded(
                    child: ListView.separated(

                      separatorBuilder: (_, index) => SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (_, index) => padding(cubit!.data![index]),
                      itemCount: cubit!.data!.length,
                      shrinkWrap: true,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget padding(DataModel index) => Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: SizedBox(
          height: 124,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          index.name,
                          maxLines: 1,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        child: Text(
                          index.address,
                          maxLines: 1,
                          style:
                              TextStyle(fontSize: 12, color: Color(0XFFC1C1C1)),
                        ),
                      ),
                      Text(
                        'Price per night ${index.price}',
                        style:
                            TextStyle(fontSize: 12, color: Color(0XFF060B92)),
                      ),
                    ],
                  ),
                ),
                RotatedBox(
                  quarterTurns: -1,
                  child: Container(
                    child: Image.network(
                        'http://api.mahmoudtaha.com/images/${index.images[0]}'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
