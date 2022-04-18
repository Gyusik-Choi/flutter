import 'package:box_office_1/bloc/movie_provider.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height= size.height;

    final ScrollController scrollController = ScrollController();
    final movieBloc = MovieProvider.of(context);
    // getMovies 함수는 API 데이터를 받아와서 비동기로 동작하게 된다
    // 그래서 이 함수의 동작이 완료되기 전에 위젯들이 그려진다
    // 데이터를 받아오는 것이 완료되면 stream 에 데이터가 들어오고
    // 데이터를 바탕으로 새롭게 화면을 그리게 된다
    movieBloc.getMovies();
  
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder(
                  stream: movieBloc.movies,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      // https://github.com/flutter/flutter/issues/80794
                      physics: const NeverScrollableScrollPhysics(),
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int idx) {
                        String image = snapshot.data[idx].image;
                        String title = snapshot.data[idx].title;
                        int rank = snapshot.data[idx].rank;
                    
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              image,
                            ),
                            title: Text(rank.toString()),
                            subtitle: Text(title),
                          )
                        );
                      }
                    );
                  }
                )
              ],
            ),
          )
        )
      )
    );
  }
}