import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/get_controller.dart';

class EditUser extends StatelessWidget {
  EditUser({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shaxsiy ma\'lumotlar'.tr),
        centerTitle: false,
        toolbarTextStyle: TextStyle(fontSize: _getController.width.value * 0.048, fontWeight: FontWeight.w600),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06), onPressed: () {Get.back();})
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: EdgeInsets.only(left: _getController.width.value * 0.05, top: _getController.width.value * 0.04, bottom: _getController.width.value * 0.04),
                  child: _getController.meModel.value.data!.result!.avatar == null
                      ? CircleAvatar(
                      radius: _getController.width.value * 0.12,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(_getController.meModel.value.data!.result!.fullName.toString().substring(0,1), style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: _getController.width.value * 0.06))
                  )
                      : CircleAvatar(
                      radius: _getController.width.value * 0.12,
                      backgroundImage: NetworkImage(_getController.meModel.value.data!.result!.avatar.toString())
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: _getController.width.value * 0.05, top: _getController.width.value * 0.04, bottom: _getController.width.value * 0.04),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_getController.meModel.value.data!.result!.fullName.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.045, fontWeight: FontWeight.w600)),
                        SizedBox(height: _getController.height.value * 0.004),
                        Text('ID ${_getController.meModel.value.data!.result!.sId.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: _getController.width.value * 0.04))
                      ]
                  )
              )
            ],
          ),

        ],
      )
    );
  }
}