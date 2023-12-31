import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../layout/presenetation/view/manager/app_cubit.dart';
import '../../../../layout/presenetation/view/manager/app_states.dart';
import '/core/global/app_colors.dart';
import '/features/users/presentation/widgets/user_item.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.getObject(context).users.isNotEmpty,
          builder: (context) {
            return GridView.builder(
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 650),
                  columnCount: AppCubit.getObject(context).users.length,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: UserItem(
                        userModel: AppCubit.getObject(context).users[index],
                      ),
                    ),
                  ),
                );
              },
              itemCount: AppCubit.getObject(context).users.length,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              scrollDirection: Axis.vertical,
              reverse: false,
              primary: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              dragStartBehavior: DragStartBehavior.start,
              clipBehavior: Clip.hardEdge,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 220,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 2,
              ),
            );
          },
          fallback: (context) =>  Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
        );
      },
    );
  }
}
