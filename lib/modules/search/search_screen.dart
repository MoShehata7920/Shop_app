import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'enter text to search';
                            }
                            return null;
                          },
                          onFieldSubmitted: (String text) {
                            SearchCubit.get(context).search(text);
                          },
                          label: 'Search',
                          prefix: Icons.search_sharp),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context).model!.data!.data[index],
                              context,
                              isOldPrice: false,
                            ),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data!
                                .data
                                .length,
                          ),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
