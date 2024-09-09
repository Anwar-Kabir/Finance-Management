import 'package:flutter/material.dart';
import 'package:personal_finance_managemnt/view/expense/expense_view.dart';
import 'package:personal_finance_managemnt/view/home/home.dart';
import 'package:personal_finance_managemnt/view/income/income_view.dart';
import 'package:personal_finance_managemnt/view/profile/profile_view.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    IncomeView(),
    ExpenseView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                backgroundColor: Colors.black.withOpacity(0.8),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Icon(
                          Icons.home,
                          color:
                              _selectedIndex == 0 ? Colors.yellow : Colors.grey,
                        ),
                        if (_selectedIndex == 0)
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.only(top: 2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow,
                            ),
                          ),
                      ],
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color:
                              _selectedIndex == 1 ? Colors.yellow : Colors.grey,
                        ),
                        if (_selectedIndex == 1)
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.only(top: 2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow,
                            ),
                          ),
                      ],
                    ),
                    label: 'Income',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Icon(
                          Icons.payment,
                          color:
                              _selectedIndex == 2 ? Colors.yellow : Colors.grey,
                        ),
                        if (_selectedIndex == 2)
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.only(top: 2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow,
                            ),
                          ),
                      ],
                    ),
                    label: 'Expense',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Icon(
                          Icons.person,
                          color:
                              _selectedIndex == 3 ? Colors.yellow : Colors.grey,
                        ),
                        if (_selectedIndex == 3)
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.only(top: 2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow,
                            ),
                          ),
                      ],
                    ),
                    label: 'Profle',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.yellow,
                unselectedItemColor: Colors.grey,
                onTap: _onItemTapped,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
