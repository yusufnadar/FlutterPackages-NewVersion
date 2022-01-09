import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

class NewVersionPage extends StatefulWidget {
  const NewVersionPage({Key? key}) : super(key: key);

  @override
  _NewVersionPageState createState() => _NewVersionPageState();
}

class _NewVersionPageState extends State<NewVersionPage> {
  var result;

  @override
  void initState() {
    super.initState();
    versionControl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Version'),
      ),
      body: Center(
        child: Text(
          result != null ? result.toString() : 'Boş',
          style: const TextStyle(fontSize: 50),
        ),
      ),
    );
  }

  Future<void> versionControl() async {
    final newVersion = NewVersion(androidId: 'com.unigram.unigram');
    final status = await newVersion.getVersionStatus();
    if(status!.canUpdate){
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        allowDismissal: true,
        dialogTitle: 'Güncelle',
        dialogText: 'Uygulama yeni version geldi',
        dismissButtonText: 'Sonra Güncelle',
        updateButtonText: 'Güncelle Hadi',
      );
    }else{
      newVersion.showAlertIfNecessary(context: context);
    }
    /*
    final status = await newVersion.getVersionStatus();
    setState(() {
      result = status!.localVersion;
    });
     */
  }
}
