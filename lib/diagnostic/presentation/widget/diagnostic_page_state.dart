import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/network/api_provider.dart';
import 'package:xbridge/common/theme/eleveated_button_style.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/context_extension.dart';
import 'package:xbridge/diagnostic/presentation/screen/diagnostic.dart';
import 'package:xbridge/fe_task_list/presentation/widget/fe_task_list_state.dart';

import '../../controller/bloc/diagnostic_bloc.dart';

class DiagnosticPageState extends State<Diagnostic> {
  final TextEditingController _controller = TextEditingController();
  final Battery _battery = Battery();
  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

// Future<Directory?>? _tempDirectory;
  Future<Directory?>? _appSupportDirectory;
  final String _filePath = '';
  APIProvider provider = APIProvider();

  @override
  void initState() {
    _requestAppSupportDirectory();

    _battery.batteryState.then(_updateBatteryState);
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen(_updateBatteryState);
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  void _updateBatteryState(BatteryState state) {
    if (_batteryState == state) return;
    setState(() {
      _batteryState = state;
    });
  }

  void _requestAppSupportDirectory() {
    setState(() {
      _appSupportDirectory = getApplicationSupportDirectory();
    });
  }

  void _saveToFile() async {
    try {
      if (_appSupportDirectory != null) {
        Directory? tempDir = await _appSupportDirectory;
        if (tempDir != null) {
          String fileName = 'diagnosticReport.txt';
          File file = File('${tempDir.path}/$fileName');
          String userInput = _controller.text;
          bool batteryMode = await _battery.isInBatterySaveMode;
          int batteryLevel = await _battery.batteryLevel;
          await file.writeAsString(
            "USER INPUT: $userInput\n BATTERY PERCENTAGE: ${_batteryState.toString()}\n NETWORK STATUS: ${_connectionStatus.toString()}\n BATTERY POWER SAVE MODE: ${batteryMode ? 'on' : 'off'}\n BATTERY LEVEL: $batteryLevel%\n"
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu tortor id libero pellentesque feugiat. Vivamus ultricies, libero nec ultricies sollicitudin, velit tortor efficitur turpis, ut tincidunt justo sem ac elit. Vivamus volutpat ante velit, ut vulputate magna volutpat eget. Nullam volutpat eros in elit mollis, sit amet faucibus felis suscipit. Fusce nec tortor eget magna tincidunt tincidunt. Quisque vel quam ut ante interdum placerat. Nulla facilisi. Ut et arcu massa. Quisque sit amet nunc nec nisi dictum lacinia. Etiam consequat, felis a facilisis vestibulum, mauris est commodo ligula, ac fermentum orci quam vitae ante. Integer ut dolor a ipsum dapibus iaculis. Ut posuere dui a ultricies viverra. Sed id arcu eu enim hendrerit ultricies. Vivamus nec enim commodo, rutrum nunc sit amet, consectetur metus. Vivamus vel quam et nulla eleifend ultrices. Sed in aliquam ipsum. Donec gravida, quam id fermentum mattis, erat diam tincidunt erat, eu consequat magna dolor sit amet quam. Sed eleifend ante sit amet sodales dictum. Sed a turpis ac ligula faucibus suscipit nec euismod quam. Nam sollicitudin nisi in malesuada accumsan. Nullam dictum ultrices ante, nec dictum sapien condimentum nec. Aliquam non odio nec turpis lobortis rhoncus. Vivamus id lectus eget sem fermentum dignissim. Fusce in risus consequat, dignissim ex id, consectetur tortor. Phasellus tincidunt fringilla justo, a congue sapien gravida eget. Sed mattis interdum urna, ut blandit quam suscipit id. Phasellus id sapien eget est aliquam hendrerit. Maecenas tincidunt felis in dui pellentesque, ac congue enim convallis. Integer vitae quam non tortor faucibus consequat vel at ligula. Curabitur scelerisque lectus non lacus ullamcorper commodo. Nam nec urna consequat, tincidunt erat vel, sollicitudin orci. Integer ac convallis ipsum, sed vehicula ex. Integer congue lacinia consequat. Sed mattis felis a suscipit lacinia. Sed convallis augue nec nisl vestibulum, a posuere odio pellentesque. Sed condimentum ipsum nec magna faucibus ultricies. Sed congue lectus at nisl fermentum, ac tempus ipsum sagittis. Ut auctor ultrices libero, at vehicula lectus ultricies eu. Phasellus auctor, elit vel tincidunt suscipit, orci magna dictum nunc, ac vehicula nisi erat in leo. Vivamus malesuada tellus a diam faucibus efficitur. Integer nec ultrices lorem. Aenean vulputate, quam at varius pellentesque, nunc ipsum viverra ipsum, vel tempor odio elit vel nisi. Suspendisse ut consequat ligula. Vivamus non rhoncus ipsum. Suspendisse potenti. Curabitur ut malesuada nisi. Curabitur tincidunt nulla non condimentum varius. Sed in dui a nunc consequat tempus. Vivamus vitae fermentum libero. Integer luctus tempor orci, in lobortis eros molestie nec. Integer euismod dolor non diam dapibus, vel commodo odio vehicula. Sed placerat purus sed purus aliquet, a pretium arcu laoreet. Nunc ultrices rutrum nulla, nec viverra turpis accumsan non. Curabitur vulputate fermentum ligula, nec sodales dolor bibendum eu. Donec eleifend eros ut lacus facilisis, sit amet consectetur nunc luctus. Maecenas pulvinar, lorem nec convallis ullamcorper, ligula risus dictum lorem, ut feugiat felis velit non justo. In nec dolor a dolor sodales varius. Nullam convallis ut sem vel tristique. Nam a mi vitae dui convallis sollicitudin. Vivamus lobortis est sit amet ipsum facilisis, vel sollicitudin nisi cursus. Sed a turpis at risus fringilla fermentum. Etiam eu lectus id magna aliquet suscipit. Integer dictum, arcu non condimentum vestibulum, purus arcu luctus quam, eu congue nisi nunc et felis. Maecenas lobortis interdum mi, nec suscipit enim auctor id. Donec at velit nec risus consequat ultrices. Etiam vehicula blandit odio, sed luctus nulla fermentum nec. Nam sit amet varius magna. Suspendisse potenti. Suspendisse vehicula leo non lorem malesuada, vitae egestas ante aliquet. Vivamus dictum ipsum sit amet ante fermentum ultrices. Donec consectetur magna id libero maximus, a lacinia nunc venenatis. Nam vitae neque eu tortor vestibulum pharetra. Ut et nunc non lacus vestibulum dignissim. Vivamus sed tristique quam. Nullam eu aliquet ligula. Curabitur fermentum arcu quis diam tempus, nec pellentesque nunc viverra. Etiam sem nunc, aliquam ac nisi sit amet, commodo malesuada sapien. Aliquam id fermentum neque. Integer in ligula non ligula faucibus facilisis. Cras vitae felis orci. Vivamus varius tincidunt est. Vivamus ultrices augue vel libero rhoncus, in efficitur mi dapibus. Nam aliquet velit sit amet est volutpat tincidunt. Sed euismod odio ut ligula egestas, quis accumsan ligula feugiat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed aliquet suscipit dolor, nec vulputate nulla cursus vitae. Integer sed nisi vitae arcu auctor tincidunt. Sed dapibus fermentum turpis. Sed non velit eros. Suspendisse potenti. Maecenas eget ex nulla. Ut nec felis a nulla consequat tincidunt nec eu felis. Curabitur elementum felis vitae odio gravida fermentum. Nulla sed bibendum justo. Integer maximus laoreet odio, ut condimentum dolor molestie eu. Sed placerat fermentum erat nec tincidunt. Nam aliquet congue sem eget pharetra. Nulla facilisi. Sed at vehicula erat. Curabitur aliquam nunc at mauris tincidunt, nec congue magna ullamcorper. Duis venenatis lorem nec nunc dapibus tincidunt. Nulla facilisi. Nulla nec sem nunc. Integer rhoncus, justo sed fermentum dignissim, sapien odio molestie justo, vel vulputate nisl risus eu tortor. Sed vel convallis metus, eu pellentesque erat. Integer a tincidunt nisi. Duis dictum ligula id dui suscipit, ac ullamcorper justo dapibus. Quisque dapibus tellus ac libero volutpat venenatis. Sed in sem vitae justo rhoncus malesuada id et eros. In non elit a purus pharetra euismod. Integer rhoncus dui in nunc dignissim, at aliquet libero molestie. Donec sit amet sapien eget justo tincidunt interdum ac eu justo. Maecenas posuere eleifend nibh vitae feugiat. Maecenas faucibus consequat quam in rutrum. Morbi luctus nunc non augue eleifend, quis interdum neque ultricies. Integer tincidunt gravida quam, vitae tincidunt velit finibus at. Phasellus vehicula sapien et velit ultricies, ut sollicitudin mi dictum. Phasellus molestie quam vitae nisi facilisis, vel commodo mauris malesuada. Suspendisse congue mi nec augue lacinia, eu varius sapien fringilla. Etiam at ligula et ligula condimentum rutrum vel eu ligula. Integer vitae leo nec dui rutrum tempor. Cras eleifend turpis et ante suscipit, non aliquet lectus suscipit. Curabitur condimentum, nulla sit amet rhoncus commodo, velit turpis dignissim mauris, nec egestas quam dui eget lacus. Nulla facilisi. Donec faucibus commodo consectetur. Sed vestibulum justo eget fermentum eleifend. Mauris condimentum felis nec semper malesuada. Nullam id erat eget nulla fringilla faucibus. Vestibulum non mauris vitae eros suscipit pellentesque. Nulla ultrices lectus eu orci dapibus sodales. Suspendisse scelerisque velit sit amet tortor tempus, nec hendrerit ligula elementum. Vivamus nec ex malesuada, dictum purus in, tempus magna. Nullam eget dolor in leo cursus facilisis eget sed arcu. Mauris euismod magna ac ligula consequat, eget scelerisque purus vestibulum. Aliquam erat volutpat. Mauris finibus posuere vestibulum. Sed nec ligula justo. Integer volutpat purus sapien, in venenatis lacus luctus at. Nulla facilisi. Donec bibendum mauris eget lectus laoreet sodales. Integer nec orci ac felis viverra aliquet. Sed in justo euismod, rutrum nisl at, blandit magna. Integer fermentum elit ac nibh feugiat, ut aliquet nisl facilisis. Maecenas euismod, sem in tincidunt consequat, orci ligula aliquam orci, sit amet malesuada enim ipsum nec ex. Maecenas id mi metus. Nam laoreet orci et ligula hendrerit, eget efficitur lorem dignissim. Sed malesuada lacinia ligula, vitae sodales felis vestibulum eget. Integer sit amet malesuada sem, ut varius orci. Sed et purus a dolor vehicula rhoncus. Phasellus vitae quam quis justo fermentum tincidunt ac id nunc. Nulla facilisi. Suspendisse eleifend lacinia eros eget viverra. Aliquam nec erat a nisi posuere fermentum. Aliquam erat volutpat. Donec dapibus fringilla nunc ac scelerisque. Vivamus feugiat, magna ac sodales varius, mauris magna ultrices dui, non placerat ipsum ex non ex. Maecenas fringilla magna et est dictum, at cursus turpis eleifend. Integer iaculis, est ac feugiat vestibulum, lacus sem eleifend lacus, non fermentum felis ipsum in dui. Aliquam bibendum a arcu ac vehicula. Suspendisse eget ligula a sapien iaculis bibendum. Donec in augue ipsum. Maecenas ultrices urna id elit varius condimentum. Sed eget sapien justo. Phasellus sed interdum libero. Nam pretium feugiat urna, eu auctor ipsum pharetra nec. Maecenas faucibus felis et leo tincidunt, id commodo quam bibendum. Sed pulvinar, lacus sed malesuada luctus, nisl libero vestibulum felis, ut commodo turpis nisl in neque. Maecenas suscipit lectus in feugiat interdum. Morbi suscipit id nulla eu molestie. Integer rutrum venenatis metus, eget lacinia enim egestas eget. Nullam eu arcu non eros volutpat cursus eget ac purus. Integer fringilla auctor eros ac congue. Vivamus nec feugiat risus. In vehicula metus sed magna dictum blandit. Aliquam id tortor nec ligula fringilla accumsan. Sed rhoncus lectus quis tellus ultricies, quis consequat lorem fermentum. Nam posuere volutpat nisl, non feugiat dui interdum nec. Sed vestibulum neque nec est tincidunt, a convallis felis malesuada. Ut sem odio, efficitur nec tempus sit amet, facilisis sit amet risus. Mauris vitae neque est. Nam eleifend, sapien quis fringilla egestas, metus mi lacinia tellus, in convallis felis lacus a eros. Nam venenatis velit nec ultricies volutpat. Maecenas nec odio bibendum, tincidunt dui at, cursus metus. Nam et eros sit amet arcu convallis bibendum. Aliquam condimentum fermentum erat, a bibendum risus molestie non. Vivamus nec dolor ac libero malesuada rutrum. Nullam id nulla sed lacus facilisis efficitur. Integer elementum eget sem non eleifend. Integer posuere enim id lectus efficitur, ac interdum mi venenatis. Sed sed ex semper, venenatis felis nec, laoreet nunc. Pellentesque a lacus in ex eleifend varius. Sed convallis tortor ac libero interdum laoreet. Phasellus in nisi a lorem consequat aliquet. Cras eget volutpat lectus. Mauris commodo dolor et mi vestibulum, quis tempor risus aliquet. Nam nec convallis magna. Maecenas quis risus sem. Vivamus vel purus quis justo commodo laoreet. Nulla rutrum, neque eget hendrerit elementum, lectus libero malesuada odio, in bibendum ex ligula ac mauris. Phasellus lacinia vehicula lectus, eu vestibulum enim bibendum id. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum id turpis in sem imperdiet fringilla ut vitae magna. Ut gravida, purus id ultrices commodo, nunc ipsum accumsan dolor, eget ultricies arcu ex a ipsum. Integer sed purus eu nulla viverra egestas. Duis nec consequat lorem. Suspendisse potenti. Donec vestibulum sodales nisi, ut egestas metus maximus id. Nam nec mauris sed dui facilisis dictum. Nam rhoncus, purus ut finibus elementum, elit leo ultrices odio, id bibendum nisi odio et lectus. Sed eget mauris purus. Integer finibus nulla vitae risus condimentum, eu fringilla arcu gravida. Vivamus sit amet volutpat eros. Sed sed neque ex. Vivamus aliquam non odio nec viverra. Vivamus ut condimentum felis. Sed id tempor ante. Sed facilisis leo a felis dignissim, ut tempor neque consequat. Nulla facilisi. Donec dapibus eget nisi nec rutrum. Vivamus gravida felis ut bibendum vehicula. Suspendisse a risus interdum, convallis mauris vel, condimentum orci. Integer tempus arcu in orci ultrices luctus. Cras posuere, mi nec varius egestas, libero libero tincidunt felis, sit amet fermentum arcu mauris et eros. Donec vel enim ut libero volutpat scelerisque. Vivamus pulvinar odio et dui viverra tempus. In hac habitasse platea dictumst. Vivamus pharetra mi quis dolor vulputate, ac volutpat turpis sollicitudin. Sed gravida dolor nec felis varius, non pellentesque orci suscipit. In varius consequat erat eu egestas. In hac habitasse platea dictumst. Phasellus vehicula lectus ut odio efficitur, eu gravida dolor dignissim. Nullam nec mi in ipsum volutpat tempor. Vivamus tristique elit non lacus dapibus, ut tristique sapien vehicula. Etiam et consequat est. Integer nec orci justo. In eget dolor nulla. Vivamus faucibus laoreet elit, nec rutrum mi varius ac. Nam fermentum tortor id mauris egestas, nec aliquet sem finibus. Donec vehicula magna vitae justo vestibulum, vitae elementum elit hendrerit. Integer dictum nunc eget viverra vestibulum. Maecenas varius ex nec purus tempor vestibulum. Vestibulum laoreet blandit venenatis. Vivamus gravida, felis sed maximus fringilla, ligula nulla vestibulum arcu, vitae scelerisque ipsum quam eget turpis. Vivamus auctor purus vitae tortor bibendum dictum. Sed consectetur justo id ligula tincidunt, auctor ullamcorper elit ultricies. Sed vitae nisl eu nulla efficitur faucibus a at dolor. Duis ut arcu interdum, consequat velit vel, malesuada enim. Vivamus lobortis velit nisl, ac volutpat justo aliquet sit amet. Proin ut urna quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed sit amet sem nec erat efficitur posuere. Integer nec enim sapien. Mauris at pharetra risus. Vivamus interdum metus vel magna euismod, quis feugiat urna dictum. Maecenas vitae nulla id velit placerat suscipit. Mauris lobortis vestibulum nulla. Sed ullamcorper gravida ligula ut tincidunt. In et eros eget dolor rutrum rhoncus non nec orci. Donec ac hendrerit metus. Sed scelerisque odio vel urna scelerisque, id varius risus faucibus. Suspendisse scelerisque ultrices risus, id fringilla odio faucibus vel. Etiam id fermentum justo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nam a velit eu lacus rutrum blandit in nec ante. Suspendisse non fermentum neque, eu consequat metus. Donec at accumsan nulla. Nullam ac accumsan lectus, vitae mattis risus. Vivamus sed suscipit velit. Nullam tempor nibh elit, id egestas lorem lacinia eu. Maecenas ultricies tristique tortor nec consequat. Suspendisse non urna lorem. Phasellus in nisi sed ligula rhoncus ultrices. Sed pellentesque sodales arcu non auctor. Nullam bibendum interdum dapibus. Vivamus sollicitudin lectus id nulla tempus, eget luctus mi efficitur. Integer in ante sit amet eros hendrerit congue. Nulla facilisi. Integer quis condimentum urna. Suspendisse in felis ut ante tincidunt volutpat sed id velit. Donec ut posuere arcu. Etiam quis gravida ipsum. Phasellus faucibus pharetra libero, vel elementum ex feugiat sit amet. Duis non pulvinar felis. Suspendisse potenti. Integer a nibh nec nisl gravida vestibulum nec nec quam. Ut sit amet malesuada magna. Integer iaculis sollicitudin nunc, et elementum velit convallis eget. Nam dictum tempus est non facilisis. Nullam quis eros a orci fermentum tempus. Nulla gravida eros ac nunc varius, sed vulputate lacus dapibus. Curabitur non suscipit urna. Vivamus quis tellus purus. Donec quis elit et metus vehicula faucibus et vel libero. Morbi luctus metus ac magna dapibus, vel sodales est vehicula. Ut posuere dapibus sapien, ac varius libero. Sed blandit aliquet ante, vitae dictum sapien auctor et. Sed non metus nec tortor volutpat feugiat. Ut vel dictum odio. Cras id dolor id ligula egestas feugiat. Aliquam erat volutpat. Vivamus vehicula erat nec neque posuere tempus. Morbi ut massa bibendum, gravida arcu non, euismod quam. Donec tempus feugiat nisi, nec auctor felis vestibulum vitae. Vestibulum a leo augue. Ut tincidunt nulla id erat tincidunt vestibulum. Phasellus vitae est id nisl eleifend interdum. Nulla gravida velit nisi, vel vehicula risus convallis nec. Morbi tincidunt tellus in tincidunt vehicula. Vestibulum non metus in ex faucibus efficitur et sit amet lacus. Morbi id condimentum turpis. Fusce euismod dui vel orci rhoncus volutpat. Sed id est vestibulum, ultrices libero id, varius sapien. Integer sed condimentum orci. Proin nec justo a ligula volutpat lacinia nec vel est. Morbi ut lorem varius, iaculis orci sit amet, auctor nulla. Duis at eros id nulla interdum maximus. Ut consequat, metus et blandit vestibulum, elit est eleifend justo, ut facilisis risus lectus sit amet nunc. Sed auctor, sem eget auctor interdum, quam orci mollis libero, ut luctus mauris leo et turpis. Nulla facilisi. Vestibulum in justo sed arcu consequat rhoncus. Suspendisse vitae est at mi pharetra mattis. In suscipit, magna a vestibulum aliquam, nulla lorem dignissim mi, in tristique felis ligula eget ante. Maecenas congue justo et erat ultricies, eu mollis elit consequat. Integer id lacus quis leo luctus faucibus. Mauris vel rhoncus quam. Sed condimentum odio vel odio malesuada, ut aliquet sapien mollis. Nam tempus orci a metus iaculis, a placerat risus sollicitudin. Sed eu arcu tristique, fermentum sapien at, rutrum risus. Curabitur fringilla ipsum id turpis dictum, sed aliquam quam tristique. Donec varius interdum dolor, in vestibulum magna. Nulla facilisi. Aenean finibus ex at velit consectetur, nec ultricies metus varius. Donec nec dapibus libero. Maecenas id bibendum mauris. Integer efficitur ex eget leo congue, et mattis ligula euismod. Vivamus ullamcorper condimentum urna. Ut mollis, mauris vitae sodales tempus, purus dui viverra mi, nec convallis odio magna ut dolor. In bibendum eleifend metus. Morbi consequat viverra ligula, a ultricies nunc varius eu. Nulla blandit ipsum nec metus gravida feugiat. Proin a nisl at mi vehicula consequat. Vivamus vitae mauris vitae est eleifend luctus. Cras fringilla erat nec nunc vestibulum, vel laoreet justo ullamcorper. Integer pulvinar nec quam eget vulputate. Sed ac malesuada metus. Morbi congue rhoncus risus a aliquet. Phasellus ut elit id nisi auctor consequat. Vestibulum a nibh sed purus dictum accumsan. Sed tincidunt volutpat ipsum. Cras in risus nec mi ultrices gravida. Nam sit amet urna nec turpis tempus tincidunt. Sed tincidunt, sem vel lobortis fringilla, nunc purus fermentum arcu, eu hendrerit eros neque eget sem. Pellentesque fringilla justo id urna fermentum, eu tempor ante dignissim. Vestibulum aliquam tincidunt nunc non tincidunt. Nullam sit amet dolor quis eros fringilla rutrum. Nulla faucibus nisl eu libero vulputate laoreet. Nullam condimentum quam ac neque aliquet scelerisque. Sed elementum odio sit amet justo gravida, ac varius lacus posuere. In et eros et nulla egestas volutpat. Integer et eleifend felis. Cras vitae ex a quam pharetra eleifend sed auctor lorem. Cras placerat velit id diam efficitur, a dignissim orci vulputate. Cras et purus at libero ultricies faucibus. Morbi id nulla a libero efficitur accumsan. Nullam euismod odio a elit posuere, in vehicula leo hendrerit. Cras lacinia mauris quis sem finibus condimentum. Duis efficitur dapibus ex. Morbi vel eros nec lacus malesuada fermentum nec sed urna. Phasellus nec tristique libero. Duis vehicula nisl nec nulla iaculis, nec laoreet lacus lacinia. Morbi vitae dolor condimentum, rhoncus justo in, posuere odio. Donec a magna ac felis ultricies pellentesque. Nam at lectus id dolor venenatis rutrum. Sed sollicitudin purus non finibus molestie. Sed suscipit bibendum felis. Mauris vehicula volutpat magna. Morbi non nulla in orci scelerisque auctor. Vivamus pretium euismod ligula id interdum. Integer rutrum feugiat ultricies. Mauris in est ut dolor fringilla sodales non nec neque. Vivamus ullamcorper, orci nec pharetra ultricies, ipsum nisl commodo metus, nec elementum libero ligula vel ex. Sed nec tortor urna. Nullam pellentesque gravida nunc nec efficitur. Nam lacinia odio eu pharetra commodo. Nullam non ante id erat dictum tristique. In lacinia lacinia nisl, et tempus enim. Nullam sit amet nisi non lacus viverra convallis. Vivamus sit amet orci vel justo ultricies bibendum ac auctor odio. Integer eget ex non elit elementum lacinia eu id elit. Nullam consectetur elit eget efficitur consequat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec ac odio sollicitudin, dapibus magna at, condimentum nisi. Nullam quis eros erat. Aliquam in pharetra justo. Proin et dolor sed mauris euismod vehicula a vel lorem. Ut vitae efficitur nunc. Cras vel bibendum ex. Etiam vel interdum lectus. Sed nec eros vel leo aliquam tristique. Curabitur vitae arcu in quam tincidunt feugiat. Integer vitae lorem ut lorem facilisis fermentum. Nam et mauris nec orci placerat auctor. Mauris convallis venenatis fringilla. Etiam bibendum, libero ac lobortis sagittis, velit elit ultricies tellus, vel malesuada turpis justo non mi. Ut blandit volutpat metus, ut malesuada orci interdum vitae. Pellentesque suscipit tortor vitae nisi vehicula condimentum. Donec eu quam ac libero ultricies fermentum. Etiam sit amet elit at elit vehicula mattis. Integer nec consectetur odio. Suspendisse ac felis ac elit eleifend vulputate. Vivamus vestibulum nulla vel velit bibendum suscipit. Morbi aliquam est non tortor scelerisque, eget consequat ipsum rhoncus. Sed ac quam sed quam ultricies dignissim. Proin sit amet nisl vehicula, dapibus mauris in, gravida leo. Mauris et ex eu nulla aliquam tristique ut ac odio. Morbi et orci id ipsum volutpat malesuada. Duis at nisi in mi scelerisque blandit et nec ligula. Nam nec ligula hendrerit, rhoncus risus id, congue eros. Nulla facilisi. Aenean porttitor nunc at luctus feugiat. Maecenas hendrerit purus vitae nulla sodales vulputate. Donec auctor ligula ut magna consectetur tristique. Nulla facilisi. Proin in lorem nec arcu vehicula accumsan. Mauris quis arcu eget purus congue hendrerit. Donec accumsan urna vel ipsum euismod efficitur. Etiam posuere est nisi, nec sollicitudin velit eleifend a. Nullam euismod felis ut turpis venenatis, vitae convallis enim suscipit. In scelerisque nisl non dapibus laoreet. Sed ut nulla eget odio gravida dignissim. Aliquam ac mi tincidunt, fringilla elit vel, fringilla nisi. Pellentesque euismod lacinia tellus, ac convallis risus. Mauris tincidunt justo ligula, nec posuere est tincidunt et. Phasellus eu turpis sollicitudin, malesuada purus ac, ullamcorper turpis. Integer in orci ipsum. Maecenas quis malesuada nulla, vel sollicitudin nunc. Nam in urna dui. Pellentesque sit amet vulputate metus. Nulla facilisi. Morbi nec ante nec sapien commodo tincidunt et id elit. Vivamus pharetra, mi et vulputate tempor, enim nisl consectetur eros, et sodales eros enim sed turpis. Duis fermentum urna id nulla sodales, vel accumsan lectus lacinia. Ut in sagittis dolor. Nullam tempor urna vel metus auctor, nec laoreet tortor laoreet. Sed fermentum tempus est vel lacinia. Nullam hendrerit felis nec justo euismod, eu bibendum dui convallis. Donec gravida lacinia quam a interdum. Proin at condimentum nulla, nec iaculis elit. Sed finibus lorem id condimentum interdum. Integer vehicula nisl nec pharetra auctor. Integer convallis lorem eget neque feugiat, vitae bibendum ipsum tincidunt. Sed vel tincidunt justo, vitae ullamcorper turpis. Nam eleifend, felis vel facilisis aliquet, risus velit viverra magna, in consequat libero nisl sed quam. Mauris lobortis eleifend dolor id blandit. Duis auctor vitae elit id ullamcorper. Nam fermentum, sem id rhoncus lacinia, sapien velit efficitur risus, nec tempor turpis libero non ante. Nulla facilisi. Proin vel nunc eu est sodales tempor a sit amet tortor. Ut quis erat id eros malesuada aliquet. Nulla ultricies tincidunt diam vitae posuere. Nullam porttitor lorem quis lacinia ultrices. Etiam tristique augue ac erat bibendum, a elementum dui consectetur. Aliquam quis velit eleifend, condimentum orci vitae, malesuada orci. Donec commodo scelerisque sodales. Vivamus hendrerit mauris ac lectus suscipit, at rhoncus purus bibendum. Nulla facilisi. Morbi suscipit vel enim sed varius. Sed vulputate, ipsum id elementum eleifend, lorem est consequat felis, et mattis dui nulla ac nibh. Nullam vel ex nec nisl feugiat fermentum. In eget lacus tellus. Ut consequat ipsum velit, eget pharetra turpis congue at. Integer viverra nunc at erat gravida, nec egestas ex pulvinar. Curabitur vehicula ipsum eu nisl facilisis feugiat. Phasellus euismod nisi metus, sed vehicula velit malesuada at. Nam at risus eget arcu consectetur rutrum. Integer ac accumsan felis. Phasellus nec nibh volutpat, tincidunt felis nec, gravida ligula. Ut congue vestibulum semper. Integer laoreet libero in purus consequat, ut accumsan dui blandit. Phasellus tincidunt elit at ipsum viverra, ac venenatis justo ultricies. Morbi tincidunt leo eget lorem blandit, eu malesuada quam dictum. Vivamus nec dolor tristique, posuere quam in, malesuada dui. Maecenas at tincidunt metus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Duis nec odio ac metus iaculis suscipit. Ut eget dui eget erat consectetur scelerisque ut sit amet purus. Etiam convallis dolor quis nisi blandit, vel tristique neque accumsan. Suspendisse ornare sem non metus auctor, id tincidunt est scelerisque. Morbi quis justo vestibulum, ullamcorper sapien et, dapibus est. Vivamus vel magna nec nisl venenatis dignissim. Vestibulum malesuada vel purus ut vehicula. Vestibulum et mauris sit amet lacus ullamcorper varius. Mauris mattis, nisl a efficitur consectetur, tortor turpis pharetra diam, et faucibus lacus ipsum ac odio. Mauris pellentesque scelerisque sem eget tincidunt. Nulla facilisi. Nullam eu rhoncus nulla. Nam vitae velit a ligula consectetur fermentum. Integer consequat felis ac tempor lacinia. Morbi elementum justo magna, at posuere ligula lobortis non. Donec egestas ante ac odio laoreet pharetra. Aliquam pharetra ex vel dolor pellentesque, nec congue mauris fermentum. Vestibulum eu elit aliquet, suscipit elit a, scelerisque lectus. Mauris et blandit leo, in commodo odio. Integer consectetur, nisi vel efficitur euismod, libero magna efficitur orci, eget suscipit libero urna nec nisi. Sed vitae metus vel eros ullamcorper cursus. Donec in vestibulum ex, vel condimentum metus. Maecenas rhoncus ex et sem sollicitudin, et molestie magna viverra. Morbi ultrices ex a odio suscipit, vel molestie dui consequat. Nam malesuada dolor nec metus accumsan, ac suscipit justo accumsan. Donec tempor vestibulum tellus, ut rutrum tortor dapibus et. Nam et suscipit quam. Donec laoreet, metus sit amet lacinia ullamcorper, eros quam tempor ligula, ac molestie felis velit et nulla. Vestibulum ut varius lacus. Integer at laoreet felis. Donec sit amet est nec lorem convallis iaculis. Suspendisse nec lectus nec mauris egestas auctor. Sed id lorem sit amet orci fringilla dignissim ac ut libero. Suspendisse congue interdum nulla, vel pellentesque libero mattis a. Proin ac quam sed velit auctor ultrices. Nulla tincidunt accumsan mauris, ut interdum sem dictum vitae. Proin vel risus sed nisl sodales gravida. Curabitur mattis, dui eu posuere sodales, ligula est condimentum risus, ut eleifend purus metus quis libero. Fusce eget turpis et metus facilisis vestibulum. Phasellus nec tellus sed ligula ultrices suscipit vel non mauris. Duis tristique ipsum nec odio rhoncus sollicitudin. Ut eget mauris turpis. Aliquam id felis vitae sem facilisis cursus. Cras vehicula dolor vel tellus tristique luctus. Cras maximus, est nec fringilla fringilla, lorem turpis fermentum purus, eu commodo lacus lacus eget sapien. Phasellus laoreet malesuada velit. Vestibulum id ullamcorper odio. Mauris tempor libero id urna consectetur sollicitudin. Suspendisse potenti. Etiam nec mi ac ex fermentum dapibus. Maecenas eu est ac mi mattis tempor eu quis sapien. Phasellus semper arcu ut mauris tristique, et accumsan enim tincidunt. Sed in vestibulum nisl. Suspendisse vehicula nunc non nisi molestie, nec venenatis nisi vestibulum. Sed tincidunt, lectus nec dapibus consectetur, risus purus tincidunt felis, et dapibus odio mauris vitae nisi. Ut vehicula convallis dolor, id consequat tortor suscipit ac. Mauris non velit ultrices, tincidunt odio a, bibendum lacus. Morbi eget commodo purus. Maecenas tristique tortor eu purus ultricies, eu faucibus urna fermentum. Vestibulum auctor nisi sed nunc auctor, sed ultricies enim fermentum. Nullam sit amet dui non sem sodales malesuada a eget nunc. Integer vulputate magna a arcu congue fermentum. In varius pellentesque nulla vitae dictum. Ut et diam magna. In hac habitasse platea dictumst. Ut consectetur, libero id egestas venenatis, leo eros pharetra lorem, at tempor est magna ut leo. Morbi eleifend magna ac placerat consequat. Pellentesque id felis at nisi lobortis aliquet. Sed a vestibulum elit. Sed vestibulum enim ut ipsum euismod, eu vehicula sapien posuere. Integer rhoncus bibendum ex vel efficitur. Vestibulum et justo dui. Duis euismod sem ut magna tempor, vitae rhoncus metus volutpat. Etiam id velit eget elit pellentesque molestie id ac magna. Nullam et suscipit nisl, et condimentum nulla. In ultricies suscipit fringilla. Donec in tincidunt ex. Sed sed ligula mi. Duis varius non elit at tristique. Sed nec consectetur sem. Sed aliquet malesuada nisl, nec suscipit justo. Nulla fermentum ut ipsum id dictum. Cras accumsan varius velit eget luctus. Donec vehicula, mi a dignissim convallis, lorem mauris blandit orci, a aliquam quam odio eget mauris. Nulla ultricies velit vel diam aliquet, a vehicula magna fringilla. Etiam ac diam a odio consectetur gravida a nec ligula. Suspendisse aliquam id nibh sit amet scelerisque. Vivamus vitae risus convallis, tincidunt sem ac, rutrum leo. Nam et volutpat ex. Nulla laoreet nisl id urna volutpat dapibus. Maecenas in posuere felis. Nullam id risus nulla. Curabitur et velit quis lectus vestibulum dapibus. Nulla facilisi. Aliquam vitae orci ut purus vestibulum ultricies. Morbi tincidunt placerat nunc, a ultricies purus. Cras tincidunt aliquam neque. Nam et nunc risus. Nulla facilisi. Ut eleifend, est a sollicitudin pharetra, nunc purus ultrices diam, sed egestas leo elit sed purus. Nulla scelerisque orci eu nisi varius condimentum. Nulla ultricies diam sit amet vestibulum scelerisque. Duis convallis urna nec ligula ultrices, non faucibus lacus hendrerit. Phasellus ullamcorper justo ut tortor elementum efficitur. Maecenas sed dolor nec eros facilisis tincidunt. Proin eget orci lectus. Pellentesque in dui non lectus vehicula convallis. Integer consequat enim nec orci tincidunt convallis. Vestibulum nec nisi a ex vehicula sollicitudin. Phasellus consectetur placerat turpis. Nullam accumsan, ex id efficitur tempus, velit dui convallis mauris, non vehicula est arcu nec tortor. Integer volutpat vestibulum",
            mode: FileMode.write,
            flush: true,
          );
          if (kDebugMode) {
            print('Text saved to ${file.path}');
          }

          if (context.mounted) {
            context.read<DiagnosticBloc>().add(
                  UploadDiagnosticEvent(
                    file: file,
                  ),
                );
          }
        }
      }
    } catch (e) {
      print('Error saving file: $e');
    }
  }

  void showSuccess({required String msg}) {
    Flushbar(
      title: 'Success',
      message: msg,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  void showError({required String msg}) {
    Flushbar(
      title: 'Error',
      message: msg,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DiagnosticBloc, DiagnosticState>(
        listener: (context, state) {
          if (state is DiagnosticUploadedState &&
              (state.response?.downloadLink != null)) {
            GoRouter.of(context).pop();
            context.showSuccess(
              msg: 'Your message and other details has been sent successfully.',
            );
          }
          if (state is DiagnosticErrorState) {
            context.showError(msg: state.message);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 05.0.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    20.verticalSpace,
                    Container(
                      decoration: secondaryWidgetDecoration(),
                      child: TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        maxLines: 5,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          contentPadding: EdgeInsets.all(20.0.h),
                          isDense: true,
                          prefixIconConstraints:
                              const BoxConstraints(minWidth: 0, minHeight: 0),
                          alignLabelWithHint: false,
                          filled: true,
                          fillColor: AppColors.white,
                          hintText: "Type your message here",
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                    30.verticalSpace,
                    Column(
                      children: [
                        Text.rich(
                          textAlign: TextAlign.justify,
                          style: Styles.textStyleDark12dpBold.copyWith(),
                          TextSpan(
                            text:
                                "By clicking “Submit,” you acknowledge that our support team may review diagnostics, performance and metadata related to your account. This data is crucial for troubleshooting and resolving the issue you’ve reported. ",
                            style: Styles.textStyledarkBlack12dpRegular,
                            children: const [
                              // TextSpan(
                              //   text: 'Learn more',
                              //   style:Styles.textStyledarkBlack12dpRegular,
                              //   recognizer: TapGestureRecognizer()
                              //     ..onTap = () {
                              //       // Add your action here for when "Learn more" is tapped
                              //     },
                              // ),
                            ],
                          ),
                          softWrap: true,
                        ),
                        5.verticalSpace,
                        Text(
                          "Your privacy is important to us, and we handle this data securely. Thank you for your cooperation in resolving the issue!",
                          style: Styles.textStyledarkBlack12dpRegular,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 40.h,
                      width: double.infinity, // Make the container full width

                      child: ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_controller.text.isEmpty) {
                            showError(msg: 'Please enter your message');
                            return;
                          }
                          _saveToFile();
                        },
                        style: CustomElevatedButtonStyle.primaryButtonStyle(
                          backgroundColor: AppColors.red,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: Styles.textStyledarkWhite13dpBold,
                        ),
                      ),
                    ),
                    12.verticalSpace,
                  ],
                ),
              ),
              if (state is DiagnosticLoadingState)
                Container(
                  alignment: Alignment.center,
                  color: Colors.black12,
                  child: const CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription!.cancel();
    }
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status : $e');

      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }
}
