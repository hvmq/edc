import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/controllers/app_controller.dart';

class ReadingController extends AppController {
  List<String> bookPages = [
    '''
Chapter 1: The Awakening

The village of Eldoria had always been a quiet and peaceful place. Surrounded by towering mountains and lush forests, it was a place where time seemed to stand still. The people of Eldoria lived simple lives, farming the land, tending to their animals, and enjoying the beauty of nature that surrounded them.

But one morning, something was different. The usual sounds of the village—the clatter of pots and pans, the hum of the wind in the trees—were gone. In their place was an eerie silence. The sun had not risen. A thick blanket of mist hung over the village, and the air was heavy with an unnatural stillness.

Out of the mist, a tall man appeared, cloaked in shadow with eyes that glowed like embers. "I am the herald of the Dark One," he said. "And I bring a message. The time of peace in Eldoria is over."

The village elder, Elara, stood firm. "We will never bow to the Dark One."

But the herald only laughed. "The Dark One is already among you. Soon, he will reveal himself, and there will be no escape."

The villagers, gripped by fear, prepared for the worst. Among them was a young man named Kael, who had always felt something strange stirring inside him. That night, Kael couldn’t sleep, his mind filled with questions. Could the dark power be connected to the strange feeling inside him?
''',
    """
Chapter 2: The Power Within

The next morning, the villagers were abuzz with preparations. Elara called for a meeting of the village's leaders, discussing how they could fortify Eldoria. But Kael knew, deep down, that no matter how many defenses they built, it wouldn’t be enough to stop the Dark One.

As Kael wandered through the village, he overheard the fearful whispers of the villagers. He couldn't help but think about the dark force the herald spoke of. That night, as Kael lay awake in bed, he heard a soft knock at his door.

"It’s me, Elara," came the familiar voice of the village elder.

Elara entered Kael’s home, her face serious. "Kael, there's something you need to know. There’s a power inside you, a power tied to an ancient lineage—the Guardians, who once defeated the Dark One."

Kael was stunned. "I’m just a villager. How can I stop something so powerful?"

Elara’s gaze was firm. "You are descended from the Guardians, and that power may be the key to stopping the Dark One."
""",
    '''
Chapter 3: The Training Begins

The next day, Elara began training Kael. "You must learn to control the power within you," she said as they stood in the forest, away from prying eyes. The ancient power of the Guardians was dangerous if left unchecked, but Kael needed to harness it if they had any hope of defeating the Dark One.

Kael struggled at first. The power inside him was wild, like a flame that threatened to consume him. But Elara was patient, guiding him through the exercises passed down from the Guardians of old.

Days turned into weeks, and though Kael made progress, the weight of responsibility pressed heavily on his shoulders. "I don’t know if I’m ready," Kael admitted one evening, exhausted from training.

Elara placed a hand on his shoulder. "No one ever feels ready, Kael. But when the time comes, you will find the strength you need."

But as Kael trained, the Dark One’s presence grew stronger. Shadows lingered at the edges of the village, and strange occurrences unsettled the villagers. Time was running out.
''',
    '''
Chapter 4: The First Encounter

It was a cold night when the attack came. Dark creatures, twisted by the Dark One’s power, descended upon Eldoria, their red eyes glowing in the moonlight. The village’s defenses were no match for them. The villagers fought bravely, but it was clear they were outmatched.

Kael felt the power surge inside him as he rushed to defend his home. The creatures were terrifying, but with Elara’s training, he could channel the power of the Guardians. A brilliant light burst from his hands, and the creatures recoiled.

For the first time, Kael felt in control of the power inside him. He fought alongside the villagers, pushing the dark creatures back into the forest. But just as they thought they had won, the herald of the Dark One appeared once more, his eyes burning with dark energy.

"You have grown stronger, Kael," the herald said, his voice like a snake’s hiss. "But it will not be enough. The Dark One will rise, and you will fall."

Before Kael could respond, the herald vanished, leaving behind a chilling sense of dread. Kael knew then that this was only the beginning.
''',
    '''
Chapter 5: The Journey Ahead

After the attack, Eldoria was left in ruins. Many villagers were injured, and the sense of fear had only grown. Kael stood with Elara on the edge of the village, looking out into the dark forest. "The Dark One is coming," Kael said quietly.

Elara nodded. "We cannot fight him alone. There are others out there—descendants of the Guardians like you. We must find them if we are to stand any chance."

Kael knew she was right. He could feel the power inside him growing stronger each day, but it wasn’t enough. The Dark One’s forces were vast, and Kael would need allies if they hoped to defeat him.

And so, the journey began. Kael and Elara set out from Eldoria, traveling through the forests and mountains in search of others who carried the blood of the Guardians. Along the way, Kael would face trials and challenges that would test not only his strength but his resolve.

The Dark One’s shadow loomed ever closer, but Kael was no longer the frightened villager he once was. He was a Guardian, and though the path ahead was uncertain, he would fight for the light.
'''
  ].obs;
  late PageController pageController;
  final RxInt currentPage = 0.obs;
  final RxBool isHorizontalMode = true.obs; // Default is horizontal mode

  @override
  Future<void> onInit() async {
    super.onInit();
    pageController = PageController(initialPage: currentPage.value);
  }

  void nextPage() {
    if (currentPage.value < bookPages.length - 1) {
      currentPage.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Chuyển đổi giữa chế độ đọc ngang và dọc
  void toggleMode() {
    isHorizontalMode.value = !isHorizontalMode.value;
  }

  // Thiết lập trang hiện tại
  void setCurrentPage(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }
}
