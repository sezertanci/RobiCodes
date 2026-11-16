// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Robi Ngoding';

  @override
  String get languageName => 'Bahasa Indonesia';

  @override
  String get homeLogoTop => 'Robi';

  @override
  String get homeLogoBottom => 'Ngoding';

  @override
  String get homeTagline => 'Bermain • Belajar • Menjelajah';

  @override
  String get homeComingSoon => 'Segera hadir';

  @override
  String get homeLocked => 'Terkunci';

  @override
  String homeLevels(Object completed, Object levels) {
    return '$completed/$levels level';
  }

  @override
  String get homeChangeCharacter => 'Ganti';

  @override
  String homeCharacterLabel(Object name) {
    return 'Karaktermu: $name. Ketuk untuk mengganti.';
  }

  @override
  String get commonClose => 'Tutup';

  @override
  String get commonNextLevel => 'Level berikutnya';

  @override
  String get commonBackToHome => 'Kembali ke beranda';

  @override
  String get commonBackToLevels => 'Kembali ke daftar level';

  @override
  String commonStars(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bintang',
      one: '1 bintang',
    );
    return '$_temp0';
  }

  @override
  String get commonRun => 'Mulai';

  @override
  String get commonHint => 'Petunjuk';

  @override
  String get commonClear => 'Bersihkan';

  @override
  String get commonDelete => 'Hapus';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get settingsSound => 'Suara';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String difficulty(String difficulty) {
    String _temp0 = intl.Intl.selectLogic(difficulty, {
      'easy': 'Mudah',
      'medium': 'Sedang',
      'hard': 'Sulit',
      'other': 'Ahli',
    });
    return '$_temp0';
  }

  @override
  String get basePackTitle => 'Level Dasar';

  @override
  String get playPreviousLevel => 'Level sebelumnya';

  @override
  String playLevelLabel(Object difficulty, Object level) {
    return '$difficulty, level $level';
  }

  @override
  String playFinishGroupFirst(Object difficulty) {
    return 'Selesaikan dulu level $difficulty';
  }

  @override
  String get playPreviewNote =>
      'Level pertama di setiap tingkat kesulitan bisa dicoba gratis. Level lainnya terbuka setelah dibeli.';

  @override
  String get playLevelComplete => 'Hebat! Level selesai.';

  @override
  String playLevel(Object level) {
    return 'Level $level';
  }

  @override
  String playLevelLocked(Object level) {
    return 'Level $level, terkunci';
  }

  @override
  String playLevelStars(Object level, Object stars) {
    return 'Level $level, $stars';
  }

  @override
  String get playLocked => 'terkunci';

  @override
  String get gamePathFinderTitle => 'Cari Jalan Robot';

  @override
  String get gamePathFinderDescription =>
      'Arahkan robot ke tujuan dengan perintah arah.';

  @override
  String get gamePathFinderTrophy => 'Jago Robot';

  @override
  String get gamePathFinderTrophyDescription =>
      'Sekarang robot tahu semua jalan!';

  @override
  String get gameCommandOrderTitle => 'Urutkan Langkahnya';

  @override
  String get gameCommandOrderDescription =>
      'Susun langkah-langkah dengan urutan yang benar.';

  @override
  String get gameCommandOrderTrophy => 'Jago Algoritma';

  @override
  String get gameCommandOrderTrophyDescription =>
      'Kamu paling jago mengurutkan langkah!';

  @override
  String get gameIfThenTitle => 'Jika Begini, Maka';

  @override
  String get gameIfThenDescription =>
      'Pilih perintah yang tepat untuk setiap keadaan.';

  @override
  String get gameIfThenTrophy => 'Jago Memutuskan';

  @override
  String get gameIfThenTrophyDescription => 'Kamu selalu memilih dengan tepat!';

  @override
  String get gameRepeatTitle => 'Ulangi Saja';

  @override
  String get gameRepeatDescription =>
      'Lakukan gerakan berulang dengan satu blok saja.';

  @override
  String get gameRepeatTrophy => 'Jago Perulangan';

  @override
  String get gameRepeatTrophyDescription =>
      'Kamu memakai perulangan seperti seorang ahli!';

  @override
  String get gameBugHunterTitle => 'Pemburu Kesalahan';

  @override
  String get gameBugHunterDescription =>
      'Temukan kode yang rusak lalu perbaiki.';

  @override
  String get gameBugHunterTrophy => 'Pemburu Kesalahan Ulung';

  @override
  String get gameBugHunterTrophyDescription =>
      'Kamu menemukan kesalahan yang paling sulit sekalipun!';

  @override
  String get gameMyCommandTitle => 'Buat Perintahmu';

  @override
  String get gameMyCommandDescription =>
      'Buat perintahmu sendiri dengan panah, lalu pakai berulang-ulang.';

  @override
  String get gameMyCommandTrophy => 'Arsitek Perintah';

  @override
  String get gameMyCommandTrophyDescription =>
      'Kamu menyelesaikan jalur tersulit dengan perintahmu sendiri!';

  @override
  String get gameVariableBoxTitle => 'Kotak Variabel';

  @override
  String get gameVariableBoxDescription =>
      'Taruh angka di kotak, lalu robot berjalan sejauh itu.';

  @override
  String get gameVariableBoxTrophy => 'Ahli Variabel';

  @override
  String get gameVariableBoxTrophyDescription =>
      'Kamu memperpendek jalan yang panjang dengan angka di kotak!';

  @override
  String get gamePatternPuzzleTitle => 'Teka-teki Pola';

  @override
  String get gamePatternPuzzleDescription =>
      'Temukan pola yang berulang dan lengkapi lampu yang hilang.';

  @override
  String get gamePatternPuzzleTrophy => 'Ahli Pola';

  @override
  String get gamePatternPuzzleTrophyDescription =>
      'Kamu sudah menyelesaikan semua pola dan menyalakan lampu dengan warna yang benar!';

  @override
  String get characterTitle => 'Pilih karaktermu';

  @override
  String characterName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'robi': 'Robi',
      'fiyo': 'Fiyo',
      'pervane': 'Baling',
      'isil': 'Kilau',
      'kahraman': 'Pahlawan',
      'pembe': 'Merah Muda',
      'sovalye': 'Kesatria',
      'piril': 'Kerlip',
      'other': 'Robi',
    });
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Prestasiku';

  @override
  String achievementsSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kamu mendapat $count hadiah!',
      one: 'Kamu mendapat 1 hadiah!',
    );
    return '$_temp0';
  }

  @override
  String get achievementsBadges => 'Lencana';

  @override
  String get achievementsBadgesSubtitle => 'Kemenangan kecil';

  @override
  String get achievementsBadgesEarned => 'Lencana yang kamu dapat';

  @override
  String get achievementsBadgesLocked => 'Lencana yang bisa kamu dapat';

  @override
  String get achievementsBadgesEmpty =>
      'Belum ada lencana. Selesaikan level pertamamu!';

  @override
  String get achievementsTrophies => 'Piala';

  @override
  String get achievementsTrophiesSubtitle => 'Tujuan besar';

  @override
  String get achievementsTrophiesEarned => 'Piala yang kamu dapat';

  @override
  String get achievementsTrophiesLocked => 'Piala yang masih terkunci';

  @override
  String get achievementsTrophiesEmpty =>
      'Belum ada piala. Terus semangat menuju tujuan besar!';

  @override
  String achievementsButtonLabel(Object earned, Object total) {
    return 'Prestasiku: $earned/$total';
  }

  @override
  String get achievementEarned => 'Didapat!';

  @override
  String get achievementCondition => 'Cara mendapatkannya: ';

  @override
  String achievementCardEarned(Object title) {
    return '$title, sudah didapat';
  }

  @override
  String achievementCardLocked(Object title) {
    return '$title, terkunci';
  }

  @override
  String get achievementNewBadge => 'Lencana baru!';

  @override
  String get achievementNewTrophy => 'Kamu memenangkan piala baru!';

  @override
  String get achievementGreat => 'Hebat!';

  @override
  String get achievementFirstGameTitle => 'Permainan Pertamaku';

  @override
  String get achievementFirstGameDescription =>
      'Kamu mengambil langkah pertama petualangan ngodingmu!';

  @override
  String get achievementFirstGameCondition =>
      'Selesaikan level permainan pertamamu.';

  @override
  String get achievementQuickStartTitle => 'Awal yang Cepat';

  @override
  String get achievementQuickStartDescription => 'Para robot bangga padamu!';

  @override
  String achievementQuickStartCondition(Object goal) {
    return 'Selesaikan $goal level dalam satu permainan.';
  }

  @override
  String get achievementDeterminedTitle => 'Pemain Pantang Menyerah';

  @override
  String get achievementDeterminedDescription =>
      'Kamu terus berusaha dan tidak pernah menyerah!';

  @override
  String achievementDeterminedCondition(Object goal) {
    return 'Selesaikan $goal level dalam satu permainan.';
  }

  @override
  String get achievementMasterCoderTitle => 'Jago Ngoding';

  @override
  String get achievementMasterCoderDescription =>
      'Kamu menyelesaikan semua level dalam satu permainan!';

  @override
  String get achievementMasterCoderCondition =>
      'Selesaikan semua level dalam satu permainan.';

  @override
  String get achievementAllGamesTitle => 'Penjelajah Permainan';

  @override
  String get achievementAllGamesDescription =>
      'Kamu sudah mencoba semua permainan!';

  @override
  String get achievementAllGamesCondition =>
      'Selesaikan paling sedikit satu level di setiap permainan.';

  @override
  String get achievementStarHunterTitle => 'Pemburu Bintang';

  @override
  String get achievementStarHunterDescription =>
      'Kamu mulai mengumpulkan bintang!';

  @override
  String achievementStarHunterCondition(Object goal) {
    return 'Kumpulkan total $goal bintang.';
  }

  @override
  String get achievementStarMasterTitle => 'Jago Bintang';

  @override
  String get achievementStarMasterDescription =>
      'Bintangmu sebanyak bintang di langit!';

  @override
  String achievementStarMasterCondition(Object goal) {
    return 'Kumpulkan total $goal bintang.';
  }

  @override
  String get achievementPerfectTitle => 'Pemain Sempurna';

  @override
  String get achievementPerfectDescription =>
      'Kamu menyelesaikan satu level dengan sempurna!';

  @override
  String achievementPerfectCondition(Object goal) {
    return 'Selesaikan satu level dengan $goal bintang.';
  }

  @override
  String get achievementNoHintTitle => 'Pahlawan Tanpa Petunjuk';

  @override
  String get achievementNoHintDescription => 'Kamu memecahkannya sendiri!';

  @override
  String achievementNoHintCondition(Object goal) {
    return 'Selesaikan $goal level tanpa memakai petunjuk.';
  }

  @override
  String get achievementBigSuccessTitle => 'Sukses Besar';

  @override
  String get achievementBigSuccessDescription =>
      'Kamu menyelesaikan semua permainan dari awal sampai akhir!';

  @override
  String get achievementBigSuccessCondition =>
      'Selesaikan semua level di setiap permainan.';

  @override
  String get achievementFirstAdventureTitle => 'Piala Petualangan Pertama';

  @override
  String get achievementFirstAdventureDescription =>
      'Kamu mengambil langkah pertama di setiap permainan!';

  @override
  String get achievementFirstAdventureCondition =>
      'Selesaikan level pertama di setiap permainan.';

  @override
  String get achievementChampionTitle => 'Juara Ngoding';

  @override
  String get achievementChampionDescription =>
      'Kamu benar-benar juara ngoding!';

  @override
  String get achievementChampionCondition =>
      'Tamatkan semua level di setiap permainan.';

  @override
  String achievementGameTrophyCondition(Object game) {
    return 'Tamatkan $game.';
  }

  @override
  String get parentalGateTitle => 'Persetujuan orang tua';

  @override
  String parentalGateIntro(Object action) {
    return 'Tindakan ini perlu persetujuan orang dewasa: $action.';
  }

  @override
  String parentalGateAction(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'purchase': 'Membeli paket',
      'other': 'Tindakan',
    });
    return '$_temp0';
  }

  @override
  String get parentalGateAnswerHint => 'Tulis jawabannya dengan angka.';

  @override
  String get parentalGateCancel => 'Batal';

  @override
  String get parentalGateConfirm => 'Konfirmasi';

  @override
  String get parentalGateAnswer => 'Jawaban';

  @override
  String get parentalGateWrongAnswer =>
      'Jawaban salah. Tunggu sebentar, lalu jawab pertanyaan yang baru.';

  @override
  String parentalGateQuestion(String first, String second) {
    return 'Berapa $first kali $second?';
  }

  @override
  String get storeTitle => 'Paket';

  @override
  String get storeIntro =>
      'Pembelian dilakukan melalui Google Play, dan persetujuan orang tua diminta sebelum setiap pembelian. Kamu bisa menukarkan kode promo Google Play lewat link “Tukarkan kode” di layar pembayaran atau di aplikasi Play Store; paket yang ditukarkan dengan kode juga akan muncul di sini sebagai milikmu.';

  @override
  String get storePaidSection => 'Paket untuk dibeli';

  @override
  String get storeFreeSection => 'Paket gratis';

  @override
  String get storeNoProducts => 'Saat ini tidak ada paket untuk dibeli.';

  @override
  String get storeBundle => 'Bundel';

  @override
  String get storeStarterBundleTitle => 'Paket Pemula';

  @override
  String get storeOwned => 'Dimiliki';

  @override
  String get storeUnlocks => 'Terbuka setelah dibeli:';

  @override
  String get storePriceLoading => 'Mengambil harga dari Google Play…';

  @override
  String get storePriceUnavailable =>
      'Tidak bisa mengambil harga dari Google Play.';

  @override
  String get storeNotInStore => 'Paket ini sedang tidak ada di Google Play.';

  @override
  String get storeRetry => 'Coba lagi';

  @override
  String storePartiallyOwned(Object missing) {
    return 'Kamu sudah memiliki sebagian isi paket ini. Google Play tidak menurunkan harga untuk isi yang sudah kamu miliki, jadi paket ini tidak dijual agar kamu tidak membayar dua kali untuk isi yang sama. Paket yang belum dimiliki: $missing';
  }

  @override
  String get storeRestore => 'Pulihkan pembelian';

  @override
  String get storeRestoreHint =>
      'Membaca ulang pembelian di akun Google Play-mu; kemajuan permainan tidak dihapus.';

  @override
  String storeRestored(Object count) {
    return 'Pembelian sudah dibaca ulang dari Google Play. Produk yang dimiliki: $count.';
  }

  @override
  String get storeRestoreOffline =>
      'Tidak ada koneksi internet; catatan pembelian di perangkat ini tetap berlaku.';

  @override
  String get storeRestoreUnavailable =>
      'Tidak bisa terhubung ke Google Play; catatan pembelian di perangkat ini tetap berlaku.';

  @override
  String storeBuy(Object price) {
    return 'Beli – $price';
  }

  @override
  String storeLevels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count level',
      one: '1 level',
    );
    return '$_temp0';
  }

  @override
  String storePackLine(Object game, Object pack, Object levels) {
    return '$game – $pack ($levels)';
  }

  @override
  String get storePurchased => 'Pembelian selesai; paket sudah terbuka.';

  @override
  String get storePending =>
      'Pembayaran sedang diproses. Paket akan terbuka sendiri saat pembayaran selesai.';

  @override
  String get storeCancelled => 'Pembelian dibatalkan.';

  @override
  String get storeAlreadyOwned =>
      'Kamu sudah memiliki paket ini; paket tidak dibeli lagi.';

  @override
  String get storeBundlePartiallyOwned =>
      'Kamu sudah memiliki sebagian konten dalam paket ini, jadi pembelian tidak dimulai agar kamu tidak membayar dua kali untuk konten yang sama.';

  @override
  String get storeOffline =>
      'Tidak ada koneksi internet. Periksa koneksi lalu coba lagi.';

  @override
  String get storeUnavailable =>
      'Tidak bisa terhubung ke Google Play. Coba lagi nanti, ya.';

  @override
  String get storeFailed => 'Pembelian tidak dapat diselesaikan.';

  @override
  String get storeNotApproved =>
      'Orang tua tidak memberi persetujuan; pembelian tidak dimulai.';

  @override
  String get gameRobotRunning => 'Robot sedang berjalan...';

  @override
  String get gameRobotReachedFlag => 'Hebat! Robot sampai di bendera!';

  @override
  String get gameMissingCoins =>
      'Kamu sampai di bendera, tapi belum mengambil semua koin. Kumpulkan koinnya dulu.';

  @override
  String gameDirection(String direction) {
    String _temp0 = intl.Intl.selectLogic(direction, {
      'up': 'Atas',
      'down': 'Bawah',
      'left': 'Kiri',
      'other': 'Kanan',
    });
    return '$_temp0';
  }

  @override
  String gameObstacle(String obstacle) {
    String _temp0 = intl.Intl.selectLogic(obstacle, {
      'rock': 'batu',
      'water': 'air',
      'other': 'tepi peta',
    });
    return '$_temp0';
  }

  @override
  String get pathFinderIntro =>
      'Pilih perintah secara berurutan untuk membawa robot ke bendera.';

  @override
  String get pathFinderCoinIntro =>
      'Kumpulkan semua koin dulu, lalu pergi ke bendera.';

  @override
  String get pathFinderEmpty => 'Tambahkan perintah arah dulu.';

  @override
  String get pathFinderFull =>
      'Kamu sudah mencapai batas perintah. Kamu bisa menghapus satu perintah dan menaruh perintah lain di tempatnya.';

  @override
  String get pathFinderMissedGoal =>
      'Robot belum sampai di bendera. Coba tambah atau ubah perintahnya.';

  @override
  String get pathFinderTooMany =>
      'Dengan perintah ini kamu tidak bisa selesai dalam batasnya. Coba hapus langkah yang tidak perlu.';

  @override
  String get pathFinderSolved =>
      'Perintahmu sudah benar! Ketuk tombol hijau Mulai.';

  @override
  String get pathFinderEmptyStrip =>
      'Tekan tombol panah, nanti perintahmu berbaris di sini.';

  @override
  String get pathFinderMoveLeft =>
      'Geser perintah yang dipilih satu langkah ke kiri';

  @override
  String get pathFinderMoveRight =>
      'Geser perintah yang dipilih satu langkah ke kanan';

  @override
  String pathFinderBlocked(Object obstacle, Object number) {
    return 'Robot terhalang $obstacle. Coba ubah perintah $number.';
  }

  @override
  String pathFinderFixCommand(Object number) {
    return 'Perintah $number membuat robot keluar dari jalur. Aku sudah memilihnya untukmu; kamu bisa menghapus atau menggesernya.';
  }

  @override
  String pathFinderNextMove(Object direction) {
    return 'Lihat kotak yang bersinar. Perintah berikutnya: $direction.';
  }

  @override
  String pathFinderAddCommand(Object direction) {
    return 'Tambahkan perintah $direction';
  }

  @override
  String pathFinderCommandChip(Object number, Object direction) {
    return 'Perintah $number: $direction';
  }

  @override
  String get commandOrderIntro =>
      'Susun kartu dengan urutan yang benar untuk menyelesaikan tugas. Ketuk kartu atau seret ke dalam kotak.';

  @override
  String get commandOrderExtrasIntro =>
      'Hati-hati! Ada kartu yang bukan bagian dari tugas ini. Urutkan hanya kartu yang kamu perlukan.';

  @override
  String get commandOrderFull =>
      'Semua kotak sudah penuh. Ketuk kartu untuk mengambilnya kembali.';

  @override
  String get commandOrderNotFull => 'Isi semua kotak dulu.';

  @override
  String get commandOrderSuccess =>
      'Hebat! Semua langkah sudah berurutan dengan benar.';

  @override
  String get commandOrderSolved =>
      'Urutannya sudah benar! Ketuk tombol hijau Periksa.';

  @override
  String get commandOrderPoolEmpty => 'Semua kartu sudah ditaruh';

  @override
  String get commandOrderCheck => 'Periksa';

  @override
  String commandOrderWrongExtra(Object card) {
    return '“$card” tidak diperlukan untuk tugas ini. Keluarkan dari kotak.';
  }

  @override
  String commandOrderWrongTooEarly(Object number, Object card) {
    return '“$card” terlalu cepat untuk kotak $number. Ada langkah lain yang harus dilakukan sebelumnya.';
  }

  @override
  String commandOrderHint(Object levelHint, Object card, Object number) {
    return '$levelHint Kartu yang bersinar, “$card”, harus masuk ke kotak $number.';
  }

  @override
  String commandOrderSlotCard(Object number, Object card) {
    return 'Kotak $number: $card. Ketuk untuk mengambilnya kembali.';
  }

  @override
  String commandOrderEmptySlot(Object number) {
    return 'Kotak $number, kosong. Ketuk untuk menaruh kartu di sini.';
  }

  @override
  String get ifThenIncomplete => 'Isi kotak yang kosong dulu.';

  @override
  String get ifThenSuccess =>
      'Hebat! Robot mengikuti aturannya dan sampai di bendera!';

  @override
  String get ifThenSolved => 'Aturanmu sudah benar! Ketuk tombol hijau Mulai.';

  @override
  String get ifThenNoSlot =>
      'Tidak ada kotak kosong untuk blok ini. Ketuk kotak yang ingin kamu ganti untuk mengosongkannya.';

  @override
  String get ifThenLockedSlot =>
      'Kotak ini sudah terisi dari awal dan tidak bisa diubah. Taruh blok di kotak yang kosong.';

  @override
  String get ifThenWrongType =>
      'Blok ini tidak cocok di sana. Benda masuk ke kotak “Jika”, gerakan ditaruh di sebelah panah.';

  @override
  String get ifThenLane => 'Jalur robot';

  @override
  String get ifThenObjects => 'Benda';

  @override
  String get ifThenActions => 'Gerakan';

  @override
  String get ifThenIf => 'Jika';

  @override
  String get ifThenElseIf => 'Atau jika';

  @override
  String get ifThenElse => 'Jika tidak';

  @override
  String get ifThenThen => 'ada di depan';

  @override
  String ifThenObjectLabel(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Jalan kosong',
      'rock': 'Batu',
      'water': 'Air',
      'door': 'Pintu',
      'other': 'Bintang',
    });
    return '$_temp0';
  }

  @override
  String ifThenActionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'forward': 'Maju',
      'jump': 'Lompat',
      'bridge': 'Bangun Jembatan',
      'open': 'Buka Pintu',
      'other': 'Ambil',
    });
    return '$_temp0';
  }

  @override
  String ifThenObjectName(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'jalan kosong',
      'rock': 'batu',
      'water': 'air',
      'door': 'pintu',
      'other': 'bintang',
    });
    return '$_temp0';
  }

  @override
  String ifThenProblem(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Di jalan kosong, itu tidak perlu.',
      'rock': 'Kamu tidak bisa menembus batu.',
      'water': 'Robot tidak bisa berenang!',
      'door': 'Kamu tidak bisa lewat selama pintunya tertutup.',
      'other': 'Bintangnya tertinggal di tanah.',
    });
    return '$_temp0';
  }

  @override
  String ifThenAdvice(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Kalau jalannya kosong, robot bisa maju.',
      'rock': 'Untuk melewati batu, kamu harus melompat.',
      'water': 'Untuk menyeberangi air, kamu perlu membangun jembatan.',
      'door': 'Untuk melewati pintu, kamu harus membukanya dulu.',
      'other': 'Pakai blok Ambil untuk mengambil bintangnya.',
    });
    return '$_temp0';
  }

  @override
  String ifThenRuleNumber(Object number) {
    return 'Aturan $number';
  }

  @override
  String get ifThenElseRule => 'Baris “Jika tidak”';

  @override
  String ifThenWrong(
    Object object,
    Object rule,
    Object action,
    Object problem,
  ) {
    return 'Di depan ada $object. $rule dijalankan dan robot melakukan “$action”. $problem Ubah aturannya lalu coba lagi.';
  }

  @override
  String ifThenHint(Object object, Object advice) {
    return 'Di kotak yang bersinar ada $object. $advice';
  }

  @override
  String ifThenSlot(String kind, Object value) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'condition': 'syarat',
      'other': 'gerakan',
    });
    return 'Kotak $_temp0: $value';
  }

  @override
  String get ifThenSlotEmpty => 'kosong';

  @override
  String ifThenSlotReady(Object label) {
    return '$label, sudah terisi';
  }

  @override
  String ifThenPaletteBlock(String kind, Object label) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'action': 'Gerakan',
      'other': 'Benda',
    });
    return '$_temp0: $label';
  }

  @override
  String get repeatIntro =>
      'Bawa robot ke bendera. Pakai blok Ulangi daripada menambahkan gerakan yang sama berkali-kali.';

  @override
  String get repeatCoinIntro =>
      'Kumpulkan semua koin dulu, lalu pergi ke bendera. Blok Ulangi membuatnya lebih mudah.';

  @override
  String get repeatEmpty => 'Tambahkan panah atau blok Ulangi dulu.';

  @override
  String get repeatFull =>
      'Kamu sudah mencapai batas blok. Kalau sudah siap, ketuk tombol hijau Mulai; untuk mengubah sesuatu, pilih blok lalu hapus.';

  @override
  String get repeatInsideRepeat =>
      'Panah yang kamu tambahkan sekarang akan masuk ke dalam blok oranye. Kalau sudah selesai, ketuk tombol biru tua Keluar blok.';

  @override
  String get repeatEmptyStrip =>
      'Tambahkan panah atau blok Ulangi, nanti blok-blokmu berbaris di sini.';

  @override
  String get repeatOutsideRepeat =>
      'Panah yang kamu tambahkan sekarang akan berada di luar blok, di bagian akhir.';

  @override
  String get repeatMovedOut =>
      'Panah sudah dikeluarkan dari blok. Panah yang kamu tambahkan sekarang juga akan berada di luar, di bagian akhir.';

  @override
  String get repeatEmptyRepeat =>
      'Blok oranye masih kosong. Aku sudah memilihnya; sekarang tambahkan panah di dalamnya.';

  @override
  String get repeatMissedGoal =>
      'Robot belum sampai di bendera. Coba ubah jumlah ulangan atau panahnya.';

  @override
  String get repeatSolved =>
      'Blok-blokmu sudah benar! Ketuk tombol hijau Mulai.';

  @override
  String get repeatFullHint =>
      'Kamu sudah mencapai batas blok. Coba ubah jumlah ulangan, atau hapus satu blok dan taruh blok Ulangi di tempatnya.';

  @override
  String get repeatAddRepeat => 'Ulangi';

  @override
  String get repeatLeaveRepeat => 'Keluar blok ✓';

  @override
  String get repeatAddRepeatLabel => 'Tambahkan blok Ulangi';

  @override
  String get repeatLeaveRepeatLabel =>
      'Keluar dari blok; panah berikutnya ada di luar';

  @override
  String get repeatDropHere => 'Tambahkan panah di sini';

  @override
  String get repeatEmptyBody => 'Kosong';

  @override
  String get repeatDecrease => 'Kurangi jumlah ulangan';

  @override
  String get repeatIncrease => 'Tambah jumlah ulangan';

  @override
  String get repeatDeleteLabel => 'Hapus blok yang dipilih';

  @override
  String get repeatMoveOutLabel =>
      'Keluarkan panah yang dipilih dari blok oranye';

  @override
  String repeatTimes(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: '$times kali',
      one: 'sekali',
    );
    return '$_temp0';
  }

  @override
  String repeatTimesFull(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'ulangi $times kali',
      one: 'ulangi sekali',
    );
    return '$_temp0';
  }

  @override
  String repeatAddMove(Object direction) {
    return 'Tambahkan panah $direction';
  }

  @override
  String repeatArrowName(Object number) {
    return 'Panah $number';
  }

  @override
  String repeatBlockName(Object number) {
    return 'Blok $number';
  }

  @override
  String repeatInnerArrowName(Object block, Object arrow) {
    return 'Panah $arrow di dalam blok $block';
  }

  @override
  String repeatMoveChip(Object name, Object direction) {
    return '$name: $direction';
  }

  @override
  String repeatBlockLabel(Object number, int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'ulangi $times kali',
      one: 'ulangi sekali',
    );
    return 'Blok $number: $_temp0. Ketuk untuk menambahkan panah di dalamnya.';
  }

  @override
  String repeatFixCount(Object number) {
    return 'Coba ubah jumlah ulangan blok $number atau panah di dalamnya.';
  }

  @override
  String repeatOffPath(Object place) {
    return '$place membuat robot keluar dari jalur.';
  }

  @override
  String repeatExtraBlock(Object place) {
    return '$place kelebihan. Coba hapus bagian itu.';
  }

  @override
  String repeatBlocked(Object obstacle, Object advice) {
    return 'Robot terhalang $obstacle. $advice';
  }

  @override
  String repeatBlockedInRound(Object round, Object obstacle, Object advice) {
    return 'Pada putaran ke-$round, robot terhalang $obstacle. $advice';
  }

  @override
  String repeatFixHint(Object advice) {
    return '$advice Aku sudah menandai bagian yang salah dengan warna merah untukmu.';
  }

  @override
  String repeatNextMoveHint(Object levelHint, Object direction) {
    return '$levelHint Lihat kotak yang bersinar; di sana robot harus ke arah $direction.';
  }

  @override
  String get repeatL1Intro =>
      'Robot harus ke kanan 3 kali, tapi kamu hanya boleh memakai 2 blok. Tambahkan blok Ulangi lalu taruh panah kanan di dalamnya.';

  @override
  String get repeatL1Hint =>
      'Blok Ulangi menjalankan panah di dalamnya sebanyak yang kamu tentukan. Berapa kali robot harus ke kanan?';

  @override
  String get repeatL2Intro =>
      'Benderanya ada di atas. Pakai blok Ulangi daripada menambahkan panah yang sama berkali-kali.';

  @override
  String get repeatL2Hint =>
      'Robot terus berjalan ke arah yang sama. Ke arah mana, dan berapa kali?';

  @override
  String get repeatL3Hint =>
      'Robot berjalan ke bawah. Hitung kotaknya lalu atur jumlah ulangannya.';

  @override
  String get repeatL4Hint =>
      'Kali ini ke kiri. Kamu bisa mengubah jumlah ulangan dengan tombol − dan +.';

  @override
  String get repeatL5Intro =>
      'Kumpulkan juga koin di jalan! Tetap hanya ada 2 blok.';

  @override
  String get repeatL5Hint =>
      'Koinnya ada di antara robot dan bendera, di baris yang sama. Robot hanya berjalan ke kanan.';

  @override
  String get repeatL6Intro =>
      'Turun seperti tangga: kanan, bawah, kanan, bawah... Kamu bisa menaruh dua panah di dalam satu blok Ulangi.';

  @override
  String get repeatL6Hint =>
      'Satu anak tangga: sekali ke kanan, sekali ke bawah. Ada berapa anak tangga?';

  @override
  String get repeatL7Hint =>
      'Dua kali ke kanan, sekali ke atas. Berapa kali pola ini diulang?';

  @override
  String get repeatL8Hint =>
      'Pertama dua kali ke kanan, lalu sekali ke bawah. Ulangi itu.';

  @override
  String get repeatL9Intro =>
      'Kamu juga bisa menambahkan satu panah setelah blok Ulangi.';

  @override
  String get repeatL9Hint =>
      'Ulangi pola atas-kiri; mungkin kamu perlu satu langkah lagi di akhir.';

  @override
  String get repeatL10Hint =>
      'Setiap anak tangga lebarnya dua kotak dan tingginya satu kotak.';

  @override
  String get repeatL11Intro =>
      'Kali ini kamu perlu dua blok Ulangi: satu ke kanan, satu ke bawah.';

  @override
  String get repeatL11Hint =>
      'Berapa kotak ke kanan dulu? Lalu berapa kotak ke bawah? Pakai blok Ulangi sendiri-sendiri untuk masing-masing.';

  @override
  String get repeatL12Hint =>
      'Naik ke atas dulu, lalu ke kanan. Dua blok Ulangi, dua angka yang berbeda.';

  @override
  String get repeatL13Hint =>
      'Kelilingi batu-batunya: kanan, bawah, kiri. Hitung kotak untuk setiap arah.';

  @override
  String get repeatL14Hint =>
      'Jalannya punya tiga bagian: kanan, bawah, lalu kanan lagi.';

  @override
  String get repeatL15Hint =>
      'Kedua koin ada di sudut jalan. Lewati setiap bagian lurus dengan blok Ulangi.';

  @override
  String get repeatL16Intro =>
      'Hanya 4 blok! Lewati jalan yang panjang dengan pola yang pendek.';

  @override
  String get repeatL16Hint =>
      'Koin-koinnya berbaris miring: perhatikan pola kanan-bawah.';

  @override
  String get repeatL17Hint =>
      'Setiap anak tangga tingginya dua kotak dan lebarnya dua kotak.';

  @override
  String get repeatL18Hint =>
      'Dua kali ke kanan, dua kali ke bawah. Pola ini berlanjut sampai ke bendera.';

  @override
  String get repeatL19Hint =>
      'Koin-koinnya ada di sudut anak tangga. Satu anak tangga: dua kali ke kanan, sekali ke bawah.';

  @override
  String get repeatL20Intro =>
      'Jalan panjang yang berkelok seperti ular. Pakai 10 blok dengan cermat.';

  @override
  String get repeatL20Hint =>
      'Jalannya terdiri dari lima bagian lurus. Lewati setiap bagian dengan blok Ulangi.';

  @override
  String get bugHunterIntro =>
      'Ada kesalahan di kode ini! Ketuk Mulai dulu dan lihat di mana robot jadi bingung.';

  @override
  String get bugHunterSelected =>
      'Kalau kamu memilih panah, tombol arah akan mengubahnya. Kamu bisa menghapus blok yang dipilih atau menambahkan panah baru sebelumnya.';

  @override
  String get bugHunterPickInsert =>
      'Panah mana yang harus ada sebelumnya? Ketuk tombol arah.';

  @override
  String get bugHunterInsertLabel =>
      'Tambahkan panah sebelum blok yang dipilih';

  @override
  String get bugHunterReset => 'Ulang dari awal';

  @override
  String get bugHunterL1Intro =>
      'Robot tidak bisa sampai di bendera, ada kesalahan di kodenya! Ketuk Mulai dan lihat robotnya. Lalu ketuk panah yang salah dan tekan tombol arah yang benar.';

  @override
  String get bugHunterL1Hint =>
      'Benderanya ada lurus di kanan. Semua panah harus ke kanan.';

  @override
  String get bugHunterL2Hint =>
      'Robot berjalan memutar di bawah batu. Panah terakhir harus membawanya naik ke bendera.';

  @override
  String get bugHunterL3Intro =>
      'Ada satu panah yang hilang di kode ini. Di mana robot berhenti? Tambahkan panah yang hilang.';

  @override
  String get bugHunterL3Hint =>
      'Robot berhenti sebelum sampai di bendera. Robot perlu satu langkah lagi.';

  @override
  String get bugHunterL4Intro =>
      'Ada satu panah yang berlebih di kode ini. Pilih panah itu lalu hapus.';

  @override
  String get bugHunterL4Hint =>
      'Robot melangkah sekali lagi setelah sampai di bendera.';

  @override
  String get bugHunterL5Intro =>
      'Ada satu panah yang hilang, tapi bukan di akhir. Pilih sebuah panah, ketuk tombol Tambah sebelumnya, lalu ketuk tombol arah.';

  @override
  String get bugHunterL5Hint =>
      'Saat lewat di bawah batu, robot harus dua kali ke kanan.';

  @override
  String get bugHunterL6Hint =>
      'Setelah mengambil koin, benderanya ada di bawah.';

  @override
  String get bugHunterL7Hint =>
      'Untuk melewati air, pergilah tiga kali ke kanan di baris paling bawah.';

  @override
  String get bugHunterL8Intro =>
      'Ada dua kesalahan di kode ini! Setiap kali robot tersangkut, perbaiki satu kesalahan.';

  @override
  String get bugHunterL8Hint =>
      'Lewat di atas batu-batunya: pertama ke kanan, lalu ke bawah.';

  @override
  String get bugHunterL9Hint =>
      'Setelah mengambil kedua koin, robot harus berhenti di bendera.';

  @override
  String get bugHunterL10Hint =>
      'Ikuti jalan yang berkelok di antara batu-batu. Satu panah salah dan satu panah hilang.';

  @override
  String get bugHunterL11Intro =>
      'Kali ini kesalahannya ada di dalam blok Ulangi yang oranye. Pilih panah di dalamnya lalu ubah.';

  @override
  String get bugHunterL11Hint =>
      'Panah di dalam blok Ulangi harus mengarah ke bendera.';

  @override
  String get bugHunterL12Intro =>
      'Panah-panah di kode ini sudah benar, tapi jumlah ulangannya salah. Ubah angkanya.';

  @override
  String get bugHunterL12Hint =>
      'Ada berapa anak tangga? Jumlah ulangan harus sama dengan jumlah anak tangga.';

  @override
  String get bugHunterL13Hint =>
      'Setiap anak tangga: dua kali ke kanan, sekali ke atas.';

  @override
  String get bugHunterL14Hint =>
      'Setiap anak tangga: dua kali ke kanan, sekali ke bawah. Ada satu panah yang hilang di dalam blok.';

  @override
  String get bugHunterL15Hint =>
      'Setelah blok Ulangi, hanya tinggal satu langkah lagi.';

  @override
  String get bugHunterL16Intro =>
      'Pemburu ahli! Kode-kode ini punya lebih dari satu kesalahan. Temukan satu setiap kali kamu menjalankannya.';

  @override
  String get bugHunterL16Hint =>
      'Berapa kotak ke kanan dulu? Lalu berapa kotak ke bawah?';

  @override
  String get bugHunterL17Hint =>
      'Setiap ulangan berjalan dua kotak ke kanan. Berapa ulangan yang diperlukan sampai ke bendera?';

  @override
  String get bugHunterL18Hint =>
      'Batu-batunya ada di atas anak tangga. Di setiap anak tangga, pergi ke bawah dulu, lalu ke kanan.';

  @override
  String get bugHunterL19Hint =>
      'Ada tangga di antara air: sekali ke kanan, sekali ke bawah. Ada berapa anak tangga?';

  @override
  String get bugHunterL20Hint =>
      'Pertama ke kanan, lalu ke bawah. Hitung kotak di setiap bagian lurus.';

  @override
  String get myCommandIntro =>
      'Di jalur turkuaz di atas, buat perintahmu dengan panah. Lalu di program utama di bawah, pakai blok Perintah; setiap blok Perintah menjalankan semua panah di dalam perintah.';

  @override
  String get myCommandCommandEmpty =>
      'Buat perintahmu: tambahkan panah di sini.';

  @override
  String get myCommandMainEmpty =>
      'Program utama: tambahkan blok Perintah dan panah.';

  @override
  String get myCommandButton => 'Perintah';

  @override
  String get myCommandButtonLabel => 'Tambahkan blok Perintah ke program utama';

  @override
  String myCommandCallLabel(Object number) {
    return 'Blok $number: perintah';
  }

  @override
  String get myCommandEmptyCommand =>
      'Perintahmu masih kosong. Ketuk jalur turkuaz di atas dan tambahkan panah.';

  @override
  String get myCommandEmptyMain =>
      'Program utama masih kosong. Tambahkan blok Perintah dengan tombol turkuaz Perintah.';

  @override
  String get myCommandEditCommand =>
      'Panah yang kamu tambahkan sekarang akan masuk ke dalam perintah.';

  @override
  String get myCommandEditMain =>
      'Blok yang kamu tambahkan sekarang akan masuk ke program utama.';

  @override
  String get myCommandCallAdded =>
      'Blok Perintah sudah ditambahkan ke program utama. Di sini robot akan menjalankan semua panah di dalam perintah.';

  @override
  String get myCommandUseHint =>
      'Perintahmu sudah siap. Ketuk tombol turkuaz Perintah untuk memakainya di program utama.';

  @override
  String get myCommandFullHint =>
      'Kamu sudah mencapai batas blok. Ubah perintahmu, atau ganti beberapa panah di program utama dengan blok Perintah.';

  @override
  String get myCommandMissedGoal =>
      'Robot belum sampai di bendera. Coba ubah panah di dalam perintah atau jumlah blok Perintah.';

  @override
  String myCommandOffPath(Object place) {
    return '$place di dalam perintah membuat robot keluar dari jalur.';
  }

  @override
  String myCommandFixCount(Object number) {
    return 'Coba ubah jumlah ulangan blok $number di dalam perintah atau panah di dalamnya.';
  }

  @override
  String get myCommandLaterCall =>
      'Kali ini perintah membuat robot keluar dari jalur; ubah perintahnya atau panah di program utama.';

  @override
  String get myCommandL1Intro =>
      'Buat perintahmu sendiri! Taruh dua panah kanan di jalur turkuaz di atas. Lalu tambahkan perintahmu ke program utama dengan tombol Perintah.';

  @override
  String get myCommandL1Hint =>
      'Robot harus ke kanan 6 kali. Kalau perintahmu berisi 2 panah kanan, berapa kali kamu harus memakainya?';

  @override
  String get myCommandL2Hint =>
      'Turunlah seperti tangga. Satu anak tangga: satu ke kanan, satu ke bawah. Jadikan itu perintahmu.';

  @override
  String get myCommandL3Intro =>
      'Di program utama, kamu juga bisa menambahkan panah di samping blok Perintah.';

  @override
  String get myCommandL3Hint =>
      'Ada tangga di antara batu-batu: kanan, bawah. Di akhir, masih butuh satu langkah lagi.';

  @override
  String get myCommandL4Hint =>
      'Dua ke kanan, satu ke atas. Pola ini berulang berapa kali?';

  @override
  String get myCommandL5Hint =>
      'Robot mendaki ke kiri: satu ke atas, satu ke kiri. Koin-koin juga ada di jalur ini.';

  @override
  String get myCommandL6Hint =>
      'Setiap anak tangga lebarnya dua petak dan tingginya satu petak.';

  @override
  String get myCommandL7Hint =>
      'Dua ke kanan, dua ke bawah. Koin-koin ada di pola ini.';

  @override
  String get myCommandL8Hint =>
      'Lewati bagian bawah batu-batu: pertama ke bawah, lalu dua ke kanan.';

  @override
  String get myCommandL9Hint =>
      'Buat perintah ini ke kanan empat kali. Di antara dua blok Perintah, robot harus turun.';

  @override
  String get myCommandL10Hint =>
      'Ambil koin di antara batu-batu: bawah, dua ke kanan, atas.';

  @override
  String get myCommandL11Intro =>
      'Kamu juga bisa menaruh blok Ulangi di dalam perintahmu! Jadi perintah yang pendek bisa menempuh jalur yang panjang.';

  @override
  String get myCommandL11Hint =>
      'Buat perintah ini ke kanan tiga kali. Di antara perintah, robot turun satu kali dan naik satu kali.';

  @override
  String get myCommandL12Hint =>
      'Setiap bagian dua ke kanan, satu ke bawah. Di satu tempat ada satu langkah ke bawah lagi.';

  @override
  String get myCommandL13Hint =>
      'Setiap anak tangga satu ke atas, dua ke kanan. Jangan lupa koinnya.';

  @override
  String get myCommandL14Hint =>
      'Setiap bagian dua ke kanan, satu ke atas. Lihat juga langkah-langkah di antara perintah.';

  @override
  String get myCommandL15Hint =>
      'Setiap bagian satu ke bawah, dua ke kanan. Di antara perintah, jalurnya kadang lurus.';

  @override
  String get myCommandL16Hint =>
      'Perintah: tiga ke kanan, satu ke bawah. Setelah perintah pertama, kamu harus berbelok satu kali ke kiri.';

  @override
  String get myCommandL17Hint =>
      'Setiap bagian satu ke atas, tiga ke kanan. Di antara perintah, naik sekali lagi.';

  @override
  String get myCommandL18Hint =>
      'Di dalam perintah bisa ada dua blok Ulangi: dua ke bawah, dua ke kanan.';

  @override
  String get myCommandL19Hint =>
      'Perintah: satu ke kanan, dua ke atas, satu ke kanan. Temukan panah di tengah dengan menghitung petak.';

  @override
  String get myCommandL20Hint =>
      'Di dalam perintah, pertama ada dua anak tangga: kanan, bawah. Lalu satu langkah lagi ke kanan.';

  @override
  String get variableBoxIntro =>
      'Taruh sebuah angka di kotak kuning. Setiap panah membuat robot berjalan sejauh angka di kotak. Kotak dimulai dari 1.';

  @override
  String get variableBoxEmpty => 'Tambahkan blok kotak atau panah dulu.';

  @override
  String get variableBoxEmptyStrip =>
      'Tambahkan blok kotak dan panah, nanti blok-blokmu berbaris di sini.';

  @override
  String get variableBoxMissedGoal =>
      'Robot belum sampai di bendera. Coba ubah angka di kotak atau panahnya.';

  @override
  String get variableBoxFullHint =>
      'Kamu sudah mencapai batas blok. Daripada menambahkan panah satu per satu, coba taruh angka yang lebih besar di kotak.';

  @override
  String variableBoxWalked(int box) {
    String _temp0 = intl.Intl.pluralLogic(
      box,
      locale: localeName,
      other:
          'Di kotak ada $box; setiap panah membuat robot berjalan $box petak.',
    );
    return '$_temp0';
  }

  @override
  String variableBoxInnerName(Object block, Object number) {
    return 'Blok kotak $number di dalam blok $block';
  }

  @override
  String variableBoxSetChip(Object name, Object value) {
    return '$name: taruh $value di kotak';
  }

  @override
  String variableBoxIncreaseChip(Object name) {
    return '$name: tambah 1 ke kotak';
  }

  @override
  String variableBoxDecreaseChip(Object name) {
    return '$name: kurangi 1 dari kotak';
  }

  @override
  String get variableBoxDecrease => 'Kurangi angka yang ditaruh di kotak';

  @override
  String get variableBoxIncrease => 'Tambah angka yang ditaruh di kotak';

  @override
  String get variableBoxSetLabel =>
      'Tambahkan blok yang menaruh angka di kotak';

  @override
  String get variableBoxIncreaseLabel =>
      'Tambahkan blok yang menambah 1 ke kotak';

  @override
  String get variableBoxDecreaseLabel =>
      'Tambahkan blok yang mengurangi 1 dari kotak';

  @override
  String variableBoxBadge(Object value) {
    return 'Sekarang di kotak ada $value.';
  }

  @override
  String variableBoxArrowSteps(String label, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$label. Membuat robot berjalan $count petak.',
    );
    return '$_temp0';
  }

  @override
  String get variableBoxL1Intro =>
      'Bendera ada 6 petak jauhnya, tapi kamu hanya boleh memakai 2 blok. Taruh 6 di kotak dulu, lalu ketuk panah kanan.';

  @override
  String get variableBoxL1Hint =>
      'Taruh 6 di kotak dengan blok kotak =; lalu satu panah kanan membuat robot berjalan 6 petak.';

  @override
  String get variableBoxL2Hint =>
      'Robot harus 3 petak ke kanan, 3 petak ke bawah. Taruh 3 di kotak; lalu setiap panah berjalan 3 petak.';

  @override
  String get variableBoxL3Hint =>
      'Ke kanan dan ke bawah masing-masing 4 petak. Taruh 4 di kotak, lalu dua panah sudah cukup.';

  @override
  String get variableBoxL4Hint =>
      'Pertama 5 petak ke kanan, lalu 2 petak ke bawah. Taruh 5 di kotak, panah kanan; lalu ubah kotak jadi 2, panah bawah.';

  @override
  String get variableBoxL5Intro =>
      'Blok baru: +1 menambah angka di kotak sebanyak satu.';

  @override
  String get variableBoxL5Hint =>
      '2 petak ke kanan, 3 petak ke bawah. Taruh 2 di kotak, panah kanan, lalu dengan +1 ubah kotak jadi 3 dan panah bawah.';

  @override
  String get variableBoxL6Hint =>
      'Jalannya selalu 3 petak: kanan, bawah, kanan, bawah. Taruh 3 di kotak sekali saja; setiap panah berikutnya berjalan 3 petak.';

  @override
  String get variableBoxL7Hint =>
      'Kotak dimulai dari 1. Setiap langkah jalannya bertambah satu petak: panah, +1, panah, +1, panah.';

  @override
  String get variableBoxL8Intro =>
      'Blok baru: −1 mengurangi angka di kotak sebanyak satu.';

  @override
  String get variableBoxL8Hint =>
      'Jalannya 4, 3, 2, 1 petak. Taruh 4 di kotak, lalu tambahkan −1 setelah setiap panah.';

  @override
  String get variableBoxL9Hint =>
      '5 petak ke bawah, 2 ke kanan, 5 ke atas. Sebelum setiap arah, taruh angka yang sesuai di kotak.';

  @override
  String get variableBoxL10Hint =>
      'Semua jalan panjangnya 3 petak. Taruh 3 di kotak sekali saja, lalu lima panah sudah cukup.';

  @override
  String get variableBoxL11Intro =>
      'Ulangi kembali! Angka di kotak juga berlaku di setiap putaran ulangan.';

  @override
  String get variableBoxL11Hint =>
      'Anak tangganya 2 petak. Taruh 2 di kotak, lalu ulangi panah kanan dan bawah 3 kali.';

  @override
  String get variableBoxL12Hint =>
      'Anak tangganya 3 petak: bawah dulu, lalu kanan. Taruh 3 di kotak dan ulangi polanya 2 kali.';

  @override
  String get variableBoxL13Hint =>
      'Taruh 2 di kotak; ulangi panah kanan dan atas 2 kali, dan di akhir tambahkan satu panah kanan lagi.';

  @override
  String get variableBoxL14Hint =>
      'Pertama berjalan 3 petak ke kanan. Lalu ubah kotak jadi 2 dan ulangi pola bawah-kanan 2 kali.';

  @override
  String get variableBoxL15Hint =>
      'Pertama taruh 2 di kotak dan ulangi pola kanan-bawah 2 kali. Jalan lurus terakhir 3 petak.';

  @override
  String get variableBoxL16Intro =>
      'Kamu bisa menaruh +1 di dalam ulangan; maka di setiap putaran jalannya bertambah satu petak.';

  @override
  String get variableBoxL16Hint =>
      'Anak tangganya membesar 1, 2, 3 petak. Ulangi panah kanan, panah bawah, dan blok +1 sebanyak 3 kali.';

  @override
  String get variableBoxL17Hint =>
      'Anak tangganya mengecil 3, 2, 1 petak. Taruh 3 di kotak; ulangi panah kanan, panah bawah, dan blok −1 sebanyak 3 kali.';

  @override
  String get variableBoxL18Hint =>
      'Setiap putaran ada panah kanan, +1, dan panah bawah; setelah 2 putaran, tambahkan satu panah kanan terakhir.';

  @override
  String get variableBoxL19Hint =>
      'Taruh 4 di kotak. Ulangi pola panah kanan, −1, dan panah bawah sebanyak 2 kali.';

  @override
  String get variableBoxL20Hint =>
      'Setiap panah satu petak lebih panjang dari sebelumnya. Ulangi pola panah kanan, +1, panah bawah, +1 sebanyak 2 kali.';

  @override
  String get patternColorRed => 'merah';

  @override
  String get patternColorBlue => 'biru';

  @override
  String get patternColorYellow => 'kuning';

  @override
  String get patternColorGreen => 'hijau';

  @override
  String get patternShapeCircle => 'lingkaran';

  @override
  String get patternShapeSquare => 'persegi';

  @override
  String get patternShapeTriangle => 'segitiga';

  @override
  String patternLampLabel(String color, String shape) {
    return 'Lampu $shape berwarna $color';
  }

  @override
  String get patternMissingSlot => 'Bagian yang hilang';

  @override
  String patternLightChip(String name, String color) {
    return '$name: nyalakan lampu berwarna $color';
  }

  @override
  String patternInnerName(Object block, Object number) {
    return 'Blok lampu $number di dalam blok $block';
  }

  @override
  String patternLightLabel(String color) {
    return 'Tambahkan blok yang menyalakan lampu berwarna $color';
  }

  @override
  String get patternEmptyStrip => 'Sentuh tombol warna untuk menambahkan blok';

  @override
  String get patternIntroEasy =>
      'Lampu-lampu menyala mengikuti sebuah pola. Pilih warna lampu yang bertanda tanya di bawah.';

  @override
  String get patternIntroMedium =>
      'Kali ini ada beberapa bagian yang hilang. Lihat warna dan bentuknya, lalu lengkapi satu per satu.';

  @override
  String get patternIntroHard =>
      'Pola-pola ini makin besar atau berjalan dengan angka. Pilih bagian yang benar dari pilihan di bawah.';

  @override
  String get patternIntroExpert =>
      'Kamu yang menyalakan lampunya! Tambahkan blok dengan tombol warna; kalau warnanya berulang, pakai blok Ulangi.';

  @override
  String get patternHintRepeat =>
      'Lihat bagian yang berulang. Pola itu mulai lagi dengan warna apa?';

  @override
  String get patternHintShape =>
      'Lihat warna dan bentuknya. Di bagian yang berulang, keduanya muncul dengan urutan yang sama.';

  @override
  String get patternHintGrowing =>
      'Pola ini makin besar setiap kali. Hitung lampu biru: setiap putaran bertambah satu.';

  @override
  String get patternHintNumbers =>
      'Lihat selisih antar angka. Setiap kali yang ditambahkan angka yang sama.';

  @override
  String get patternHintGrowingNumbers =>
      'Lihat selisih antar angka. Selisihnya bertambah satu setiap kali: 1, 2, 3…';

  @override
  String get patternHintProgram =>
      'Temukan kelompok lampu yang berulang. Masukkan warna-warna itu ke dalam blok Ulangi dan atur jumlah pengulangannya.';

  @override
  String get patternHintProgramTail =>
      'Setelah kelompok yang berulang selesai, tersisa satu lampu di akhir. Tambahkan di luar blok Ulangi.';

  @override
  String get patternHintProgramTwo =>
      'Di barisan ini ada dua pola yang berbeda. Pakai satu blok Ulangi untuk masing-masing.';

  @override
  String get patternWrongLamp =>
      'Bagian ini tidak cocok dengan pola. Lihat bagian yang berulang dan coba lagi.';

  @override
  String get patternRightLamp =>
      'Benar! Sekarang lengkapi tanda tanya berikutnya.';

  @override
  String get patternSolved => 'Hebat! Polanya sudah lengkap.';

  @override
  String get patternLampsDark =>
      'Beberapa lampu masih mati. Tambahkan lebih banyak blok warna atau tambah jumlah pengulangan.';

  @override
  String get patternTooManyLights =>
      'Blok lebih banyak daripada lampu. Hapus satu blok atau kurangi jumlah pengulangan.';

  @override
  String patternWrongColor(String color) {
    return 'Lampu ini menyala berwarna $color, tetapi tidak cocok dengan pola. Warna apa yang seharusnya di sini?';
  }

  @override
  String get patternProgramEmpty => 'Tambahkan blok dulu dengan tombol warna.';

  @override
  String patternProgramHintWrong(String color) {
    return 'Blok yang aku pilih menyalakan lampu dengan warna yang salah. Di situ lampunya harus berwarna $color.';
  }

  @override
  String get patternInsideRepeat =>
      'Warna yang kamu tambahkan sekarang akan masuk ke dalam blok oranye. Kalau sudah selesai, ketuk tombol biru tua Keluar blok.';

  @override
  String get patternOutsideRepeat =>
      'Warna yang kamu tambahkan sekarang akan berada di luar blok, di bagian akhir.';

  @override
  String get patternMovedOut =>
      'Warna sudah dikeluarkan dari blok. Warna yang kamu tambahkan sekarang juga akan berada di luar, di bagian akhir.';

  @override
  String get patternEmptyRepeat =>
      'Blok oranye masih kosong. Aku sudah memilihnya; sekarang tambahkan warna di dalamnya.';

  @override
  String get patternLeaveRepeatLabel =>
      'Keluar dari blok; warna berikutnya ada di luar';

  @override
  String get patternDropHere => 'Tambahkan warna di sini';

  @override
  String get ifThenL1Intro =>
      'Jika ada batu di depan, apa yang harus dilakukan robot? Taruh gerakan di kotak yang kosong.';

  @override
  String get ifThenL2Intro =>
      'Robot tidak bisa berenang. Jika ada air di depan, apa yang harus dilakukannya?';

  @override
  String get ifThenL3Intro =>
      'Ada pintu tertutup di jalan. Apa yang harus dilakukan robot saat sampai di pintu?';

  @override
  String get ifThenL4Intro =>
      'Jangan lewati bintang tanpa mengambilnya! Jika ada bintang di depan, apa yang harus dilakukan robot?';

  @override
  String get ifThenL5Intro =>
      'Kali ini kamu juga memilih syaratnya. Ada apa di jalan?';

  @override
  String get ifThenL6Intro =>
      'Jika ada batu, lakukan satu hal; jika tidak, lakukan hal lain. Isi kedua kotaknya.';

  @override
  String get ifThenL7Intro =>
      'Apa yang harus dilakukan jika ada air? Bagaimana jika tidak ada air?';

  @override
  String get ifThenL8Intro =>
      'Di jalan ini tidak ada kotak kosong! Jika bukan pintu, apa yang ada di depan?';

  @override
  String get ifThenL9Intro => 'Pilih syaratnya dan kedua gerakannya.';

  @override
  String get ifThenL10Intro =>
      'Ada batu dan air di jalan. Satu aturan dan satu “Jika tidak” sudah cukup.';

  @override
  String get ifThenL11Intro =>
      'Ada batu dan air juga. Buat aturan untuk masing-masing.';

  @override
  String get ifThenL12Intro =>
      'Buka pintu-pintunya dan kumpulkan bintang-bintangnya.';

  @override
  String get ifThenL13Intro =>
      'Ada tiga benda yang berbeda, tapi hanya ada dua baris aturan. Pakai “Jika tidak” untuk yang ketiga.';

  @override
  String get ifThenL14Intro =>
      'Air, pintu, dan jalan kosong. Mana yang akan kamu serahkan ke “Jika tidak”?';

  @override
  String get ifThenL15Intro =>
      'Hati-hati: salah satu bloknya sama sekali tidak ada di jalan ini.';

  @override
  String get ifThenL16Intro =>
      'Robot sedang menuju istana: ada batu, parit, dan pintu istana.';

  @override
  String get ifThenL17Intro =>
      'Jalan harta karun: kumpulkan bintang-bintangnya dan lewati rintangannya.';

  @override
  String get ifThenL18Intro =>
      'Di jalan ini tidak ada kotak kosong. Empat benda butuh empat keputusan.';

  @override
  String get ifThenL19Intro =>
      'Perjalanan yang panjang! Air, batu, pintu, dan jalan kosong.';

  @override
  String get ifThenL20Intro =>
      'Tugas terakhir: kumpulkan semua bintang dan sampai di bendera.';

  @override
  String get pathFinderL1Intro =>
      'Bawa robot ke bendera. Tekan panah kanan, lalu ketuk tombol hijau Mulai.';

  @override
  String get pathFinderL2Intro =>
      'Benderanya ada di atas robot. Panah mana yang harus kamu pilih?';

  @override
  String get pathFinderL3Intro => 'Benderanya ada di kiri, dua kotak jauhnya.';

  @override
  String get pathFinderL4Intro => 'Robot harus turun ke bawah. Berapa kali?';

  @override
  String get pathFinderL5Intro =>
      'Kali ini kamu akan memakai dua arah yang berbeda.';

  @override
  String get pathFinderL11Intro => 'Ada batu di jalan. Kelilingi batunya.';

  @override
  String get pathFinderL12Intro =>
      'Batu-batunya berbaris seperti tembok. Lewati dari bawahnya.';

  @override
  String get pathFinderL13Intro =>
      'Robot tidak bisa masuk ke air. Cari jalan yang kering.';

  @override
  String get pathFinderL15Intro =>
      'Ada lebih dari satu jalan. Bisakah kamu menemukan yang paling pendek?';

  @override
  String get commandOrderL1Title => 'Siram bunganya';

  @override
  String get commandOrderL1Step1 => 'Isi penyiram tanaman';

  @override
  String get commandOrderL1Step2 => 'Siram bunganya';

  @override
  String get commandOrderL1Hint =>
      'Untuk menyiram bunga, penyiramnya harus berisi air dulu.';

  @override
  String get commandOrderL2Title => 'Sikat gigimu';

  @override
  String get commandOrderL2Step1 => 'Taruh pasta gigi di sikat';

  @override
  String get commandOrderL2Step2 => 'Sikat gigimu';

  @override
  String get commandOrderL2Step3 => 'Kumur-kumur';

  @override
  String get commandOrderL2Hint =>
      'Sebelum mulai menyikat, harus ada pasta gigi di sikatnya.';

  @override
  String get commandOrderL3Title => 'Cuci tanganmu';

  @override
  String get commandOrderL3Step1 => 'Sabuni tanganmu';

  @override
  String get commandOrderL3Step2 => 'Bilas tanganmu';

  @override
  String get commandOrderL3Step3 => 'Keringkan tanganmu';

  @override
  String get commandOrderL3Hint =>
      'Kamu tidak bisa mengeringkan tangan sebelum busanya hilang.';

  @override
  String get commandOrderL4Title => 'Pakai sepatumu';

  @override
  String get commandOrderL4Step1 => 'Pakai kaus kakimu';

  @override
  String get commandOrderL4Step2 => 'Pakai sepatumu';

  @override
  String get commandOrderL4Step3 => 'Ikat tali sepatumu';

  @override
  String get commandOrderL4Hint =>
      'Apa yang harus ada di kakimu sebelum masuk ke sepatu?';

  @override
  String get commandOrderL5Title => 'Buat gambar';

  @override
  String get commandOrderL5Step1 => 'Ambil selembar kertas';

  @override
  String get commandOrderL5Step2 => 'Gambar gambarmu';

  @override
  String get commandOrderL5Step3 => 'Warnai gambarmu';

  @override
  String get commandOrderL5Hint =>
      'Untuk mewarnai, kamu perlu gambar yang sudah jadi.';

  @override
  String get commandOrderL6Title => 'Buat roti lapis';

  @override
  String get commandOrderL6Step1 => 'Taruh piring di meja';

  @override
  String get commandOrderL6Step2 => 'Taruh roti di piring';

  @override
  String get commandOrderL6Step3 => 'Taruh keju di atasnya';

  @override
  String get commandOrderL6Step4 => 'Tutup dengan roti';

  @override
  String get commandOrderL6Step5 => 'Selamat makan';

  @override
  String get commandOrderL6Hint =>
      'Kamu perlu tempat untuk menaruh roti. Apa yang harus ada di meja dulu?';

  @override
  String get commandOrderL7Title => 'Rapikan mainan';

  @override
  String get commandOrderL7Step1 => 'Ambil kotaknya';

  @override
  String get commandOrderL7Step2 => 'Masukkan mainan ke kotak';

  @override
  String get commandOrderL7Step3 => 'Tutup kotaknya';

  @override
  String get commandOrderL7Step4 => 'Taruh kotak di rak';

  @override
  String get commandOrderL7Hint =>
      'Apa yang kamu lakukan kalau kotak mainannya tidak ada di dekatmu?';

  @override
  String get commandOrderL8Title => 'Tanam biji';

  @override
  String get commandOrderL8Step1 => 'Gali lubang di tanah';

  @override
  String get commandOrderL8Step2 => 'Masukkan biji ke lubang';

  @override
  String get commandOrderL8Step3 => 'Tutup dengan tanah';

  @override
  String get commandOrderL8Step4 => 'Siram bijinya';

  @override
  String get commandOrderL8Step5 => 'Tunggu tunasnya tumbuh';

  @override
  String get commandOrderL8Hint =>
      'Kamu tidak bisa menanam biji tanpa lubang untuknya.';

  @override
  String get commandOrderL9Title => 'Bersiap ke sekolah';

  @override
  String get commandOrderL9Step1 => 'Bangun saat alarm berbunyi';

  @override
  String get commandOrderL9Step2 => 'Pakai baju sekolahmu';

  @override
  String get commandOrderL9Step3 => 'Pakai tas punggungmu';

  @override
  String get commandOrderL9Step4 => 'Naik bus sekolah';

  @override
  String get commandOrderL9Hint =>
      'Kamu tidak bisa berpakaian sebelum bangun. Apa yang terjadi pertama kali di pagi hari?';

  @override
  String get commandOrderL10Title => 'Kirim surat';

  @override
  String get commandOrderL10Step1 => 'Tulis suratnya';

  @override
  String get commandOrderL10Step2 => 'Masukkan surat ke amplop';

  @override
  String get commandOrderL10Step3 => 'Tutup amplopnya';

  @override
  String get commandOrderL10Step4 => 'Masukkan ke kotak pos';

  @override
  String get commandOrderL10Hint =>
      'Harus ada surat untuk dimasukkan ke amplop.';

  @override
  String get commandOrderL11Title => 'Buat kue';

  @override
  String get commandOrderL11Stage1 => 'Membuat adonan';

  @override
  String get commandOrderL11Stage2 => 'Memanggang kue';

  @override
  String get commandOrderL11Step1 => 'Taruh bahan-bahan di meja';

  @override
  String get commandOrderL11Step2 => 'Aduk semuanya di mangkuk';

  @override
  String get commandOrderL11Step3 => 'Tuang adonan ke loyang';

  @override
  String get commandOrderL11Step4 => 'Masukkan loyang ke oven';

  @override
  String get commandOrderL11Step5 => 'Tunggu sampai matang';

  @override
  String get commandOrderL11Step6 => 'Potong kuenya';

  @override
  String get commandOrderL11Hint =>
      'Kamu tidak bisa memasukkan apa pun ke oven sebelum adonannya siap.';

  @override
  String get commandOrderL12Title => 'Mandi berendam';

  @override
  String get commandOrderL12Stage1 => 'Bersiap mandi';

  @override
  String get commandOrderL12Stage2 => 'Membersihkan badan';

  @override
  String get commandOrderL12Stage3 => 'Mengeringkan badan';

  @override
  String get commandOrderL12Step1 => 'Isi bak mandi dengan air';

  @override
  String get commandOrderL12Step2 => 'Masuk ke bak mandi';

  @override
  String get commandOrderL12Step3 => 'Keramas';

  @override
  String get commandOrderL12Step4 => 'Bilas busanya';

  @override
  String get commandOrderL12Step5 => 'Keringkan badan dengan handuk';

  @override
  String get commandOrderL12Hint =>
      'Kalau kamu masuk ke bak yang kosong, kamu tidak bisa mandi.';

  @override
  String get commandOrderL13Title => 'Naik sepeda';

  @override
  String get commandOrderL13Stage1 => 'Bersiap';

  @override
  String get commandOrderL13Stage2 => 'Bersepeda';

  @override
  String get commandOrderL13Stage3 => 'Selesai';

  @override
  String get commandOrderL13Step1 => 'Pakai helmmu';

  @override
  String get commandOrderL13Step2 => 'Naik ke sepeda';

  @override
  String get commandOrderL13Step3 => 'Kayuh pedalnya';

  @override
  String get commandOrderL13Step4 => 'Pakai remnya';

  @override
  String get commandOrderL13Step5 => 'Turun dari sepeda';

  @override
  String get commandOrderL13Hint =>
      'Keselamatan nomor satu. Apa yang kamu pakai sebelum naik sepeda?';

  @override
  String get commandOrderL14Title => 'Pinjam buku di perpustakaan';

  @override
  String get commandOrderL14Stage1 => 'Di perpustakaan';

  @override
  String get commandOrderL14Stage2 => 'Di rumah';

  @override
  String get commandOrderL14Stage3 => 'Mengembalikan';

  @override
  String get commandOrderL14Step1 => 'Pergi ke perpustakaan';

  @override
  String get commandOrderL14Step2 => 'Pilih buku';

  @override
  String get commandOrderL14Step3 => 'Pinjam bukunya';

  @override
  String get commandOrderL14Step4 => 'Bawa bukunya pulang';

  @override
  String get commandOrderL14Step5 => 'Baca bukunya';

  @override
  String get commandOrderL14Step6 => 'Kembalikan bukunya';

  @override
  String get commandOrderL14Hint =>
      'Untuk memilih buku, kamu harus pergi dulu ke tempat buku-buku berada.';

  @override
  String get commandOrderL15Title => 'Dirikan tenda';

  @override
  String get commandOrderL15Stage1 => 'Siapkan tempatnya';

  @override
  String get commandOrderL15Stage2 => 'Mendirikan tenda';

  @override
  String get commandOrderL15Stage3 => 'Siapkan bagian dalam';

  @override
  String get commandOrderL15Step1 => 'Cari tempat yang datar';

  @override
  String get commandOrderL15Step2 => 'Bentangkan tenda di tanah';

  @override
  String get commandOrderL15Step3 => 'Pasang tiang-tiangnya';

  @override
  String get commandOrderL15Step4 => 'Tegakkan tendanya';

  @override
  String get commandOrderL15Step5 => 'Kuatkan dengan pasak';

  @override
  String get commandOrderL15Step6 => 'Taruh kantong tidur di dalam';

  @override
  String get commandOrderL15Step7 => 'Nyalakan lenteramu';

  @override
  String get commandOrderL15Hint =>
      'Untuk membentangkan tenda, kamu harus menemukan tempat yang bagus dulu.';

  @override
  String get commandOrderL16Title => 'Buat piza';

  @override
  String get commandOrderL16Stage1 => 'Adonan';

  @override
  String get commandOrderL16Stage2 => 'Taburan';

  @override
  String get commandOrderL16Stage3 => 'Memanggang';

  @override
  String get commandOrderL16Step1 => 'Gilas adonannya';

  @override
  String get commandOrderL16Step2 => 'Oleskan saus tomat';

  @override
  String get commandOrderL16Step3 => 'Taburkan keju';

  @override
  String get commandOrderL16Step4 => 'Masukkan ke oven';

  @override
  String get commandOrderL16Step5 => 'Tunggu sampai matang';

  @override
  String get commandOrderL16Step6 => 'Potong pizanya';

  @override
  String get commandOrderL16Extra1 => 'Nyalakan TV';

  @override
  String get commandOrderL16Hint =>
      'Tidak semua kartu termasuk tugas ini. Apakah kamu perlu TV untuk membuat piza?';

  @override
  String get commandOrderL17Title => 'Mencuci baju';

  @override
  String get commandOrderL17Stage1 => 'Persiapan';

  @override
  String get commandOrderL17Stage2 => 'Mencuci';

  @override
  String get commandOrderL17Stage3 => 'Mengeringkan';

  @override
  String get commandOrderL17Step1 => 'Kumpulkan baju kotor';

  @override
  String get commandOrderL17Step2 => 'Masukkan ke mesin cuci';

  @override
  String get commandOrderL17Step3 => 'Tambahkan sabun cuci';

  @override
  String get commandOrderL17Step4 => 'Nyalakan mesinnya';

  @override
  String get commandOrderL17Step5 => 'Jemur bajunya';

  @override
  String get commandOrderL17Step6 => 'Lipat setelah kering';

  @override
  String get commandOrderL17Extra1 => 'Main bola';

  @override
  String get commandOrderL17Hint =>
      'Kalau baju kotornya berserakan, apa yang harus kamu lakukan dulu?';

  @override
  String get commandOrderL18Title => 'Naik kereta api';

  @override
  String get commandOrderL18Stage1 => 'Di stasiun';

  @override
  String get commandOrderL18Stage2 => 'Di dalam kereta';

  @override
  String get commandOrderL18Stage3 => 'Tiba di tujuan';

  @override
  String get commandOrderL18Step1 => 'Beli tiket';

  @override
  String get commandOrderL18Step2 => 'Pergi ke peron';

  @override
  String get commandOrderL18Step3 => 'Tunggu keretanya';

  @override
  String get commandOrderL18Step4 => 'Naik ke kereta';

  @override
  String get commandOrderL18Step5 => 'Duduk di kursimu';

  @override
  String get commandOrderL18Step6 => 'Turun di stasiun tujuanmu';

  @override
  String get commandOrderL18Extra1 => 'Naik pesawat';

  @override
  String get commandOrderL18Hint =>
      'Apa yang harus kamu bawa untuk naik kereta?';

  @override
  String get commandOrderL19Title => 'Tumbuhkan bibit pohon';

  @override
  String get commandOrderL19Stage1 => 'Menanam';

  @override
  String get commandOrderL19Stage2 => 'Merawat';

  @override
  String get commandOrderL19Stage3 => 'Tumbuh besar';

  @override
  String get commandOrderL19Step1 => 'Isi pot dengan tanah';

  @override
  String get commandOrderL19Step2 => 'Tanam bijinya';

  @override
  String get commandOrderL19Step3 => 'Siram bijinya';

  @override
  String get commandOrderL19Step4 => 'Taruh pot di bawah sinar matahari';

  @override
  String get commandOrderL19Step5 => 'Tunggu tunasnya tumbuh';

  @override
  String get commandOrderL19Step6 => 'Pindahkan ke kebun';

  @override
  String get commandOrderL19Extra1 => 'Buka payung';

  @override
  String get commandOrderL19Extra2 => 'Taruh pot di tempat gelap';

  @override
  String get commandOrderL19Hint =>
      'Tanaman butuh air dan sinar matahari untuk tumbuh. Kartu mana yang akan membuatnya layu?';

  @override
  String get commandOrderL20Title => 'Buat dan bagikan kue kering';

  @override
  String get commandOrderL20Stage1 => 'Persiapan';

  @override
  String get commandOrderL20Stage2 => 'Memanggang';

  @override
  String get commandOrderL20Stage3 => 'Berbagi';

  @override
  String get commandOrderL20Step1 => 'Cuci tanganmu';

  @override
  String get commandOrderL20Step2 => 'Campur bahan-bahannya';

  @override
  String get commandOrderL20Step3 => 'Bentuk adonannya';

  @override
  String get commandOrderL20Step4 => 'Panggang di oven';

  @override
  String get commandOrderL20Step5 => 'Biarkan dingin';

  @override
  String get commandOrderL20Step6 => 'Masukkan ke kotak';

  @override
  String get commandOrderL20Step7 => 'Bagikan ke teman-temanmu';

  @override
  String get commandOrderL20Extra1 => 'Main mobil-mobilan';

  @override
  String get commandOrderL20Extra2 => 'Pergi tidur';

  @override
  String get commandOrderL20Hint =>
      'Sebelum bekerja di dapur, kamu harus bersih dulu.';
}
