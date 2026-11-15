import 'command_order_level.dart';

// "Komutları Sırala" oyununun 20 görevi. Veri web sürümündeki `levels.js` dosyasıyla aynıdır.
// Görseller okumayı yeni öğrenen çocuk için eylemin kendisini anlatır.
final commandOrderBaseLevels = [
  // Kolay 1–5: 2–3 adımlı günlük işler
  CommandOrderLevel(
    title: (t) => t.commandOrderL1Title,
    icon: 'assets/command-order/flower-water.webp',
    steps: [
      CommandStep((t) => t.commandOrderL1Step1, 'assets/command-order/flower-fill-can.webp'),
      CommandStep((t) => t.commandOrderL1Step2, 'assets/command-order/flower-water.webp'),
    ],
    hint: (t) => t.commandOrderL1Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL2Title,
    icon: 'assets/command-order/teeth-brush.webp',
    steps: [
      CommandStep((t) => t.commandOrderL2Step1, 'assets/command-order/teeth-paste.webp'),
      CommandStep((t) => t.commandOrderL2Step2, 'assets/command-order/teeth-brush.webp'),
      CommandStep((t) => t.commandOrderL2Step3, 'assets/command-order/teeth-rinse.webp'),
    ],
    hint: (t) => t.commandOrderL2Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL3Title,
    icon: 'assets/command-order/hands-soap.webp',
    steps: [
      CommandStep((t) => t.commandOrderL3Step1, 'assets/command-order/hands-soap.webp'),
      CommandStep((t) => t.commandOrderL3Step2, 'assets/command-order/hands-rinse.webp'),
      CommandStep((t) => t.commandOrderL3Step3, 'assets/command-order/hands-dry.webp'),
    ],
    hint: (t) => t.commandOrderL3Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL4Title,
    icon: 'assets/command-order/shoe-tie.webp',
    steps: [
      CommandStep((t) => t.commandOrderL4Step1, 'assets/command-order/shoe-sock.webp'),
      CommandStep((t) => t.commandOrderL4Step2, 'assets/command-order/shoe-on.webp'),
      CommandStep((t) => t.commandOrderL4Step3, 'assets/command-order/shoe-tie.webp'),
    ],
    hint: (t) => t.commandOrderL4Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL5Title,
    icon: 'assets/command-order/draw-color.webp',
    steps: [
      CommandStep((t) => t.commandOrderL5Step1, 'assets/command-order/draw-paper.webp'),
      CommandStep((t) => t.commandOrderL5Step2, 'assets/command-order/draw-sketch.webp'),
      CommandStep((t) => t.commandOrderL5Step3, 'assets/command-order/draw-color.webp'),
    ],
    hint: (t) => t.commandOrderL5Hint,
  ),
  // Orta 6–10: 4–5 adım
  CommandOrderLevel(
    title: (t) => t.commandOrderL6Title,
    icon: 'assets/command-order/sandwich-close.webp',
    steps: [
      CommandStep((t) => t.commandOrderL6Step1, 'assets/command-order/sandwich-plate.webp'),
      CommandStep((t) => t.commandOrderL6Step2, 'assets/command-order/sandwich-bread.webp'),
      CommandStep((t) => t.commandOrderL6Step3, 'assets/command-order/sandwich-cheese.webp'),
      CommandStep((t) => t.commandOrderL6Step4, 'assets/command-order/sandwich-close.webp'),
      CommandStep((t) => t.commandOrderL6Step5, 'assets/command-order/sandwich-eat.webp'),
    ],
    hint: (t) => t.commandOrderL6Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL7Title,
    icon: 'assets/command-order/toys-in.svg',
    steps: [
      CommandStep((t) => t.commandOrderL7Step1, 'assets/command-order/toys-box-bring.svg'),
      CommandStep((t) => t.commandOrderL7Step2, 'assets/command-order/toys-in.svg'),
      CommandStep((t) => t.commandOrderL7Step3, 'assets/command-order/toys-lid.svg'),
      CommandStep((t) => t.commandOrderL7Step4, 'assets/command-order/toys-shelf.svg'),
    ],
    hint: (t) => t.commandOrderL7Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL8Title,
    icon: 'assets/command-order/seed-sprout.webp',
    steps: [
      CommandStep((t) => t.commandOrderL8Step1, 'assets/command-order/seed-dig.webp'),
      CommandStep((t) => t.commandOrderL8Step2, 'assets/command-order/seed-drop.webp'),
      CommandStep((t) => t.commandOrderL8Step3, 'assets/command-order/seed-cover.webp'),
      CommandStep((t) => t.commandOrderL8Step4, 'assets/command-order/seed-water.webp'),
      CommandStep((t) => t.commandOrderL8Step5, 'assets/command-order/seed-sprout.webp'),
    ],
    hint: (t) => t.commandOrderL8Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL9Title,
    icon: 'assets/command-order/school-bag.webp',
    steps: [
      CommandStep((t) => t.commandOrderL9Step1, 'assets/command-order/school-wake.webp'),
      CommandStep((t) => t.commandOrderL9Step2, 'assets/command-order/school-dress.webp'),
      CommandStep((t) => t.commandOrderL9Step3, 'assets/command-order/school-bag.webp'),
      CommandStep((t) => t.commandOrderL9Step4, 'assets/command-order/school-bus.webp'),
    ],
    hint: (t) => t.commandOrderL9Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL10Title,
    icon: 'assets/command-order/letter-post.svg',
    steps: [
      CommandStep((t) => t.commandOrderL10Step1, 'assets/command-order/letter-write.svg'),
      CommandStep((t) => t.commandOrderL10Step2, 'assets/command-order/letter-in-envelope.svg'),
      CommandStep((t) => t.commandOrderL10Step3, 'assets/command-order/letter-seal.svg'),
      CommandStep((t) => t.commandOrderL10Step4, 'assets/command-order/letter-post.svg'),
    ],
    hint: (t) => t.commandOrderL10Hint,
  ),
  // Zor 11–15: 5–7 adım, ara hedefler
  CommandOrderLevel(
    title: (t) => t.commandOrderL11Title,
    icon: 'assets/command-order/cake-slice.webp',
    stages: [TaskStage((t) => t.commandOrderL11Stage1, 3), TaskStage((t) => t.commandOrderL11Stage2, 3)],
    steps: [
      CommandStep((t) => t.commandOrderL11Step1, 'assets/command-order/cake-ingredients.webp'),
      CommandStep((t) => t.commandOrderL11Step2, 'assets/command-order/cake-mix.webp'),
      CommandStep((t) => t.commandOrderL11Step3, 'assets/command-order/cake-pour.webp'),
      CommandStep((t) => t.commandOrderL11Step4, 'assets/command-order/cake-oven.webp'),
      CommandStep((t) => t.commandOrderL11Step5, 'assets/command-order/cake-bake.webp'),
      CommandStep((t) => t.commandOrderL11Step6, 'assets/command-order/cake-slice.webp'),
    ],
    hint: (t) => t.commandOrderL11Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL12Title,
    icon: 'assets/command-order/bath-in.svg',
    stages: [
      TaskStage((t) => t.commandOrderL12Stage1, 2),
      TaskStage((t) => t.commandOrderL12Stage2, 2),
      TaskStage((t) => t.commandOrderL12Stage3, 1),
    ],
    steps: [
      CommandStep((t) => t.commandOrderL12Step1, 'assets/command-order/bath-fill.svg'),
      CommandStep((t) => t.commandOrderL12Step2, 'assets/command-order/bath-in.svg'),
      CommandStep((t) => t.commandOrderL12Step3, 'assets/command-order/bath-shampoo.svg'),
      CommandStep((t) => t.commandOrderL12Step4, 'assets/command-order/bath-rinse.svg'),
      CommandStep((t) => t.commandOrderL12Step5, 'assets/command-order/bath-dry.svg'),
    ],
    hint: (t) => t.commandOrderL12Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL13Title,
    icon: 'assets/command-order/bike-pedal.svg',
    stages: [
      TaskStage((t) => t.commandOrderL13Stage1, 2),
      TaskStage((t) => t.commandOrderL13Stage2, 2),
      TaskStage((t) => t.commandOrderL13Stage3, 1),
    ],
    steps: [
      CommandStep((t) => t.commandOrderL13Step1, 'assets/command-order/bike-helmet.svg'),
      CommandStep((t) => t.commandOrderL13Step2, 'assets/command-order/bike-mount.svg'),
      CommandStep((t) => t.commandOrderL13Step3, 'assets/command-order/bike-pedal.svg'),
      CommandStep((t) => t.commandOrderL13Step4, 'assets/command-order/bike-brake.svg'),
      CommandStep((t) => t.commandOrderL13Step5, 'assets/command-order/bike-off.svg'),
    ],
    hint: (t) => t.commandOrderL13Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL14Title,
    icon: 'assets/command-order/library-choose.svg',
    stages: [
      TaskStage((t) => t.commandOrderL14Stage1, 3),
      TaskStage((t) => t.commandOrderL14Stage2, 2),
      TaskStage((t) => t.commandOrderL14Stage3, 1),
    ],
    steps: [
      CommandStep((t) => t.commandOrderL14Step1, 'assets/command-order/library-go.svg'),
      CommandStep((t) => t.commandOrderL14Step2, 'assets/command-order/library-choose.svg'),
      CommandStep((t) => t.commandOrderL14Step3, 'assets/command-order/library-borrow.svg'),
      CommandStep((t) => t.commandOrderL14Step4, 'assets/command-order/library-home.svg'),
      CommandStep((t) => t.commandOrderL14Step5, 'assets/command-order/library-read.svg'),
      CommandStep((t) => t.commandOrderL14Step6, 'assets/command-order/library-return.svg'),
    ],
    hint: (t) => t.commandOrderL14Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL15Title,
    icon: 'assets/command-order/tent-light.svg',
    stages: [
      TaskStage((t) => t.commandOrderL15Stage1, 2),
      TaskStage((t) => t.commandOrderL15Stage2, 3),
      TaskStage((t) => t.commandOrderL15Stage3, 2),
    ],
    steps: [
      CommandStep((t) => t.commandOrderL15Step1, 'assets/command-order/tent-spot.svg'),
      CommandStep((t) => t.commandOrderL15Step2, 'assets/command-order/tent-lay.svg'),
      CommandStep((t) => t.commandOrderL15Step3, 'assets/command-order/tent-poles.svg'),
      CommandStep((t) => t.commandOrderL15Step4, 'assets/command-order/tent-raise.svg'),
      CommandStep((t) => t.commandOrderL15Step5, 'assets/command-order/tent-stake.svg'),
      CommandStep((t) => t.commandOrderL15Step6, 'assets/command-order/tent-sleep.svg'),
      CommandStep((t) => t.commandOrderL15Step7, 'assets/command-order/tent-light.svg'),
    ],
    hint: (t) => t.commandOrderL15Hint,
  ),
  // Uzman 16–20: birden çok aşama, göreve ait olmayan kartlar
  CommandOrderLevel(
    title: (t) => t.commandOrderL16Title,
    icon: 'assets/command-order/pizza-slice.svg',
    stages: [
      TaskStage((t) => t.commandOrderL16Stage1, 1),
      TaskStage((t) => t.commandOrderL16Stage2, 2),
      TaskStage((t) => t.commandOrderL16Stage3, 3),
    ],
    steps: [
      CommandStep((t) => t.commandOrderL16Step1, 'assets/command-order/pizza-roll.svg'),
      CommandStep((t) => t.commandOrderL16Step2, 'assets/command-order/pizza-sauce.svg'),
      CommandStep((t) => t.commandOrderL16Step3, 'assets/command-order/pizza-cheese.svg'),
      CommandStep((t) => t.commandOrderL16Step4, 'assets/command-order/pizza-oven.svg'),
      CommandStep((t) => t.commandOrderL16Step5, 'assets/command-order/pizza-bake.svg'),
      CommandStep((t) => t.commandOrderL16Step6, 'assets/command-order/pizza-slice.svg'),
    ],
    extras: [CommandStep((t) => t.commandOrderL16Extra1, 'assets/command-order/tv-on.svg')],
    hint: (t) => t.commandOrderL16Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL17Title,
    icon: 'assets/command-order/laundry-hang.svg',
    stages: [
      TaskStage((t) => t.commandOrderL17Stage1, 3),
      TaskStage((t) => t.commandOrderL17Stage2, 1),
      TaskStage((t) => t.commandOrderL17Stage3, 2),
    ],
    steps: [
      CommandStep((t) => t.commandOrderL17Step1, 'assets/command-order/laundry-gather.svg'),
      CommandStep((t) => t.commandOrderL17Step2, 'assets/command-order/laundry-load.svg'),
      CommandStep((t) => t.commandOrderL17Step3, 'assets/command-order/laundry-soap.svg'),
      CommandStep((t) => t.commandOrderL17Step4, 'assets/command-order/laundry-run.svg'),
      CommandStep((t) => t.commandOrderL17Step5, 'assets/command-order/laundry-hang.svg'),
      CommandStep((t) => t.commandOrderL17Step6, 'assets/command-order/laundry-fold.svg'),
    ],
    extras: [CommandStep((t) => t.commandOrderL17Extra1, 'assets/command-order/ball-play.svg')],
    hint: (t) => t.commandOrderL17Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL18Title,
    icon: 'assets/command-order/train-board.svg',
    stages: [
      TaskStage((t) => t.commandOrderL18Stage1, 3),
      TaskStage((t) => t.commandOrderL18Stage2, 2),
      TaskStage((t) => t.commandOrderL18Stage3, 1),
    ],
    steps: [
      CommandStep((t) => t.commandOrderL18Step1, 'assets/command-order/train-ticket.svg'),
      CommandStep((t) => t.commandOrderL18Step2, 'assets/command-order/train-platform.svg'),
      CommandStep((t) => t.commandOrderL18Step3, 'assets/command-order/train-wait.svg'),
      CommandStep((t) => t.commandOrderL18Step4, 'assets/command-order/train-board.svg'),
      CommandStep((t) => t.commandOrderL18Step5, 'assets/command-order/train-seat.svg'),
      CommandStep((t) => t.commandOrderL18Step6, 'assets/command-order/train-off.svg'),
    ],
    extras: [CommandStep((t) => t.commandOrderL18Extra1, 'assets/command-order/plane-board.svg')],
    hint: (t) => t.commandOrderL18Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL19Title,
    icon: 'assets/command-order/sapling-plant.svg',
    stages: [
      TaskStage((t) => t.commandOrderL19Stage1, 2),
      TaskStage((t) => t.commandOrderL19Stage2, 2),
      TaskStage((t) => t.commandOrderL19Stage3, 2),
    ],
    steps: [
      CommandStep((t) => t.commandOrderL19Step1, 'assets/command-order/sapling-soil.svg'),
      CommandStep((t) => t.commandOrderL19Step2, 'assets/command-order/sapling-seed.svg'),
      CommandStep((t) => t.commandOrderL19Step3, 'assets/command-order/sapling-water.svg'),
      CommandStep((t) => t.commandOrderL19Step4, 'assets/command-order/sapling-sun.svg'),
      CommandStep((t) => t.commandOrderL19Step5, 'assets/command-order/sapling-sprout.svg'),
      CommandStep((t) => t.commandOrderL19Step6, 'assets/command-order/sapling-plant.svg'),
    ],
    extras: [
      CommandStep((t) => t.commandOrderL19Extra1, 'assets/command-order/umbrella-open.svg'),
      CommandStep((t) => t.commandOrderL19Extra2, 'assets/command-order/pot-dark.svg'),
    ],
    hint: (t) => t.commandOrderL19Hint,
  ),
  CommandOrderLevel(
    title: (t) => t.commandOrderL20Title,
    icon: 'assets/command-order/cookie-share.svg',
    stages: [
      TaskStage((t) => t.commandOrderL20Stage1, 3),
      TaskStage((t) => t.commandOrderL20Stage2, 2),
      TaskStage((t) => t.commandOrderL20Stage3, 2),
    ],
    steps: [
      CommandStep((t) => t.commandOrderL20Step1, 'assets/command-order/hands-rinse.webp'),
      CommandStep((t) => t.commandOrderL20Step2, 'assets/command-order/cake-mix.webp'),
      CommandStep((t) => t.commandOrderL20Step3, 'assets/command-order/cookie-shape.svg'),
      CommandStep((t) => t.commandOrderL20Step4, 'assets/command-order/cookie-bake.svg'),
      CommandStep((t) => t.commandOrderL20Step5, 'assets/command-order/cookie-cool.svg'),
      CommandStep((t) => t.commandOrderL20Step6, 'assets/command-order/cookie-box.svg'),
      CommandStep((t) => t.commandOrderL20Step7, 'assets/command-order/cookie-share.svg'),
    ],
    extras: [
      CommandStep((t) => t.commandOrderL20Extra1, 'assets/command-order/toy-car.svg'),
      CommandStep((t) => t.commandOrderL20Extra2, 'assets/command-order/sleep.svg'),
    ],
    hint: (t) => t.commandOrderL20Hint,
  ),
];
