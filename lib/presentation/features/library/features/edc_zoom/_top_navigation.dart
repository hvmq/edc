part of 'edc_zoom_screen.dart';

extension TopNavigationButtons on EDCZoomScreen {
  Widget _topNavigationButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Wrap(
        spacing: 8.0, // Space between items horizontally
        runSpacing: 8.0, // Space between items vertically
        children: [
          _buildButton(
              "New", const Color(0xff124984), IconConstants.icon_new_top_bottom,
              () {
            print('new');
          }),
          _buildButton("Join", const Color(0xff369C09),
              IconConstants.icon_join_top_bottom, () {
            print('Join');
          }),
          _buildButton("Schedule", const Color(0xff141284),
              IconConstants.icon_schedule_top_bottom, () {
            print('Schedule');
          }),
          _buildButton("Notes", const Color(0xff601284),
              IconConstants.icon_note_top_bottom, () {
            print('Notes');
          }),
          _buildButton("History", const Color(0xff128469),
              IconConstants.icon_history_top_bottom, () {
            print('History');
          }),
          _buildButton("Consulting", const Color(0xff11B4E8),
              IconConstants.icon_consulting_top_bottom, () {
            print('Consulting');
          }),
        ],
      ),
    );
  }

  Widget _buildButton(
      String label, Color color, String imageUrl, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(26),
          ),
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment:
                      PlaceholderAlignment.middle, // Align icon to middle
                  child: Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    child: Image.asset(imageUrl),
                  ),
                ),
                TextSpan(
                  text: label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16, // Adjust font size if necessary
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
