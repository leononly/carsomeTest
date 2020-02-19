import 'package:carsomeTest/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<bool> selections = [true, false];

  ManagerBloc managerBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    managerBloc = ManagerBloc();

    managerBloc.add(FetchData(index: 1));
  }

  @override
  Widget build(BuildContext context) {
    Size _media = MediaQuery.of(context).size;
    return BlocListener(
      bloc: managerBloc,
      listener: (context, state) {
        if (state is ManagerErrorFound) {
          final snackBar = SnackBar(
              content: Text(
                  'Something went wrong, Please try again by tapping the toggles.'));
          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Flutter'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder(
            bloc: managerBloc,
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: ToggleButtons(
                      renderBorder: false,
                      selectedBorderColor: Colors.blue,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: 2, left: 5, right: 5, bottom: 2),
                          decoration: BoxDecoration(color: Colors.black),
                          child: Text(
                            '1',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 2, left: 5, right: 5, bottom: 2),
                          decoration: BoxDecoration(color: Colors.black),
                          child: Text(
                            '2',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                      isSelected: selections,
                      onPressed: state is ManagerLoading
                          ? null
                          : (index) {
                              setState(() {
                                selections[index] = true;
                                selections[index == 1 ? 0 : 1] = false;

                                managerBloc.add(FetchData(index: index));
                              });
                            },
                    ),
                  ),
                ),
                state is ManagerLoading
                    ? Container(
                        height: _media.width * 0.8,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Flexible(
                        child: OrientationBuilder(
                          builder: (context, orientation) => GridView.builder(
                              itemCount: managerBloc.dataList.length,
                              padding: EdgeInsets.symmetric(
                                  horizontal: _media.width * 0.08,
                                  vertical: 20),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          orientation == Orientation.landscape
                                              ? 5
                                              : 2,
                                      mainAxisSpacing: 10),
                              itemBuilder: (context, index) => Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Container(
                                            child: Image.network(
                                              managerBloc.dataList[index]
                                                  ['thumbnailUrl'],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 135,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            managerBloc.dataList[index]['title']
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
