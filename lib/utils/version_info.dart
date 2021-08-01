import 'package:flutter/material.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';

class VersionInfo extends StatefulWidget {
  VersionInfo({Key? key}) : super(key: key);

  @override
  _VersionInfoState createState() => _VersionInfoState();
}

class _VersionInfoState extends State<VersionInfo> {

  @override
  void initState() {
    super.initState();
    versionInfoBloc.getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: blocks.size(14), bottom: blocks.size(20)),
      child: Row(
        children: [
          StreamBuilder<PackageInfo>(
            stream: versionInfoBloc.subjectPackageInfo,
            builder: (context, snapshot) {
              return TextX(text: "Version ${snapshot.hasData ? snapshot.data!.version : ""}", color: ColorsX.coolGrey, fontWeight: FontWeight.w400, fontSize: 14.0);
            }
          )
        ],
      ),
    );
  }
}

class VersionInfoBloc{

  final BehaviorSubject _subjectPackageInfo = BehaviorSubject<PackageInfo>();
  BehaviorSubject<PackageInfo> get subjectPackageInfo => _subjectPackageInfo as BehaviorSubject<PackageInfo>;

  getVersion(){
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      _subjectPackageInfo.sink.add(packageInfo);
    });
  }

  dispose(){
    _subjectPackageInfo.close();
  }
}
var versionInfoBloc = VersionInfoBloc();
