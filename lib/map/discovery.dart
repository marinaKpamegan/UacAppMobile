import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Discovery extends StatefulWidget {
  final ScrollController scrollController;
  const Discovery(this.scrollController);
  @override
  _DiscoveryState createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
  int _currentIndex = 0;
  String _selectedType = "";
  ValueChanged<bool> pressed;
  bool isActive;
  List<Places> mainList = _listFilter("");

  void updateList(String filterBy){

    setState(() {
      mainList.clear();
      mainList = _listFilter(filterBy);
      _currentIndex = 0;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.place, color: Colors.white,
                  ),
                  SizedBox(width: 15,),
                  Text("Explorer le Campus", style: TextStyle(color: Colors.white, fontSize: 18),)
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 25),
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: FloatingActionButton(
                                  heroTag: "admin",
                                  backgroundColor: Colors.greenAccent,
                                  child: Icon(
                                    Icons.business, color: Colors.white,
                                  ),
                                  onPressed: (){
                                    _selectedType = "administratif";
                                    print(_selectedType);
                                    updateList(_selectedType);
                                  }
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: FloatingActionButton(
                                heroTag: "school",
                                backgroundColor: Colors.blueAccent,
                                child: Icon(
                                  Icons.school, color: Colors.white,
                                ),
                                onPressed: (){
                                  _selectedType = "university";
                                  updateList(_selectedType);
                                  print(_selectedType);

                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: FloatingActionButton(
                                heroTag: "studio",
                                backgroundColor: Colors.pinkAccent,
                                child: Icon(
                                  Icons.hotel, color: Colors.white,
                                ),
                                onPressed: (){
                                  _selectedType = "studio";
                                  updateList(_selectedType);
                                  print(_selectedType);

                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: FloatingActionButton(
                                heroTag: "restau",
                                backgroundColor: Colors.orangeAccent,
                                child: Icon(
                                  Icons.restaurant, color: Colors.white,
                                ),
                                onPressed: (){
                                  _selectedType = "restau";
                                  updateList(_selectedType);
                                  print(_selectedType);

                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: FloatingActionButton(
                                heroTag: "all",
                                backgroundColor: Colors.blueGrey,
                                child: Icon(
                                  Icons.view_list, color: Colors.white,
                                ),
                                onPressed: (){
                                  _selectedType = "";
                                  updateList(_selectedType);
                                  print(_selectedType);

                                },
                              ),
                            )
                          ],
                        )
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 180,
                child: ListView.builder(
                  itemCount: mainList.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          InkWell(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage(
                                      'assets/images/batiments/${mainList[index].placeImageUrl}',
                                    ),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  border:  isActive == true && _currentIndex == index ? Border.all(color: Color.fromRGBO(9, 113, 52, 1).withOpacity(0.6), width: 5.0) : null
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                isActive = true;
                                _currentIndex = index;
                              });
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 100,
                            height: 30,
                            child: Text(mainList[index].placeName, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                          ),

                        ],
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,

                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                  width: MediaQuery.of(context).size.width - 50,
                  // height: MediaQuery.of(context).size.height - 350,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height - 380,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(mainList[_currentIndex].placeName, style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(9, 113, 52, 1)),),
                              SizedBox(
                                height: 8,
                              ),
                              Text(mainList[_currentIndex].about),
                              SizedBox(
                                  height: 12
                              ),
                              Text("Localisation", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(9, 113, 52, 1)),),
                              SizedBox(
                                height: 8,
                              ),
                              Text(mainList[_currentIndex].localisation),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        )
    );
  }

  void _toggle() {
    Navigator.pop(context);
  }

}

class Places{
  final String placeImageUrl;
  final String about;
  final String type;
  final String placeName;
  final String localisation;


  const Places(this.placeImageUrl, this.about, this.type, this.placeName, this.localisation);

}

List<Places> _listFilter(String type){
  List<Places> filter = [];
  if(type == null || type == "")
    for (int i = 0; i<_places.length; i++){
      filter.add(_places[i]);
    }
  else
    for (int i = 0; i<_places.length; i++){

      if(_places[i].type == type){
        filter.add(_places[i]);
      }
    }

  return filter;

}

final List<Places> _places = [
  Places("rectorat.jpg",
      "Appelée Rectorat, l’Administration rectorale est coordonnée par un Secrétariat Général qui est le chef de l’administration universitaire, chargé de la gestion des ressources humaines, du secrétariat et des archives.\n \n Un "
          "Agent Comptable placée sous l’autorité conjointe du Ministre en charge de l’Enseignement Supérieur et de la recherche Scientifique et du Recteur est chargé d’assurer l’exécution du budget de l’UAC et du bon fonctionnement et de la bonne gestion des services de comptabilité des entités de l’UAC.\n \n L’Université d’Abomey-Calavi est dirigée par un Recteur assisté de trois Vices Recteurs(5). Outre un Secrétaire Général et un Agent comptable qui assistent l’équipe rectorale, plusieurs services administratifs appuient le Rectorat dans l’accomplissement de ses fonctions. \n \n",
      "administratif", "Rectorat", ""),
  Places("enam.jpg",
      "S'entraîner pour mieux servir. Telle est la devise de l'École nationale d'administration et de la magistrature (ENAM) du Bénin, plus précisément celle de ses étudiants. Former parce que l'éducation est la clé de tout succès. En effet, dans un monde complexe et en mutation rapide, la formation est une question de survie, et pour survivre, il faut trouver son chemin, élargir ses horizons.\n \n L'ENAM est un établissement national de formation professionnelle. Il est rattaché à l'Université d'Abomey-Calavi. Il forme, principalement pour l'administration de l'Etat et les collectivités territoriales, du personnel destiné à occuper des postes de conception, de direction et de contrôle. Il permet aux apprenants inscrits dans ses différents programmes d'acquérir non seulement les connaissances techniques et le savoir-faire nécessaires à l'accomplissement de leurs futures fonctions, mais aussi et surtout des compétences interpersonnelles reflétant l'esprit de service public.",
      "university", "Ecole nationale d'administration ", ""),
  Places("restau U.jpg",
      "Construit non loin de l’entrée principale du campus de l’Uac, le Restau U, le plus grand restaurant estudiantin répond au besoin gastronomique d’un nombre impressionnant d’étudiants. On y mange à peu de frais. Le petit déjeuner est à 75 francs Cfa (moins d’un huitième d’Euro), le déjeuner à 150 francs moins d’un quart d’Euro) tout comme le dîner.",
      "restau", "Restaurant de l'Université", ""),
  Places("ifri.jpg",
      "L’Institut de Formation et de Recherche en Informatique est né des cendres du Centre de Formation et de Recherche en Information (CEFRI) créé en 2008 par arrêté rectoral dans le cadre de la coopération entre l’Université d’Abomey-Calavi et l’Académie de Recherche et d’Enseignement Supérieur (ARES) de la Belgique.\n \n"
          "La vocation de l'Institut de Formation et de Recherche en Informatique (IFRI) de l'Université d'Abomey-Calavi est de former des apprenants capables de devenir des acteurs de solution informatique aux différents problèmes de sociétés en s'appuyant sur les récents développements des Technologies de l'Information et de la Communication. IFRI, Nous batissons l'excellence",
      "university", "Institut de Formation et de Recherche en Informatique", ""),
  Places("studio.jpg",
      "Dorttoir des étudiants",
      "studio", "Studio des étudiants", "En face École polytechnique et à coté du terrain de basket."),
];


