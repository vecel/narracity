import 'package:latlong2/latlong.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';

final _facultyChoice = MultiButtonElement(
  buttons: [
    ButtonElement(text: 'MiNI', trigger: ProceedTrigger(id: 'mini')),
    ButtonElement(text: 'EiTI', trigger: ProceedTrigger(id: 'eiti')),
    ButtonElement(text: 'Fizyka', trigger: ProceedTrigger(id: 'fizyka'))
  ]
);

final _nodes = [
  ScenarioNode(
    id: 'welcome', 
    elements: [
      TextElement(text: 'Witaj w przykładowym scenariuszu w aplikacji Narracity. Jest to aplikacja stworzona do interaktywnych gier terenowych, zwiedzania miasta z przewodnikiem w postaci narratora aplikacji lub poznawania konkretnych miejsc w twojej okolicy. Dzisiaj będę twoim nie-AI przewodnikiem po terenie Politechniki Warszawskiej.'),
      TextElement(text: 'Wyobraź sobie, że właśnie skończyłeś liceum i chcesz iść na studia, ale nie wiesz, które wybrać. Razem odwiedzimy kilka wydziałów PW. Ale na początek chodźmy przed Gmach Główny.'),
      ButtonElement(
        text: 'Dalej', 
        trigger: WithMapNotificationTrigger(
          trigger: ProceedTrigger(id: 'main building')
        )
      )
    ]
  ),
  ScenarioNode(
    id: 'main building', 
    elements: [
      PolygonElement(
        points: [
          LatLng(52.220148, 21.010668),
          LatLng(52.220666, 21.010993),
          LatLng(52.220206, 21.011776),
          LatLng(52.220119, 21.011677)
        ],
        enterTrigger: WithStoryNotificationTrigger(
          trigger: AppendElementsTrigger(
            elements: [
              TextElement(text: 'Świetnie. Przed tobą znajduje się Gmach Główny. W środku znajduje się Biblioteka Główna PW oraz odbywają się tam różne wydarzenia takie jak Targi Kół Naukowych KONIK czy Targi Pracy.'),
              TextElement(text: 'Wybierz teraz wydział, który chcesz odwiedzić.'),
              _facultyChoice
            ]
          )
        )
      ),
      TextElement(text: 'W zakładce "map" zaznaczono, gdzie znajduje się Gmach Główny. Udaj się do tego obszaru.')
    ]
  ),
  ScenarioNode(
    id: 'mini', 
    elements: [
      TextElement(text: 'Wybrałeś wydział MiNI. Na mapie zaznaczono odpowiedni obszar. Udaj się tam.'),
      PolygonElement(
        points: [
          LatLng(52.222011, 21.006953),
          LatLng(52.222016, 21.007301),
          LatLng(52.221804, 21.007331),
          LatLng(52.221796, 21.006955)
        ],
        enterTrigger: WithStoryNotificationTrigger(
          trigger: AppendElementsTrigger(
            elements: [
              TextElement(text: 'Stoisz przed budynkiem wydziału MiNI. Wygląda jak duże akwarium. Wejście główne znajduje się w większej części budynku, natomiast w "nodze" jest siedziba Wydziałowej Rady Samorządu.'),
              TextElement(text: 'Czy chcesz odwiedzić jeszcze wydizał EiTI?'),
              MultiButtonElement(
                buttons: [
                  ButtonElement(text: 'Nie', trigger: ProceedTrigger(id: 'end')),
                  ButtonElement(text: 'Tak', trigger: WithMapNotificationTrigger(trigger: ProceedTrigger(id: 'eiti')))
                ]
              )
            ]
          )
        )
      )
    ]
  ),
  ScenarioNode(
    id: 'eiti', 
    elements: [
      TextElement(text: 'Wybrałeś wydział EiTI. Na mapie zaznaczono odpowiedni obszar. Udaj się tam.'),
      PolygonElement(
        points: [
          LatLng(52.219163, 21.010744),
          LatLng(52.219304, 21.010562),
          LatLng(52.219565, 21.010583),
          LatLng(52.219542, 21.010942),
          LatLng(52.219252, 21.011023)
        ],
        enterTrigger: WithStoryNotificationTrigger(
          trigger: AppendElementsTrigger(
            elements: [
              TextElement(text: 'Stoisz przed budynkiem wydziału EiTI. Naprawdę chcesz tu studiować? Idź lepiej obejrzeć MiNI. Jest ładniejsze.'),
              MultiButtonElement(
                buttons: [
                  ButtonElement(text: 'Nie', trigger: ProceedTrigger(id: 'end')),
                  ButtonElement(text: 'Ok', trigger: WithMapNotificationTrigger(trigger: ProceedTrigger(id: 'mini')))
                ]
              )
            ]
          )
        )
      )
    ]
  ),
  ScenarioNode(
    id: 'end', 
    elements: [
      TextElement(text: 'To już koniec. Mam nadzieję, że ten spacer po kampusie PW ci się podobał.'),
      TextElement(text: 'Do zobaczenia.'),
      ButtonElement(text: 'Koniec', trigger: EndTrigger())
    ]
  )
];

final warsawUniversityOfTechnologyScenario = Scenario(
  id: 'example',
  title: 'Witaj PW', 
  description: 'Jest to pokazowy scenariusz prezentujący działanie aplikacji i jej możliwości. Oprowadza uczestnika po kampusie Politechniki Warszawskiej.', 
  image: 'https://www.pw.plock.pl/var/wwwglowna/storage/images/filia/aktualnosci/politechnika-warszawska-zmienia-swoje-oblicze/35146-2-pol-PL/Politechnika-Warszawska-zmienia-swoje-oblicze.png', 
  location: 'Warszawa, Mokotów', 
  distance: '1 km', 
  duration: '15 min', 
  nodes: _nodes
);