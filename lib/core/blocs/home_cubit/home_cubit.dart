import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(const BottomNavBarState());

  void onItemTapped(int index) {
    var item = BottomNavBar.values[index];
    if (item != state.navBar) {
      emit(state.copyWith(navBar: item));
    }
  }
}
