import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/nfc_manager_ios.dart';
import 'package:nfc_manager_felica/src/felica.dart';

final class FeliCaPlatformIos implements FeliCa {
  const FeliCaPlatformIos._(this._tech);

  final FeliCaIos _tech;

  static FeliCaPlatformIos? from(NfcTag tag) {
    final tech = FeliCaIos.from(tag);
    return tech == null ? null : FeliCaPlatformIos._(tech);
  }

  @override
  Uint8List get systemCode => _tech.currentSystemCode;

  @override
  Uint8List get idm => _tech.currentIDm;

  @override
  Future<FeliCaPollingResponse> polling({
    required Uint8List systemCode,
    required FeliCaPollingRequestCode requestCode,
    required FeliCaPollingTimeSlot timeSlot,
  }) {
    return _tech
        .polling(
          systemCode: systemCode,
          requestCode: FeliCaPollingRequestCodeIos.values.byName(
            requestCode.name,
          ),
          timeSlot: FeliCaPollingTimeSlotIos.values.byName(timeSlot.name),
        )
        .then(
          // ignore: invalid_use_of_visible_for_testing_member
          (value) => FeliCaPollingResponse(
            pmm: value.manufacturerParameter,
            requestData: value.requestData,
          ),
        );
  }

  @override
  Future<List<Uint8List>> requestService({
    required List<Uint8List> nodeCodeList,
  }) {
    return _tech.requestService(nodeCodeList: nodeCodeList);
  }

  @override
  Future<int> requestResponse() {
    return _tech.requestResponse();
  }

  @override
  Future<FeliCaReadWithoutEncryptionResponse> readWithoutEncryption({
    required List<Uint8List> serviceCodeList,
    required List<Uint8List> blockList,
  }) {
    return _tech
        .readWithoutEncryption(
          serviceCodeList: serviceCodeList,
          blockList: blockList,
        )
        .then(
          // ignore: invalid_use_of_visible_for_testing_member
          (value) => FeliCaReadWithoutEncryptionResponse(
            statusFlag1: value.statusFlag1,
            statusFlag2: value.statusFlag2,
            blockData: value.blockData,
          ),
        );
  }

  @override
  Future<FeliCaStatusFlag> writeWithoutEncryption({
    required List<Uint8List> serviceCodeList,
    required List<Uint8List> blockList,
    required List<Uint8List> blockData,
  }) {
    return _tech
        .writeWithoutEncryption(
          serviceCodeList: serviceCodeList,
          blockList: blockList,
          blockData: blockData,
        )
        .then(
          // ignore: invalid_use_of_visible_for_testing_member
          (value) => FeliCaStatusFlag(
            statusFlag1: value.statusFlag1,
            statusFlag2: value.statusFlag2,
          ),
        );
  }

  @override
  Future<List<Uint8List>> requestSystemCode() {
    return _tech.requestSystemCode();
  }

  @override
  Future<FeliCaRequestServiceV2Response> requestServiceV2({
    required List<Uint8List> nodeCodeList,
  }) {
    return _tech
        .requestServiceV2(nodeCodeList: nodeCodeList)
        .then(
          // ignore: invalid_use_of_visible_for_testing_member
          (value) => FeliCaRequestServiceV2Response(
            statusFlag1: value.statusFlag1,
            statusFlag2: value.statusFlag2,
            encryptionIdentifier: value.encryptionIdentifier,
            nodeKeyVersionListAes: value.nodeKeyVersionListAes,
            nodeKeyVersionListDes: value.nodeKeyVersionListDes,
          ),
        );
  }

  @override
  Future<FeliCaRequestSpecificationVersionResponse>
  requestSpecificationVersion() {
    return _tech.requestSpecificationVersion().then(
      // ignore: invalid_use_of_visible_for_testing_member
      (value) => FeliCaRequestSpecificationVersionResponse(
        statusFlag1: value.statusFlag1,
        statusFlag2: value.statusFlag2,
        basicVersion: value.basicVersion,
        optionVersion: value.optionVersion,
      ),
    );
  }

  @override
  Future<FeliCaStatusFlag> resetMode() {
    return _tech.resetMode().then(
      // ignore: invalid_use_of_visible_for_testing_member
      (value) => FeliCaStatusFlag(
        statusFlag1: value.statusFlag1,
        statusFlag2: value.statusFlag2,
      ),
    );
  }

  @override
  Future<Uint8List> sendFeliCaCommand({required Uint8List commandPacket}) {
    return _tech.sendFeliCaCommand(commandPacket: commandPacket);
  }
}
