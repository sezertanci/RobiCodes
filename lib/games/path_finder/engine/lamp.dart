import 'path_finder_board.dart';

/// "Desen Bulmacası" lambalarının renkleri. Renk körlüğü için ekranda her rengin kendi işareti de çizilir.
enum LampColor { red, blue, yellow, green }

/// Lambanın biçimi; "Desen Bulmacası"nda renk ile birlikte desenin parçası olabilir.
enum LampShape { circle, square, triangle }

/// Haritadaki bir lamba: hedef ya da yakılan renk, yanıp yanmadığı ve yanlış yakılıp yakılmadığı.
typedef BoardLamp = ({LampColor color, bool lit, bool wrong});

/// Haritadaki lambalar; lambasız haritalarda boştur.
typedef BoardLamps = Map<GridPoint, BoardLamp>;
