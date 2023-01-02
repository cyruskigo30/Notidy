import 'package:flutter/material.dart';

///This file is important when you want to navigate to a new page eg from dashboard to new note
///but you need to carry arguements from one page to the next
///These arguements carry navigatotor action choices that you can implement
///on certain conditions.
///Example it allows you to have create nad update in the same view provided the navigator action
///had the arguements property
extension GetArguement on BuildContext {
  ///optionally return any type you want (T)
  T? getArguement<T>() {
    final modalRoute = ModalRoute.of(this);

    ///if you get any modal routes, extract the arguements
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;

      ///if there are arguements and they are of type T
      if (args != null && args is T) {
        ///return the arguements
        return args as T;
      }
    }

    ///if you dont get any modal route, don't extract any arguement
    return null;
  }
}
