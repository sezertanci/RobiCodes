// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Robi Kodluyor';

  @override
  String get languageName => 'Türkçe';

  @override
  String get homeLogoTop => 'Robi';

  @override
  String get homeLogoBottom => 'Kodluyor';

  @override
  String get homeTagline => 'Oyna • Öğren • Keşfet';

  @override
  String get homeComingSoon => 'Yakında';

  @override
  String get homeLocked => 'Kilitli';

  @override
  String homeLevels(Object completed, Object levels) {
    return '$completed/$levels seviye';
  }

  @override
  String get homeChangeCharacter => 'Değiştir';

  @override
  String homeCharacterLabel(Object name) {
    return 'Karakterin: $name. Değiştirmek için dokun.';
  }

  @override
  String get commonClose => 'Kapat';

  @override
  String get commonNextLevel => 'Sonraki seviye';

  @override
  String get commonBackToHome => 'Ana ekrana dön';

  @override
  String get commonBackToLevels => 'Seviyelere dön';

  @override
  String commonStars(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yıldız',
    );
    return '$_temp0';
  }

  @override
  String get commonRun => 'Başlat';

  @override
  String get commonHint => 'İpucu';

  @override
  String get commonClear => 'Temizle';

  @override
  String get commonDelete => 'Sil';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsSound => 'Ses';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String difficulty(String difficulty) {
    String _temp0 = intl.Intl.selectLogic(difficulty, {
      'easy': 'Kolay',
      'medium': 'Orta',
      'hard': 'Zor',
      'other': 'Uzman',
    });
    return '$_temp0';
  }

  @override
  String get basePackTitle => 'Temel Seviyeler';

  @override
  String get playPreviousLevel => 'Önceki seviye';

  @override
  String playLevelLabel(Object difficulty, Object level) {
    return '$difficulty, seviye $level';
  }

  @override
  String playFinishGroupFirst(Object difficulty) {
    return 'Önce $difficulty seviyelerini bitir';
  }

  @override
  String get playPreviewNote =>
      'Her zorluğun ilk seviyesi ücretsiz denenebilir. Diğer seviyeler satın alınınca açılır.';

  @override
  String get playLevelComplete => 'Harika! Seviye tamamlandı.';

  @override
  String playLevel(Object level) {
    return 'Seviye $level';
  }

  @override
  String playLevelLocked(Object level) {
    return 'Seviye $level, kilitli';
  }

  @override
  String playLevelStars(Object level, Object stars) {
    return 'Seviye $level, $stars';
  }

  @override
  String get playLocked => 'kilitli';

  @override
  String get gamePathFinderTitle => 'Robotun Yolunu Bul';

  @override
  String get gamePathFinderDescription =>
      'Yön komutlarıyla robotu hedefe ulaştır.';

  @override
  String get gamePathFinderTrophy => 'Robot Ustası';

  @override
  String get gamePathFinderTrophyDescription => 'Robot artık her yolu biliyor!';

  @override
  String get gameCommandOrderTitle => 'Komutları Sırala';

  @override
  String get gameCommandOrderDescription => 'Adımları doğru sıraya diz.';

  @override
  String get gameCommandOrderTrophy => 'Algoritma Ustası';

  @override
  String get gameCommandOrderTrophyDescription =>
      'Adımları sıralamakta bir numarasın!';

  @override
  String get gameIfThenTitle => 'Eğer Böyleyse';

  @override
  String get gameIfThenDescription => 'Duruma göre doğru komutu seç.';

  @override
  String get gameIfThenTrophy => 'Karar Ustası';

  @override
  String get gameIfThenTrophyDescription =>
      'Her durumda doğru kararı veriyorsun!';

  @override
  String get gameRepeatTitle => 'Tekrar Et';

  @override
  String get gameRepeatDescription => 'Tekrarlanan hareketleri tek blokla yap.';

  @override
  String get gameRepeatTrophy => 'Döngü Ustası';

  @override
  String get gameRepeatTrophyDescription => 'Tekrarları ustaca kullanıyorsun!';

  @override
  String get gameBugHunterTitle => 'Hata Avcısı';

  @override
  String get gameBugHunterDescription => 'Bozuk kodu bul ve düzelt.';

  @override
  String get gameBugHunterTrophy => 'Usta Hata Avcısı';

  @override
  String get gameBugHunterTrophyDescription => 'En zor hataları bile buldun!';

  @override
  String get gameMyCommandTitle => 'Kendi Komutunu Oluştur';

  @override
  String get gameMyCommandDescription =>
      'Oklarla kendi komutunu yap, tekrar tekrar kullan.';

  @override
  String get gameMyCommandTrophy => 'Komut Mimarı';

  @override
  String get gameMyCommandTrophyDescription =>
      'Kendi komutlarınla en zor yolları çözdün!';

  @override
  String get characterTitle => 'Karakterini seç';

  @override
  String characterName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'robi': 'Robi',
      'fiyo': 'Fiyo',
      'pervane': 'Pervane',
      'isil': 'Işıl',
      'kahraman': 'Kahraman',
      'pembe': 'Pembe',
      'sovalye': 'Şövalye',
      'piril': 'Pırıl',
      'other': 'Robi',
    });
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Başarılarım';

  @override
  String achievementsSummary(int count) {
    return '$count ödül kazandın!';
  }

  @override
  String get achievementsBadges => 'Rozetler';

  @override
  String get achievementsBadgesSubtitle => 'Küçük başarılar';

  @override
  String get achievementsBadgesEarned => 'Kazandığın rozetler';

  @override
  String get achievementsBadgesLocked => 'Kazanılacak rozetler';

  @override
  String get achievementsBadgesEmpty =>
      'Henüz rozetin yok. İlk seviyeni bitir!';

  @override
  String get achievementsTrophies => 'Kupalar';

  @override
  String get achievementsTrophiesSubtitle => 'Büyük hedefler';

  @override
  String get achievementsTrophiesEarned => 'Kazandığın kupalar';

  @override
  String get achievementsTrophiesLocked => 'Kilitli kupalar';

  @override
  String get achievementsTrophiesEmpty =>
      'Henüz kupan yok. Büyük hedeflere doğru devam!';

  @override
  String achievementsButtonLabel(Object earned, Object total) {
    return 'Başarılarım: $earned/$total';
  }

  @override
  String get achievementEarned => 'Kazanıldı!';

  @override
  String get achievementCondition => 'Nasıl kazanılır? ';

  @override
  String achievementCardEarned(Object title) {
    return '$title, kazanıldı';
  }

  @override
  String achievementCardLocked(Object title) {
    return '$title, kilitli';
  }

  @override
  String get achievementNewBadge => 'Yeni rozet!';

  @override
  String get achievementNewTrophy => 'Yeni kupa kazandın!';

  @override
  String get achievementGreat => 'Harika!';

  @override
  String get achievementFirstGameTitle => 'İlk Oyunum';

  @override
  String get achievementFirstGameDescription =>
      'Kodlama macerana ilk adımı attın!';

  @override
  String get achievementFirstGameCondition => 'İlk oyun seviyeni tamamla.';

  @override
  String get achievementQuickStartTitle => 'Hızlı Başlangıç';

  @override
  String get achievementQuickStartDescription =>
      'Robotlar seninle gurur duyuyor!';

  @override
  String achievementQuickStartCondition(Object goal) {
    return 'Bir oyunda $goal seviye tamamla.';
  }

  @override
  String get achievementDeterminedTitle => 'Azimli Oyuncu';

  @override
  String get achievementDeterminedDescription => 'Pes etmeden devam ettin!';

  @override
  String achievementDeterminedCondition(Object goal) {
    return 'Bir oyunda $goal seviye tamamla.';
  }

  @override
  String get achievementMasterCoderTitle => 'Usta Kodlayıcı';

  @override
  String get achievementMasterCoderDescription =>
      'Bir oyunun bütün seviyelerini bitirdin!';

  @override
  String get achievementMasterCoderCondition =>
      'Bir oyunun bütün seviyelerini tamamla.';

  @override
  String get achievementAllGamesTitle => 'Oyun Kaşifi';

  @override
  String get achievementAllGamesDescription => 'Bütün oyunları denedin!';

  @override
  String get achievementAllGamesCondition =>
      'Bütün oyunlarda en az bir seviye bitir.';

  @override
  String get achievementStarHunterTitle => 'Yıldız Avcısı';

  @override
  String get achievementStarHunterDescription =>
      'Yıldızları toplamaya başladın!';

  @override
  String achievementStarHunterCondition(Object goal) {
    return 'Toplam $goal yıldız kazan.';
  }

  @override
  String get achievementStarMasterTitle => 'Yıldız Ustası';

  @override
  String get achievementStarMasterDescription => 'Gökyüzü kadar yıldızın var!';

  @override
  String achievementStarMasterCondition(Object goal) {
    return 'Toplam $goal yıldız kazan.';
  }

  @override
  String get achievementPerfectTitle => 'Mükemmel Oyuncu';

  @override
  String get achievementPerfectDescription => 'Bir seviyeyi kusursuz bitirdin!';

  @override
  String achievementPerfectCondition(Object goal) {
    return 'Bir seviyeyi $goal yıldızla tamamla.';
  }

  @override
  String get achievementNoHintTitle => 'İpucusuz Kahraman';

  @override
  String get achievementNoHintDescription => 'Kendi başına çözmeyi başardın!';

  @override
  String achievementNoHintCondition(Object goal) {
    return '$goal seviyeyi ipucu kullanmadan tamamla.';
  }

  @override
  String get achievementBigSuccessTitle => 'Büyük Başarı';

  @override
  String get achievementBigSuccessDescription =>
      'Bütün oyunları baştan sona bitirdin!';

  @override
  String get achievementBigSuccessCondition =>
      'Bütün oyunların tüm seviyelerini tamamla.';

  @override
  String get achievementFirstAdventureTitle => 'İlk Macera Kupası';

  @override
  String get achievementFirstAdventureDescription =>
      'Bütün oyunlarda ilk adımı attın!';

  @override
  String get achievementFirstAdventureCondition =>
      'Her oyunda ilk seviyeyi tamamla.';

  @override
  String get achievementChampionTitle => 'Kodlama Şampiyonu';

  @override
  String get achievementChampionDescription =>
      'Sen gerçek bir kodlama şampiyonusun!';

  @override
  String get achievementChampionCondition =>
      'Bütün oyunların bütün seviyelerini bitir.';

  @override
  String achievementGameTrophyCondition(Object game) {
    return '$game oyununu bitir.';
  }

  @override
  String get parentalGateTitle => 'Ebeveyn onayı';

  @override
  String parentalGateIntro(Object action) {
    return 'Bu işlem için bir yetişkinin onayı gerekiyor: $action.';
  }

  @override
  String parentalGateAction(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'purchase': 'Paket satın alma',
      'other': 'İşlem',
    });
    return '$_temp0';
  }

  @override
  String get parentalGateAnswerHint => 'Cevabı rakamlarla yazın.';

  @override
  String get parentalGateCancel => 'Vazgeç';

  @override
  String get parentalGateConfirm => 'Onayla';

  @override
  String get parentalGateAnswer => 'Cevap';

  @override
  String get parentalGateWrongAnswer =>
      'Cevap yanlış. Biraz bekleyin, sonra yeni soruyu cevaplayın.';

  @override
  String parentalGateQuestion(String first, String second) {
    return '$first çarpı $second kaç eder?';
  }

  @override
  String get parentalGateTrialLabel => 'Ebeveyn doğrulamasını dene';

  @override
  String get parentalGateTrialHint =>
      'Yalnızca test derlemesinde görünür. Gerçek satın alma yapılmaz.';

  @override
  String get parentalGateTrialPassed =>
      'Doğrulama geçildi; deneme işlemi çalıştı.';

  @override
  String get parentalGateTrialBlocked =>
      'Doğrulama geçilmedi; işlem çalışmadı.';

  @override
  String get storeTitle => 'Paketler';

  @override
  String get storeIntro =>
      'Satın almalar Google Play üzerinden yapılır ve her satın almadan önce ebeveyn onayı istenir. Google Play promosyon kodunu ödeme ekranındaki \"Kodu kullan\" bağlantısından veya Play Store uygulamasından kullanabilirsiniz; kodla alınan paket de burada sahip olunan olarak görünür.';

  @override
  String get storePaidSection => 'Satın alınabilir paketler';

  @override
  String get storeFreeSection => 'Ücretsiz paketler';

  @override
  String get storeNoProducts => 'Şu an satın alınabilir paket yok.';

  @override
  String get storeBundle => 'Avantajlı paket';

  @override
  String get storeStarterBundleTitle => 'Başlangıç Seti';

  @override
  String get storeOwned => 'Sahipsiniz';

  @override
  String get storeUnlocks => 'Satın alındığında açılanlar:';

  @override
  String get storePriceLoading => 'Fiyat Google Play\'den alınıyor…';

  @override
  String get storePriceUnavailable => 'Fiyat Google Play\'den alınamadı.';

  @override
  String get storeNotInStore => 'Bu paket şu an Google Play\'de bulunmuyor.';

  @override
  String get storeRetry => 'Tekrar dene';

  @override
  String storePartiallyOwned(Object missing) {
    return 'Bu paketteki içeriklerin bir kısmına zaten sahipsiniz. Google Play fiyatı sahip olduklarınıza göre düşürmediği için aynı içerik için iki kez ödeme yapmamanız adına bu paket satılmıyor. Eksik paketler: $missing';
  }

  @override
  String get storeRestore => 'Satın alımları geri yükle';

  @override
  String get storeRestoreHint =>
      'Google Play hesabınızdaki satın alımları yeniden okur; oyun ilerlemesi silinmez.';

  @override
  String storeRestored(Object count) {
    return 'Satın alımlar Google Play\'den yeniden okundu. Sahip olunan ürün: $count.';
  }

  @override
  String get storeRestoreOffline =>
      'İnternet bağlantısı yok; cihazdaki satın alma kayıtları geçerli kalır.';

  @override
  String get storeRestoreUnavailable =>
      'Google Play\'e bağlanılamadı; cihazdaki satın alma kayıtları geçerli kalır.';

  @override
  String storeBuy(Object price) {
    return 'Satın al – $price';
  }

  @override
  String storeLevels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seviye',
    );
    return '$_temp0';
  }

  @override
  String storePackLine(Object game, Object pack, Object levels) {
    return '$game – $pack ($levels)';
  }

  @override
  String get storePurchased => 'Satın alma tamamlandı; paket açıldı.';

  @override
  String get storePending =>
      'Ödeme beklemede. Ödeme tamamlanınca paket kendiliğinden açılır.';

  @override
  String get storeCancelled => 'Satın alma iptal edildi.';

  @override
  String get storeAlreadyOwned =>
      'Bu pakete zaten sahipsiniz; yeniden satın alınmadı.';

  @override
  String get storeBundlePartiallyOwned =>
      'Bu paketteki içeriklerin bir kısmına zaten sahipsiniz; aynı içerik için iki kez ödeme yapmamanız adına satın alma başlatılmadı.';

  @override
  String get storeOffline =>
      'İnternet bağlantısı yok. Bağlantıyı kontrol edip tekrar deneyin.';

  @override
  String get storeUnavailable =>
      'Google Play\'e bağlanılamadı. Daha sonra tekrar deneyin.';

  @override
  String get storeFailed => 'Satın alma tamamlanamadı.';

  @override
  String get storeNotApproved =>
      'Ebeveyn onayı verilmedi; satın alma başlatılmadı.';

  @override
  String get gameRobotRunning => 'Robot yola çıktı...';

  @override
  String get gameRobotReachedFlag => 'Harika! Robot bayrağa ulaştı!';

  @override
  String get gameMissingCoins =>
      'Bayrağa ulaştın ama bütün altınları toplamadın. Önce altınları topla.';

  @override
  String gameDirection(String direction) {
    String _temp0 = intl.Intl.selectLogic(direction, {
      'up': 'Yukarı',
      'down': 'Aşağı',
      'left': 'Sola',
      'other': 'Sağa',
    });
    return '$_temp0';
  }

  @override
  String gameObstacle(String obstacle) {
    String _temp0 = intl.Intl.selectLogic(obstacle, {
      'rock': 'taşa',
      'water': 'suya',
      'other': 'harita kenarına',
    });
    return '$_temp0';
  }

  @override
  String get pathFinderIntro =>
      'Robotu bayrağa ulaştırmak için komutları sırayla seç.';

  @override
  String get pathFinderCoinIntro =>
      'Önce bütün altınları topla, sonra bayrağa git.';

  @override
  String get pathFinderEmpty => 'Önce bir yön komutu ekle.';

  @override
  String get pathFinderFull =>
      'Komut sınırına ulaştın. Bir komutu silip yerine başkasını koyabilirsin.';

  @override
  String get pathFinderMissedGoal =>
      'Robot bayrağa ulaşamadı. Komut eklemeyi ya da değiştirmeyi dene.';

  @override
  String get pathFinderTooMany =>
      'Bu komutlarla sınır içinde bitiremezsin. Gereksiz adımları silmeyi dene.';

  @override
  String get pathFinderSolved => 'Komutların doğru! Yeşil Başlat tuşuna dokun.';

  @override
  String get pathFinderEmptyStrip =>
      'Yön tuşlarına bas, komutların burada sıralansın.';

  @override
  String get pathFinderMoveLeft => 'Seçili komutu bir sola taşı';

  @override
  String get pathFinderMoveRight => 'Seçili komutu bir sağa taşı';

  @override
  String pathFinderBlocked(Object obstacle, Object number) {
    return 'Robot $obstacle çarptı. $number. komutu değiştirmeyi dene.';
  }

  @override
  String pathFinderFixCommand(Object number) {
    return '$number. komut robotu yoldan çıkarıyor. Onu senin için seçtim; silebilir ya da yerini değiştirebilirsin.';
  }

  @override
  String pathFinderNextMove(Object direction) {
    return 'Parlayan kareye bak. Sıradaki komut: $direction.';
  }

  @override
  String pathFinderAddCommand(Object direction) {
    return '$direction komutu ekle';
  }

  @override
  String pathFinderCommandChip(Object number, Object direction) {
    return '$number. komut: $direction';
  }

  @override
  String get commandOrderIntro =>
      'Görevi bitirmek için kartları doğru sıraya diz. Bir karta dokun ya da onu bir kutuya sürükle.';

  @override
  String get commandOrderExtrasIntro =>
      'Dikkat! Bazı kartlar bu göreve ait değil. Yalnızca gereken kartları sıraya diz.';

  @override
  String get commandOrderFull =>
      'Bütün kutular dolu. Bir kartı geri almak için ona dokun.';

  @override
  String get commandOrderNotFull => 'Önce bütün kutuları doldur.';

  @override
  String get commandOrderSuccess => 'Harika! Bütün adımlar doğru sırada.';

  @override
  String get commandOrderSolved =>
      'Sıralama doğru! Yeşil Kontrol et tuşuna dokun.';

  @override
  String get commandOrderPoolEmpty => 'Bütün kartlar yerleşti';

  @override
  String get commandOrderCheck => 'Kontrol et';

  @override
  String commandOrderWrongExtra(Object card) {
    return '\"$card\" bu görev için gerekli değil. Onu kutudan çıkar.';
  }

  @override
  String commandOrderWrongTooEarly(Object number, Object card) {
    return '$number. kutudaki \"$card\" için henüz erken. Ondan önce yapılması gereken bir adım var.';
  }

  @override
  String commandOrderHint(Object levelHint, Object card, Object number) {
    return '$levelHint Parlayan kart \"$card\" $number. kutuya gelmeli.';
  }

  @override
  String commandOrderSlotCard(Object number, Object card) {
    return '$number. kutu: $card. Geri almak için dokun.';
  }

  @override
  String commandOrderEmptySlot(Object number) {
    return '$number. kutu, boş. Kartın buraya gelmesi için dokun.';
  }

  @override
  String get ifThenIncomplete => 'Önce boş kutuları doldur.';

  @override
  String get ifThenSuccess =>
      'Harika! Robot kurallarını izleyip bayrağa ulaştı!';

  @override
  String get ifThenSolved => 'Kuralların doğru! Yeşil Başlat tuşuna dokun.';

  @override
  String get ifThenNoSlot =>
      'Bu blok için boş kutu yok. Değiştirmek istediğin kutuya dokunup onu boşalt.';

  @override
  String get ifThenLockedSlot =>
      'Bu kutu hazır geldi, değiştirilemez. Bloğu boş bir kutuya koy.';

  @override
  String get ifThenWrongType =>
      'Bu blok oraya uymaz. Nesneler \"Eğer\" kutusuna, hareketler ok işaretinin yanına gider.';

  @override
  String get ifThenLane => 'Robotun yolu';

  @override
  String get ifThenObjects => 'Nesneler';

  @override
  String get ifThenActions => 'Hareketler';

  @override
  String get ifThenIf => 'Eğer';

  @override
  String get ifThenElseIf => 'Değilse eğer';

  @override
  String get ifThenElse => 'Değilse';

  @override
  String get ifThenThen => 'varsa';

  @override
  String ifThenObjectLabel(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Boş yol',
      'rock': 'Taş',
      'water': 'Su',
      'door': 'Kapı',
      'other': 'Yıldız',
    });
    return '$_temp0';
  }

  @override
  String ifThenActionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'forward': 'İleri Git',
      'jump': 'Zıpla',
      'bridge': 'Köprü Kur',
      'open': 'Kapıyı Aç',
      'other': 'Topla',
    });
    return '$_temp0';
  }

  @override
  String ifThenObjectName(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'boş yol',
      'rock': 'taş',
      'water': 'su',
      'door': 'kapı',
      'other': 'yıldız',
    });
    return '$_temp0';
  }

  @override
  String ifThenProblem(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Boş yolda buna gerek yok.',
      'rock': 'Taşın içinden geçilemez.',
      'water': 'Robot yüzemez!',
      'door': 'Kapı kapalıyken geçilemez.',
      'other': 'Yıldız yerde kaldı.',
    });
    return '$_temp0';
  }

  @override
  String ifThenAdvice(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Yol boşsa robot ileri gidebilir.',
      'rock': 'Taşın üstünden zıplayarak geçilir.',
      'water': 'Suyun üstünden geçmek için köprü kurmak gerekir.',
      'door': 'Kapıdan geçmek için önce kapıyı açmalısın.',
      'other': 'Yıldızı almak için Topla bloğunu kullan.',
    });
    return '$_temp0';
  }

  @override
  String ifThenRuleNumber(Object number) {
    return '$number. kural';
  }

  @override
  String get ifThenElseRule => '\"Değilse\" satırı';

  @override
  String ifThenWrong(
    Object object,
    Object rule,
    Object action,
    Object problem,
  ) {
    return 'Önünde $object vardı. $rule çalıştı ve robot \"$action\" yaptı. $problem Kuralları değiştirip yeniden dene.';
  }

  @override
  String ifThenHint(Object object, Object advice) {
    return 'Parlayan karede $object var. $advice';
  }

  @override
  String ifThenSlot(String kind, Object value) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'condition': 'Koşul',
      'other': 'Hareket',
    });
    return '$_temp0 kutusu: $value';
  }

  @override
  String get ifThenSlotEmpty => 'boş';

  @override
  String ifThenSlotReady(Object label) {
    return '$label, hazır';
  }

  @override
  String ifThenPaletteBlock(String kind, Object label) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'action': 'Hareket',
      'other': 'Nesne',
    });
    return '$_temp0: $label';
  }

  @override
  String get repeatIntro =>
      'Robotu bayrağa götür. Aynı hareketi tekrar tekrar eklemek yerine Tekrarla bloğunu kullan.';

  @override
  String get repeatCoinIntro =>
      'Önce bütün altınları topla, sonra bayrağa git. Tekrarla bloğu işini kolaylaştırır.';

  @override
  String get repeatEmpty => 'Önce bir ok ya da Tekrarla bloğu ekle.';

  @override
  String get repeatFull =>
      'Blok sınırına ulaştın. Hazırsan yeşil Başlat tuşuna dokun; değiştirmek istersen bir bloğu seçip sil.';

  @override
  String get repeatInsideRepeat =>
      'Şimdi eklediğin oklar turuncu bloğun içine girecek. Bitince lacivert Bloktan çık düğmesine dokun.';

  @override
  String get repeatEmptyStrip =>
      'Ok ya da Tekrarla bloğu ekle, bloklar burada sıralansın.';

  @override
  String get repeatOutsideRepeat =>
      'Şimdi eklediğin oklar bloğun dışına, sona eklenecek.';

  @override
  String get repeatMovedOut =>
      'Ok bloğun dışına çıktı. Şimdi eklediğin oklar da dışarıya, sona eklenecek.';

  @override
  String get repeatEmptyRepeat =>
      'Turuncu bloğun içi boş. Onu seçtim; şimdi içine bir ok ekle.';

  @override
  String get repeatMissedGoal =>
      'Robot bayrağa ulaşamadı. Tekrar sayısını ya da okları değiştirmeyi dene.';

  @override
  String get repeatSolved => 'Blokların doğru! Yeşil Başlat tuşuna dokun.';

  @override
  String get repeatFullHint =>
      'Blok sınırın doldu. Bir tekrar sayısını değiştirmeyi ya da bir bloğu silip yerine Tekrarla bloğu koymayı dene.';

  @override
  String get repeatAddRepeat => 'Tekrarla';

  @override
  String get repeatLeaveRepeat => 'Bloktan çık ✓';

  @override
  String get repeatAddRepeatLabel => 'Tekrarla bloğu ekle';

  @override
  String get repeatLeaveRepeatLabel =>
      'Bloktan çık; sonraki oklar dışarıya eklensin';

  @override
  String get repeatDropHere => 'Okları buraya ekle';

  @override
  String get repeatEmptyBody => 'Boş';

  @override
  String get repeatDecrease => 'Tekrar sayısını azalt';

  @override
  String get repeatIncrease => 'Tekrar sayısını artır';

  @override
  String get repeatDeleteLabel => 'Seçili bloğu sil';

  @override
  String get repeatMoveOutLabel => 'Seçili oku turuncu bloğun dışına taşı';

  @override
  String repeatTimes(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: '$times kez',
    );
    return '$_temp0';
  }

  @override
  String repeatTimesFull(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: '$times kez tekrarla',
    );
    return '$_temp0';
  }

  @override
  String repeatAddMove(Object direction) {
    return '$direction oku ekle';
  }

  @override
  String repeatArrowName(Object number) {
    return '$number. ok';
  }

  @override
  String repeatBlockName(Object number) {
    return '$number. blok';
  }

  @override
  String repeatInnerArrowName(Object block, Object arrow) {
    return '$block. bloğun içindeki $arrow. ok';
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
      other: '$times kez tekrarla',
    );
    return '$number. blok: $_temp0. İçine ok eklemek için dokun.';
  }

  @override
  String repeatFixCount(Object number) {
    return '$number. bloğun tekrar sayısını ya da içindeki okları değiştirmeyi dene.';
  }

  @override
  String repeatOffPath(Object place) {
    return '$place robotu yoldan çıkarıyor.';
  }

  @override
  String repeatExtraBlock(Object place) {
    return '$place fazla. Onu silmeyi dene.';
  }

  @override
  String repeatBlocked(Object obstacle, Object advice) {
    return 'Robot $obstacle çarptı. $advice';
  }

  @override
  String repeatBlockedInRound(Object round, Object obstacle, Object advice) {
    return 'Robot $round. turda $obstacle çarptı. $advice';
  }

  @override
  String repeatFixHint(Object advice) {
    return '$advice Yanlış yeri senin için kırmızıyla gösterdim.';
  }

  @override
  String repeatNextMoveHint(Object levelHint, Object direction) {
    return '$levelHint Parlayan kareye bak; robot oraya $direction gitmeli.';
  }

  @override
  String get repeatL1Intro =>
      'Robot 3 kez sağa gitmeli ama yalnızca 2 blok kullanabilirsin. Tekrarla bloğunu ekle, içine sağ oku koy.';

  @override
  String get repeatL1Hint =>
      'Tekrarla bloğu, içindeki oku söylediğin kadar yapar. Kaç kez sağa gitmeli?';

  @override
  String get repeatL2Intro =>
      'Bayrak yukarıda. Aynı oku tekrar tekrar eklemek yerine Tekrarla bloğunu kullan.';

  @override
  String get repeatL2Hint =>
      'Robot hep aynı yöne gidiyor. Hangi yöne ve kaç kez?';

  @override
  String get repeatL3Hint =>
      'Robot aşağı iniyor. Kareleri say ve tekrar sayısını ayarla.';

  @override
  String get repeatL4Hint =>
      'Bu kez sola. Tekrar sayısını − ve + düğmeleriyle değiştirebilirsin.';

  @override
  String get repeatL5Intro =>
      'Yoldaki altınları da topla! Yine yalnızca 2 blok var.';

  @override
  String get repeatL5Hint =>
      'Altınlar robotla bayrak arasında, aynı sırada. Robot yalnızca sağa gidiyor.';

  @override
  String get repeatL6Intro =>
      'Merdiven gibi in: sağa, aşağı, sağa, aşağı... Tekrarla bloğunun içine iki ok koyabilirsin.';

  @override
  String get repeatL6Hint =>
      'Bir basamak: bir sağa, bir aşağı. Kaç basamak var?';

  @override
  String get repeatL7Hint =>
      'İki kez sağa, bir kez yukarı. Bu desen kaç kez tekrar ediyor?';

  @override
  String get repeatL8Hint => 'Önce iki sağa, sonra bir aşağı. Bunu tekrar et.';

  @override
  String get repeatL9Intro =>
      'Tekrarla bloğundan sonra tek bir ok da ekleyebilirsin.';

  @override
  String get repeatL9Hint =>
      'Yukarı-sol desenini tekrarla; sonunda bir adım daha gerekebilir.';

  @override
  String get repeatL10Hint => 'Her basamak iki kare geniş, bir kare yüksek.';

  @override
  String get repeatL11Intro =>
      'Bu kez iki Tekrarla bloğu gerekiyor: biri sağa, biri aşağı.';

  @override
  String get repeatL11Hint =>
      'Önce sağa kaç kare? Sonra aşağı kaç kare? Her biri için ayrı bir Tekrarla bloğu kullan.';

  @override
  String get repeatL12Hint =>
      'Önce yukarı çık, sonra sağa git. İki Tekrarla bloğu, iki farklı sayı.';

  @override
  String get repeatL13Hint =>
      'Taşların etrafından dolaş: sağa, aşağı, sola. Her yön için kareleri say.';

  @override
  String get repeatL14Hint => 'Yol üç parça: sağa, aşağı, yine sağa.';

  @override
  String get repeatL15Hint =>
      'İki altın da yolun köşelerinde. Her düz parçayı bir Tekrarla bloğuyla yap.';

  @override
  String get repeatL16Intro =>
      'Yalnızca 4 blok! Uzun yolu kısa bir desenle yürü.';

  @override
  String get repeatL16Hint =>
      'Altınlar çapraz dizilmiş: sağa-aşağı desenine bak.';

  @override
  String get repeatL17Hint => 'Her basamak iki kare yüksek, iki kare geniş.';

  @override
  String get repeatL18Hint =>
      'İki sağa, iki aşağı. Bu desen bayrağa kadar sürüyor.';

  @override
  String get repeatL19Hint =>
      'Altınlar basamakların köşesinde. Bir basamak: iki sağa, bir aşağı.';

  @override
  String get repeatL20Intro =>
      'Yılan gibi kıvrılan uzun bir yol. 10 bloğu akıllıca kullan.';

  @override
  String get repeatL20Hint =>
      'Yol beş düz parçadan oluşuyor. Her parçayı bir Tekrarla bloğuyla yap.';

  @override
  String get bugHunterIntro =>
      'Bu kodda bir hata var! Önce Başlat\'a bas ve robotun nerede şaşırdığını izle.';

  @override
  String get bugHunterSelected =>
      'Ok seçtiysen bir yön tuşu onu değiştirir. Seçili bloğu silebilir ya da önüne yeni bir ok ekleyebilirsin.';

  @override
  String get bugHunterPickInsert =>
      'Önüne hangi ok gelsin? Bir yön tuşuna bas.';

  @override
  String get bugHunterInsertLabel => 'Seçili bloğun önüne ok ekle';

  @override
  String get bugHunterReset => 'Baştan al';

  @override
  String get bugHunterL1Intro =>
      'Robot bayrağa gidemiyor, kodda bir hata var! Başlat\'a bas ve robotu izle. Sonra yanlış oka dokunup doğru yön tuşuna bas.';

  @override
  String get bugHunterL1Hint =>
      'Bayrak tam sağda. Bütün oklar sağı göstermeli.';

  @override
  String get bugHunterL2Hint =>
      'Robot taşın altından dolaşıyor. Son ok onu bayrağa çıkarmalı.';

  @override
  String get bugHunterL3Intro =>
      'Bu kodda bir ok eksik. Robot nerede durdu? Eksik oku ekle.';

  @override
  String get bugHunterL3Hint =>
      'Robot bayrağa varmadan duruyor. Bir adım daha gerekiyor.';

  @override
  String get bugHunterL4Intro =>
      'Bu kodda fazladan bir ok var. Fazla oku seç ve sil.';

  @override
  String get bugHunterL4Hint =>
      'Robot bayrağa vardıktan sonra bir adım daha atıyor.';

  @override
  String get bugHunterL5Intro =>
      'Bir ok eksik ama yeri sonda değil. Bir oku seç, Önüne ekle düğmesine bas, sonra yön tuşuna bas.';

  @override
  String get bugHunterL5Hint =>
      'Taşın altından geçerken robot iki kez sağa gitmeli.';

  @override
  String get bugHunterL6Hint => 'Altını aldıktan sonra bayrak aşağıda.';

  @override
  String get bugHunterL7Hint =>
      'Suyun yanından geçmek için en alttaki sırada üç kez sağa git.';

  @override
  String get bugHunterL8Intro =>
      'Bu kodda iki hata var! Robot her takıldığında bir hatayı düzelt.';

  @override
  String get bugHunterL8Hint =>
      'Taşların üstünden git: önce sağa, sonra aşağı.';

  @override
  String get bugHunterL9Hint =>
      'İki altını da aldıktan sonra robot bayrakta durmalı.';

  @override
  String get bugHunterL10Hint =>
      'Taşların arasından kıvrılan yolu izle. Bir ok yanlış, bir ok eksik.';

  @override
  String get bugHunterL11Intro =>
      'Bu kez hata turuncu Tekrarla bloğunun içinde. İçteki oku seç ve değiştir.';

  @override
  String get bugHunterL11Hint =>
      'Tekrarla bloğundaki ok bayrağa doğru bakmalı.';

  @override
  String get bugHunterL12Intro =>
      'Bu kodun okları doğru ama tekrar sayısı yanlış. Sayıyı değiştir.';

  @override
  String get bugHunterL12Hint =>
      'Kaç basamak var? Tekrar sayısı basamak sayısı kadar olmalı.';

  @override
  String get bugHunterL13Hint => 'Her basamak iki sağa, bir yukarı.';

  @override
  String get bugHunterL14Hint =>
      'Her basamak iki sağa, bir aşağı. Bloğun içinde bir ok eksik.';

  @override
  String get bugHunterL15Hint =>
      'Tekrarla bloğundan sonra yalnızca bir adım kaldı.';

  @override
  String get bugHunterL16Intro =>
      'Uzman avcı! Bu kodlarda birden çok hata var. Her çalıştırmada birini bul.';

  @override
  String get bugHunterL16Hint => 'Önce sağa kaç kare? Sonra aşağı kaç kare?';

  @override
  String get bugHunterL17Hint =>
      'Her tekrar iki kare sağa gidiyor. Bayrağa kadar kaç tekrar gerekir?';

  @override
  String get bugHunterL18Hint =>
      'Taşlar basamakların üstünde. Her basamakta önce aşağı, sonra sağa git.';

  @override
  String get bugHunterL19Hint =>
      'Suların arasında bir merdiven var: bir sağa, bir aşağı. Kaç basamak var?';

  @override
  String get bugHunterL20Hint =>
      'Önce sağa, sonra aşağı. Her düz parçadaki kareleri say.';

  @override
  String get myCommandIntro =>
      'Üstteki turkuaz şeride oklarla kendi komutunu yap. Sonra alttaki ana programda Komut bloğunu kullan; her Komut bloğu komuttaki okların hepsini yapar.';

  @override
  String get myCommandCommandEmpty => 'Komutunu yap: buraya ok ekle.';

  @override
  String get myCommandMainEmpty => 'Ana program: Komut bloğu ve ok ekle.';

  @override
  String get myCommandButton => 'Komut';

  @override
  String get myCommandButtonLabel => 'Ana programa Komut bloğu ekle';

  @override
  String myCommandCallLabel(Object number) {
    return '$number. blok: komut';
  }

  @override
  String get myCommandEmptyCommand =>
      'Komutun boş. Üstteki turkuaz şeride dokun ve içine ok ekle.';

  @override
  String get myCommandEmptyMain =>
      'Ana program boş. Turkuaz Komut düğmesiyle Komut bloğunu ekle.';

  @override
  String get myCommandEditCommand => 'Şimdi eklediğin oklar komuta girecek.';

  @override
  String get myCommandEditMain =>
      'Şimdi eklediğin bloklar ana programa girecek.';

  @override
  String get myCommandCallAdded =>
      'Komut bloğu ana programa eklendi. Robot burada komuttaki okların hepsini yapacak.';

  @override
  String get myCommandUseHint =>
      'Komutun hazır. Turkuaz Komut düğmesine basıp onu ana programda kullan.';

  @override
  String get myCommandFullHint =>
      'Blok sınırın doldu. Komutu değiştir ya da ana programdaki okların yerine Komut bloğu koy.';

  @override
  String get myCommandMissedGoal =>
      'Robot bayrağa ulaşamadı. Komuttaki okları ya da Komut bloğu sayısını değiştirmeyi dene.';

  @override
  String myCommandOffPath(Object place) {
    return 'Komuttaki $place robotu yoldan çıkarıyor.';
  }

  @override
  String myCommandFixCount(Object number) {
    return 'Komuttaki $number. bloğun tekrar sayısını ya da içindeki okları değiştirmeyi dene.';
  }

  @override
  String get myCommandLaterCall =>
      'Komut bu kullanımda robotu yoldan çıkarıyor; komutu ya da ana programdaki okları değiştir.';

  @override
  String get myCommandL1Intro =>
      'Kendi komutunu yap! Üstteki turkuaz şeride iki sağ ok koy. Sonra Komut düğmesiyle komutunu ana programa ekle.';

  @override
  String get myCommandL1Hint =>
      'Robot 6 kez sağa gitmeli. Komutun 2 sağ ok olursa onu kaç kez kullanmalısın?';

  @override
  String get myCommandL2Hint =>
      'Merdiven gibi in. Bir basamak: bir sağa, bir aşağı. Komutun bu olsun.';

  @override
  String get myCommandL3Intro =>
      'Ana programa Komut bloğunun yanında ok da ekleyebilirsin.';

  @override
  String get myCommandL3Hint =>
      'Taşların arasında bir merdiven var: sağa, aşağı. Sonunda bir adım daha gerekiyor.';

  @override
  String get myCommandL4Hint =>
      'İki sağa, bir yukarı. Bu desen kaç kez tekrar ediyor?';

  @override
  String get myCommandL5Hint =>
      'Robot sola doğru tırmanıyor: bir yukarı, bir sola. Altınlar da bu yolda.';

  @override
  String get myCommandL6Hint => 'Her basamak iki kare geniş, bir kare yüksek.';

  @override
  String get myCommandL7Hint =>
      'İki sağa, iki aşağı. Altınlar bu desenin üstünde.';

  @override
  String get myCommandL8Hint =>
      'Taşların altından geç: önce aşağı, sonra iki sağa.';

  @override
  String get myCommandL9Hint =>
      'Komut dört kez sağa gitsin. İki Komut bloğunun arasında robot aşağı inmeli.';

  @override
  String get myCommandL10Hint =>
      'Taşların arasındaki altınları al: aşağı, iki sağa, yukarı.';

  @override
  String get myCommandL11Intro =>
      'Komutun içine Tekrarla bloğu da koyabilirsin! Böylece kısa bir komut uzun bir yol yürür.';

  @override
  String get myCommandL11Hint =>
      'Komut üç kez sağa gitsin. Komutların arasında robot bir kez aşağı, bir kez yukarı gidiyor.';

  @override
  String get myCommandL12Hint =>
      'Her parça iki sağa, bir aşağı. Bir yerde araya bir aşağı adım daha giriyor.';

  @override
  String get myCommandL13Hint =>
      'Her basamak bir yukarı, iki sağa. Altını unutma.';

  @override
  String get myCommandL14Hint =>
      'Her parça iki sağa, bir yukarı. Komutların arasındaki adımlara da bak.';

  @override
  String get myCommandL15Hint =>
      'Her parça bir aşağı, iki sağa. Komutların arasında yol bazen düz gidiyor.';

  @override
  String get myCommandL16Hint =>
      'Komut: üç sağa, bir aşağı. İlk komuttan sonra bir sola dönmen gerekiyor.';

  @override
  String get myCommandL17Hint =>
      'Her parça bir yukarı, üç sağa. Komutların arasında bir kez daha yukarı çık.';

  @override
  String get myCommandL18Hint =>
      'Komutun içinde iki Tekrarla bloğu olabilir: iki aşağı, iki sağa.';

  @override
  String get myCommandL19Hint =>
      'Komut: bir sağa, iki yukarı, bir sağa. Aradaki okları kareleri sayarak bul.';

  @override
  String get myCommandL20Hint =>
      'Komutta önce iki basamak var: sağa, aşağı. Sonra bir adım daha sağa.';

  @override
  String get ifThenL1Intro =>
      'Önünde taş varsa robot ne yapmalı? Boş kutuya bir hareket koy.';

  @override
  String get ifThenL2Intro => 'Robot yüzemez. Önünde su varsa ne yapmalı?';

  @override
  String get ifThenL3Intro =>
      'Yolda kapalı bir kapı var. Kapının önüne gelince ne yapmalı?';

  @override
  String get ifThenL4Intro =>
      'Yıldızları toplamadan geçme! Önünde yıldız varsa ne yapmalı?';

  @override
  String get ifThenL5Intro => 'Bu kez koşulu da sen seç. Yolda ne var?';

  @override
  String get ifThenL6Intro =>
      'Taş varsa bir şey, yoksa başka bir şey yapmalı. İki kutuyu da doldur.';

  @override
  String get ifThenL7Intro => 'Su varsa ne yapmalı? Su yoksa ne yapmalı?';

  @override
  String get ifThenL8Intro =>
      'Bu yolda boş kare yok! Kapı yoksa önünde ne var?';

  @override
  String get ifThenL9Intro => 'Koşulu ve iki hareketi sen seç.';

  @override
  String get ifThenL10Intro =>
      'Yolda taş ve su var. Bir kural ve bir \"değilse\" yeter.';

  @override
  String get ifThenL11Intro => 'Taş da var su da. Her biri için bir kural kur.';

  @override
  String get ifThenL12Intro => 'Kapıları aç, yıldızları topla.';

  @override
  String get ifThenL13Intro =>
      'Üç farklı şey var ama iki kural satırı. Üçüncüsü için \"değilse\" kullan.';

  @override
  String get ifThenL14Intro =>
      'Su, kapı ve boş yol. Hangisini \"değilse\"ye bırakırsın?';

  @override
  String get ifThenL15Intro => 'Dikkat: bloklardan biri bu yolda hiç yok.';

  @override
  String get ifThenL16Intro =>
      'Robot kaleye gidiyor: taşlar, hendekler ve kale kapıları var.';

  @override
  String get ifThenL17Intro => 'Hazine yolu: yıldızları topla, engelleri aş.';

  @override
  String get ifThenL18Intro =>
      'Bu yolda hiç boş kare yok. Dört şey için dört karar gerek.';

  @override
  String get ifThenL19Intro => 'Uzun bir yolculuk! Su, taş, kapı ve boş yol.';

  @override
  String get ifThenL20Intro =>
      'Son görev: bütün yıldızları toplayıp bayrağa ulaş.';

  @override
  String get pathFinderL1Intro =>
      'Robotu bayrağa götür. Sağa okuna bas, sonra yeşil Başlat tuşuna dokun.';

  @override
  String get pathFinderL2Intro =>
      'Bayrak robotun yukarısında. Hangi oku seçmelisin?';

  @override
  String get pathFinderL3Intro => 'Bayrak solda ve iki kare uzakta.';

  @override
  String get pathFinderL4Intro => 'Robot aşağı inmeli. Kaç kez?';

  @override
  String get pathFinderL5Intro => 'Bu kez iki farklı yön kullanacaksın.';

  @override
  String get pathFinderL11Intro => 'Yolda taş var. Taşın etrafından dolaş.';

  @override
  String get pathFinderL12Intro =>
      'Taşlar duvar gibi dizilmiş. Altından dolaş.';

  @override
  String get pathFinderL13Intro => 'Robot suya giremez. Kuru yolu bul.';

  @override
  String get pathFinderL15Intro =>
      'Birden çok yol var. En kısasını bulabilir misin?';

  @override
  String get commandOrderL1Title => 'Çiçeği sula';

  @override
  String get commandOrderL1Step1 => 'Sulama kabını doldur';

  @override
  String get commandOrderL1Step2 => 'Çiçeği sula';

  @override
  String get commandOrderL1Hint =>
      'Çiçeği sulamak için önce kabın içinde su olmalı.';

  @override
  String get commandOrderL2Title => 'Dişlerini fırçala';

  @override
  String get commandOrderL2Step1 => 'Fırçaya macun sık';

  @override
  String get commandOrderL2Step2 => 'Dişlerini fırçala';

  @override
  String get commandOrderL2Step3 => 'Ağzını çalkala';

  @override
  String get commandOrderL2Hint =>
      'Fırçalamaya başlamadan önce fırçanın üstünde macun olmalı.';

  @override
  String get commandOrderL3Title => 'Ellerini yıka';

  @override
  String get commandOrderL3Step1 => 'Ellerini sabunla';

  @override
  String get commandOrderL3Step2 => 'Ellerini durula';

  @override
  String get commandOrderL3Step3 => 'Ellerini kurula';

  @override
  String get commandOrderL3Hint => 'Köpükler gitmeden elini kurulamak olmaz.';

  @override
  String get commandOrderL4Title => 'Ayakkabını giy';

  @override
  String get commandOrderL4Step1 => 'Çorabını giy';

  @override
  String get commandOrderL4Step2 => 'Ayakkabını giy';

  @override
  String get commandOrderL4Step3 => 'Bağcığını bağla';

  @override
  String get commandOrderL4Hint =>
      'Ayakkabının içine girmeden önce ayağında ne olmalı?';

  @override
  String get commandOrderL5Title => 'Resim yap';

  @override
  String get commandOrderL5Step1 => 'Kâğıdı al';

  @override
  String get commandOrderL5Step2 => 'Resmini çiz';

  @override
  String get commandOrderL5Step3 => 'Resmini boya';

  @override
  String get commandOrderL5Hint =>
      'Boyamak için önce çizilmiş bir resim gerekir.';

  @override
  String get commandOrderL6Title => 'Sandviç hazırla';

  @override
  String get commandOrderL6Step1 => 'Tabağı masaya koy';

  @override
  String get commandOrderL6Step2 => 'Ekmeği tabağa koy';

  @override
  String get commandOrderL6Step3 => 'Üstüne peynir koy';

  @override
  String get commandOrderL6Step4 => 'Üstünü ekmekle kapat';

  @override
  String get commandOrderL6Step5 => 'Afiyetle ye';

  @override
  String get commandOrderL6Hint =>
      'Ekmeği koyacak bir yer lazım. Masada ilk ne olmalı?';

  @override
  String get commandOrderL7Title => 'Oyuncakları topla';

  @override
  String get commandOrderL7Step1 => 'Kutuyu getir';

  @override
  String get commandOrderL7Step2 => 'Oyuncakları kutuya koy';

  @override
  String get commandOrderL7Step3 => 'Kutunun kapağını kapat';

  @override
  String get commandOrderL7Step4 => 'Kutuyu rafa kaldır';

  @override
  String get commandOrderL7Hint =>
      'Oyuncakları koyacağın kutu yanında değilse ne yaparsın?';

  @override
  String get commandOrderL8Title => 'Tohum ek';

  @override
  String get commandOrderL8Step1 => 'Toprakta çukur kaz';

  @override
  String get commandOrderL8Step2 => 'Tohumu çukura koy';

  @override
  String get commandOrderL8Step3 => 'Üstünü toprakla ört';

  @override
  String get commandOrderL8Step4 => 'Tohumu sula';

  @override
  String get commandOrderL8Step5 => 'Filizin çıkmasını bekle';

  @override
  String get commandOrderL8Hint =>
      'Tohumun gireceği bir çukur olmadan onu toprağa koyamazsın.';

  @override
  String get commandOrderL9Title => 'Okula hazırlan';

  @override
  String get commandOrderL9Step1 => 'Alarm çalınca uyan';

  @override
  String get commandOrderL9Step2 => 'Okul kıyafetini giy';

  @override
  String get commandOrderL9Step3 => 'Çantanı sırtına tak';

  @override
  String get commandOrderL9Step4 => 'Servise bin';

  @override
  String get commandOrderL9Hint =>
      'Uyanmadan giyinmek olmaz. Sabah ilk ne olur?';

  @override
  String get commandOrderL10Title => 'Mektup gönder';

  @override
  String get commandOrderL10Step1 => 'Mektubu yaz';

  @override
  String get commandOrderL10Step2 => 'Mektubu zarfa koy';

  @override
  String get commandOrderL10Step3 => 'Zarfı kapat';

  @override
  String get commandOrderL10Step4 => 'Posta kutusuna at';

  @override
  String get commandOrderL10Hint => 'Zarfın içine koyacak bir mektup olmalı.';

  @override
  String get commandOrderL11Title => 'Kek yap';

  @override
  String get commandOrderL11Stage1 => 'Hamuru hazırla';

  @override
  String get commandOrderL11Stage2 => 'Keki pişir';

  @override
  String get commandOrderL11Step1 => 'Malzemeleri masaya koy';

  @override
  String get commandOrderL11Step2 => 'Hepsini kapta karıştır';

  @override
  String get commandOrderL11Step3 => 'Hamuru kalıba dök';

  @override
  String get commandOrderL11Step4 => 'Kalıbı fırına koy';

  @override
  String get commandOrderL11Step5 => 'Pişmesini bekle';

  @override
  String get commandOrderL11Step6 => 'Keki dilimle';

  @override
  String get commandOrderL11Hint =>
      'Hamur hazır olmadan fırına bir şey koyamazsın.';

  @override
  String get commandOrderL12Title => 'Banyo yap';

  @override
  String get commandOrderL12Stage1 => 'Banyoya hazırlan';

  @override
  String get commandOrderL12Stage2 => 'Yıkan';

  @override
  String get commandOrderL12Stage3 => 'Kurulan';

  @override
  String get commandOrderL12Step1 => 'Küveti suyla doldur';

  @override
  String get commandOrderL12Step2 => 'Küvete gir';

  @override
  String get commandOrderL12Step3 => 'Saçını şampuanla';

  @override
  String get commandOrderL12Step4 => 'Köpükleri durula';

  @override
  String get commandOrderL12Step5 => 'Havluyla kurulan';

  @override
  String get commandOrderL12Hint => 'Boş küvete girersen yıkanamazsın.';

  @override
  String get commandOrderL13Title => 'Bisiklet sür';

  @override
  String get commandOrderL13Stage1 => 'Hazırlan';

  @override
  String get commandOrderL13Stage2 => 'Sür';

  @override
  String get commandOrderL13Stage3 => 'Bitir';

  @override
  String get commandOrderL13Step1 => 'Kaskını tak';

  @override
  String get commandOrderL13Step2 => 'Bisiklete bin';

  @override
  String get commandOrderL13Step3 => 'Pedal çevir';

  @override
  String get commandOrderL13Step4 => 'Fren yap';

  @override
  String get commandOrderL13Step5 => 'Bisikletten in';

  @override
  String get commandOrderL13Hint =>
      'Güvenlik önce gelir. Bisiklete binmeden ne takarsın?';

  @override
  String get commandOrderL14Title => 'Kütüphaneden kitap al';

  @override
  String get commandOrderL14Stage1 => 'Kütüphanede';

  @override
  String get commandOrderL14Stage2 => 'Evde';

  @override
  String get commandOrderL14Stage3 => 'Geri ver';

  @override
  String get commandOrderL14Step1 => 'Kütüphaneye git';

  @override
  String get commandOrderL14Step2 => 'Bir kitap seç';

  @override
  String get commandOrderL14Step3 => 'Kitabı ödünç al';

  @override
  String get commandOrderL14Step4 => 'Kitabı eve getir';

  @override
  String get commandOrderL14Step5 => 'Kitabı oku';

  @override
  String get commandOrderL14Step6 => 'Kitabı geri götür';

  @override
  String get commandOrderL14Hint =>
      'Kitap seçmek için önce kitapların olduğu yere gitmelisin.';

  @override
  String get commandOrderL15Title => 'Çadır kur';

  @override
  String get commandOrderL15Stage1 => 'Yeri hazırla';

  @override
  String get commandOrderL15Stage2 => 'Çadırı kur';

  @override
  String get commandOrderL15Stage3 => 'İçini hazırla';

  @override
  String get commandOrderL15Step1 => 'Düz bir yer bul';

  @override
  String get commandOrderL15Step2 => 'Çadırı yere ser';

  @override
  String get commandOrderL15Step3 => 'Direkleri tak';

  @override
  String get commandOrderL15Step4 => 'Çadırı kaldır';

  @override
  String get commandOrderL15Step5 => 'Kazıklarla sabitle';

  @override
  String get commandOrderL15Step6 => 'Uyku tulumunu içine koy';

  @override
  String get commandOrderL15Step7 => 'Fenerini yak';

  @override
  String get commandOrderL15Hint =>
      'Çadırı sermek için önce uygun bir yer bulmalısın.';

  @override
  String get commandOrderL16Title => 'Pizza yap';

  @override
  String get commandOrderL16Stage1 => 'Hamur';

  @override
  String get commandOrderL16Stage2 => 'Malzemeler';

  @override
  String get commandOrderL16Stage3 => 'Pişirme';

  @override
  String get commandOrderL16Step1 => 'Hamuru aç';

  @override
  String get commandOrderL16Step2 => 'Domates sosu sür';

  @override
  String get commandOrderL16Step3 => 'Peynir serp';

  @override
  String get commandOrderL16Step4 => 'Fırına koy';

  @override
  String get commandOrderL16Step5 => 'Pişmesini bekle';

  @override
  String get commandOrderL16Step6 => 'Dilimle';

  @override
  String get commandOrderL16Extra1 => 'Televizyon aç';

  @override
  String get commandOrderL16Hint =>
      'Her kart bu göreve ait değil. Pizza yaparken televizyona gerek var mı?';

  @override
  String get commandOrderL17Title => 'Çamaşır yıka';

  @override
  String get commandOrderL17Stage1 => 'Hazırlık';

  @override
  String get commandOrderL17Stage2 => 'Yıkama';

  @override
  String get commandOrderL17Stage3 => 'Kurutma';

  @override
  String get commandOrderL17Step1 => 'Kirlileri topla';

  @override
  String get commandOrderL17Step2 => 'Makineye koy';

  @override
  String get commandOrderL17Step3 => 'Deterjanı ekle';

  @override
  String get commandOrderL17Step4 => 'Makineyi çalıştır';

  @override
  String get commandOrderL17Step5 => 'Çamaşırları as';

  @override
  String get commandOrderL17Step6 => 'Kuruyunca katla';

  @override
  String get commandOrderL17Extra1 => 'Top oyna';

  @override
  String get commandOrderL17Hint =>
      'Kirli çamaşırlar bir yere dağılmışsa önce ne yapmalısın?';

  @override
  String get commandOrderL18Title => 'Trenle yolculuk';

  @override
  String get commandOrderL18Stage1 => 'İstasyonda';

  @override
  String get commandOrderL18Stage2 => 'Trende';

  @override
  String get commandOrderL18Stage3 => 'Varış';

  @override
  String get commandOrderL18Step1 => 'Bilet al';

  @override
  String get commandOrderL18Step2 => 'Perona git';

  @override
  String get commandOrderL18Step3 => 'Treni bekle';

  @override
  String get commandOrderL18Step4 => 'Trene bin';

  @override
  String get commandOrderL18Step5 => 'Koltuğuna otur';

  @override
  String get commandOrderL18Step6 => 'Durağında in';

  @override
  String get commandOrderL18Extra1 => 'Uçağa bin';

  @override
  String get commandOrderL18Hint => 'Trene binmek için yanında ne olmalı?';

  @override
  String get commandOrderL19Title => 'Fidan yetiştir';

  @override
  String get commandOrderL19Stage1 => 'Ek';

  @override
  String get commandOrderL19Stage2 => 'Bakım yap';

  @override
  String get commandOrderL19Stage3 => 'Büyüt';

  @override
  String get commandOrderL19Step1 => 'Saksıya toprak koy';

  @override
  String get commandOrderL19Step2 => 'Tohumu ek';

  @override
  String get commandOrderL19Step3 => 'Tohumu sula';

  @override
  String get commandOrderL19Step4 => 'Saksıyı güneşe koy';

  @override
  String get commandOrderL19Step5 => 'Filizi bekle';

  @override
  String get commandOrderL19Step6 => 'Bahçeye dik';

  @override
  String get commandOrderL19Extra1 => 'Şemsiye aç';

  @override
  String get commandOrderL19Extra2 => 'Saksıyı karanlığa koy';

  @override
  String get commandOrderL19Hint =>
      'Bitkiler büyümek için su ve güneş ister. Hangi kartlar onlara zarar verir?';

  @override
  String get commandOrderL20Title => 'Kurabiye yap ve paylaş';

  @override
  String get commandOrderL20Stage1 => 'Hazırla';

  @override
  String get commandOrderL20Stage2 => 'Pişir';

  @override
  String get commandOrderL20Stage3 => 'Paylaş';

  @override
  String get commandOrderL20Step1 => 'Ellerini yıka';

  @override
  String get commandOrderL20Step2 => 'Malzemeleri karıştır';

  @override
  String get commandOrderL20Step3 => 'Hamura şekil ver';

  @override
  String get commandOrderL20Step4 => 'Fırında pişir';

  @override
  String get commandOrderL20Step5 => 'Soğumasını bekle';

  @override
  String get commandOrderL20Step6 => 'Kutuya koy';

  @override
  String get commandOrderL20Step7 => 'Arkadaşlarına ikram et';

  @override
  String get commandOrderL20Extra1 => 'Oyuncak araba sür';

  @override
  String get commandOrderL20Extra2 => 'Uyumaya git';

  @override
  String get commandOrderL20Hint =>
      'Mutfakta çalışmadan önce temizlik gerekir.';
}
