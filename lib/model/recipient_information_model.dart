import '../custom_assets/assets.gen.dart';

class RecipientModel {
  final String imagePath;
  final String title;
  final String subTitle;

  RecipientModel(
      {required this.imagePath, required this.title, required this.subTitle});
}

List<RecipientModel> onRecipientPages = [
  RecipientModel(
    title: 'Criti Prolana',
    subTitle: 'critiprolan@gmail.com',
    imagePath: Assets.clipart.sampleProfile.path,
  ),
  RecipientModel(
    title: 'Jhon Brilicam',
    subTitle: 'jhonbrilicam@gmail.com',
    imagePath: Assets.clipart.sampleProfile.path,
  ),
  RecipientModel(
    title: 'Lirian Jhos',
    subTitle: 'lirianjhos@gmail.com',
    imagePath: Assets.clipart.sampleProfile.path,
  ),
  RecipientModel(
    title: 'Nirimbo',
    subTitle: 'nirimbo@gmail.com',
    imagePath: Assets.clipart.sampleProfile.path,
  ),
  RecipientModel(
    title: 'William Son',
    subTitle: 'williamson@gmail.com',
    imagePath: Assets.clipart.sampleProfile.path,
  ),
];
