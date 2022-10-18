// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

enum BottomNavBar { home, analysis, chart, settiing }

class BottomNavBarState extends Equatable {
  const BottomNavBarState({this.navBar = BottomNavBar.home});
  final BottomNavBar navBar;

  @override
  List<Object> get props => [navBar];

  BottomNavBarState copyWith({
    BottomNavBar? navBar,
  }) {
    return BottomNavBarState(
      navBar: navBar ?? this.navBar,
    );
  }
}
