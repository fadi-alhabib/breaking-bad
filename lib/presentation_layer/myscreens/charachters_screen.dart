import 'package:bloc_1/business_logic_layer/cubit/charachters_cubit.dart';
import 'package:bloc_1/mydata/mymodels/characters.dart';
import 'package:bloc_1/presentation_layer/mywidgets/charachter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharachtersScreen extends StatefulWidget {
  const CharachtersScreen({Key? key}) : super(key: key);

  @override
  State<CharachtersScreen> createState() => _CharachtersScreenState();
}

class _CharachtersScreenState extends State<CharachtersScreen> {
  late List<Charachter> allCharachters;
  late List<Charachter> searchedForCharachters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: Colors.yellow.shade900,
      decoration: InputDecoration(
          hintText: 'Find a Charachter',
          hintStyle: TextStyle(color: Colors.yellow.shade800, fontSize: 18),
          border: InputBorder.none),
      style: TextStyle(color: Colors.yellow.shade800, fontSize: 18),
      onChanged: (searchedCharachter) {
        addSearchedForItemsToSearchedList(searchedCharachter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharachter) {
    searchedForCharachters = allCharachters
        .where((charachter) =>
            charachter.name.toLowerCase().startsWith(searchedCharachter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarItmes() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: Colors.yellow.shade800,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: Colors.yellow.shade800,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharachtersCubit>(context).getAllCharachters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharachtersCubit, CharachtersState>(
        builder: (context, state) {
      if (state is CharachtersLoaded) {
        allCharachters = state.charachters;
        return buildLoadedListWidgets();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.grey,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.yellow.shade800,
        child: Column(
          children: [
            buildCharachtersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharachtersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty
            ? allCharachters.length
            : searchedForCharachters.length,
        itemBuilder: (context, index) {
          return CharachterItem(
            charachter: _searchTextController.text.isEmpty
                ? allCharachters[index]
                : searchedForCharachters[index],
          );
        });
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Charachters',
      style: TextStyle(color: Colors.yellow.shade800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching
            ? BackButton(
                color: Colors.yellow.shade800,
              )
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        centerTitle: true,
        actions: _buildAppBarItmes(),
      ),
      body: buildBlocWidget(),
    );
  }
}
