import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(currentIndex: 0));
  
  void updateIndex(int index) => emit(NavigationState(currentIndex: index));
}