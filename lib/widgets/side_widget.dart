import 'package:fluent_ui/fluent_ui.dart';

class SideWidget extends StatelessWidget {
  final String title;
  final dynamic titleIcon;
  final String dataValue;
  const SideWidget({
    super.key,
    required this.title,
    this.titleIcon,
    required this.dataValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // width: 130,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                ),
                Icon(titleIcon)
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            dataValue,
            style: const TextStyle(fontSize: 32),
          ),
        ],
      ),
    );
  }
}
