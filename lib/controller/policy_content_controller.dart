import 'package:flutter_extension/data/model/policy_page_args.dart';
import 'package:flutter_extension/data/model/policy_section_model.dart';
import 'package:get/get.dart';

class PolicyContentController extends GetxController {
  String _title = 'Privacy Policy';
  List<PolicySectionModel> _sections = const <PolicySectionModel>[];

  String get title => _title;
  List<PolicySectionModel> get sections => _sections;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is PolicyPageArgs) {
      _title = args.title;
    } else if (args is String && args.isNotEmpty) {
      _title = args;
    }
    _sections = _defaultSections;
  }

  static const List<PolicySectionModel> _defaultSections = <PolicySectionModel>[
    PolicySectionModel(
      title: '1. Lorem ipsum',
      body:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    PolicySectionModel(
      title: '2. Lorem ipsum',
      body:
          'Magna etiam tempor orci eu lobortis elementum nibh. Vulputate enim nulla aliquet porttitor lacus. Orci sagittis eu volutpat odio. Cras semper auctor neque vitae tempus quam pellentesque nec. Non quam lacus suspendisse faucibus interdum posuere lorem ipsum dolor. Commodo elit at imperdiet dui. Nisi vitae suscipit tellus mauris a diam. Erat pellentesque adipiscing commodo elit at imperdiet dui. Mi ipsum faucibus vitae aliquet nec ullamcorper. Pellentesque pulvinar pellentesque habitant morbi tristique senectus et.',
    ),
    PolicySectionModel(
      title: '3. Lorem ipsum',
      body:
          'Consequat id porta nibh venenatis cras sed. Ipsum nunc aliquet bibendum enim facilisis gravida neque. Nibh tellus molestie nunc non blandit massa. Quam pellentesque nec nam aliquam sem et tortor consequat id. Faucibus vitae aliquet nec ullamcorper sit amet risus. Nunc consequat interdum varius sit amet. Eget magna fermentum iaculis eu non diam phasellus vestibulum. Pulvinar pellentesque habitant morbi tristique senectus et. Lorem donec massa sapien faucibus et molestie. Massa tempor nec feugiat nisl pretium fusce id. Lacinia at quis risus sed vulputate odio. Integer vitae justo eget magna fermentum iaculis. Eget gravida cum sociis natoque penatibus et magnis.',
    ),
    PolicySectionModel(
      title: '4. Lorem ipsum',
      body:
          'Condimentum id venenatis a condimentum vitae sapien pellentesque habitant morbi. Amet consectetur adipiscing elit ut aliquam. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus. Ut tristique et egestas quis ipsum suspendisse ultrices gravida dictum. Eget duis at tellus at urna condimentum mattis pellentesque id.',
    ),
  ];
}
