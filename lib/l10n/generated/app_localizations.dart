import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('id'),
    Locale('it'),
    Locale('pt'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In tr, this message translates to:
  /// **'Robi Kodluyor'**
  String get appTitle;

  /// No description provided for @languageName.
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get languageName;

  /// No description provided for @homeLogoTop.
  ///
  /// In tr, this message translates to:
  /// **'Robi'**
  String get homeLogoTop;

  /// No description provided for @homeLogoBottom.
  ///
  /// In tr, this message translates to:
  /// **'Kodluyor'**
  String get homeLogoBottom;

  /// No description provided for @homeTagline.
  ///
  /// In tr, this message translates to:
  /// **'Oyna • Öğren • Keşfet'**
  String get homeTagline;

  /// No description provided for @homeComingSoon.
  ///
  /// In tr, this message translates to:
  /// **'Yakında'**
  String get homeComingSoon;

  /// No description provided for @homeLevels.
  ///
  /// In tr, this message translates to:
  /// **'{completed}/{levels} seviye'**
  String homeLevels(Object completed, Object levels);

  /// No description provided for @homeChangeCharacter.
  ///
  /// In tr, this message translates to:
  /// **'Değiştir'**
  String get homeChangeCharacter;

  /// No description provided for @homeCharacterLabel.
  ///
  /// In tr, this message translates to:
  /// **'Karakterin: {name}. Değiştirmek için dokun.'**
  String homeCharacterLabel(Object name);

  /// No description provided for @commonClose.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get commonClose;

  /// No description provided for @commonNextLevel.
  ///
  /// In tr, this message translates to:
  /// **'Sonraki seviye'**
  String get commonNextLevel;

  /// No description provided for @commonBackToHome.
  ///
  /// In tr, this message translates to:
  /// **'Ana ekrana dön'**
  String get commonBackToHome;

  /// No description provided for @commonBackToLevels.
  ///
  /// In tr, this message translates to:
  /// **'Seviyelere dön'**
  String get commonBackToLevels;

  /// No description provided for @commonStars.
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, other{{count} yıldız}}'**
  String commonStars(int count);

  /// No description provided for @commonRun.
  ///
  /// In tr, this message translates to:
  /// **'Başlat'**
  String get commonRun;

  /// No description provided for @commonHint.
  ///
  /// In tr, this message translates to:
  /// **'İpucu'**
  String get commonHint;

  /// No description provided for @commonClear.
  ///
  /// In tr, this message translates to:
  /// **'Temizle'**
  String get commonClear;

  /// No description provided for @commonDelete.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get commonDelete;

  /// No description provided for @settingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settingsTitle;

  /// No description provided for @settingsSound.
  ///
  /// In tr, this message translates to:
  /// **'Ses'**
  String get settingsSound;

  /// No description provided for @settingsLanguage.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get settingsLanguage;

  /// No description provided for @difficulty.
  ///
  /// In tr, this message translates to:
  /// **'{difficulty, select, easy{Kolay} medium{Orta} hard{Zor} other{Uzman}}'**
  String difficulty(String difficulty);

  /// No description provided for @basePackTitle.
  ///
  /// In tr, this message translates to:
  /// **'Temel Seviyeler'**
  String get basePackTitle;

  /// No description provided for @playPreviousLevel.
  ///
  /// In tr, this message translates to:
  /// **'Önceki seviye'**
  String get playPreviousLevel;

  /// No description provided for @playLevelLabel.
  ///
  /// In tr, this message translates to:
  /// **'{difficulty}, seviye {level}'**
  String playLevelLabel(Object difficulty, Object level);

  /// No description provided for @playFinishGroupFirst.
  ///
  /// In tr, this message translates to:
  /// **'Önce {difficulty} seviyelerini bitir'**
  String playFinishGroupFirst(Object difficulty);

  /// No description provided for @playLevelComplete.
  ///
  /// In tr, this message translates to:
  /// **'Harika! Seviye tamamlandı.'**
  String get playLevelComplete;

  /// No description provided for @playLevel.
  ///
  /// In tr, this message translates to:
  /// **'Seviye {level}'**
  String playLevel(Object level);

  /// No description provided for @playLevelLocked.
  ///
  /// In tr, this message translates to:
  /// **'Seviye {level}, kilitli'**
  String playLevelLocked(Object level);

  /// No description provided for @playLevelStars.
  ///
  /// In tr, this message translates to:
  /// **'Seviye {level}, {stars}'**
  String playLevelStars(Object level, Object stars);

  /// No description provided for @playLocked.
  ///
  /// In tr, this message translates to:
  /// **'kilitli'**
  String get playLocked;

  /// No description provided for @gamePathFinderTitle.
  ///
  /// In tr, this message translates to:
  /// **'Robotun Yolunu Bul'**
  String get gamePathFinderTitle;

  /// No description provided for @gamePathFinderDescription.
  ///
  /// In tr, this message translates to:
  /// **'Yön komutlarıyla robotu hedefe ulaştır.'**
  String get gamePathFinderDescription;

  /// No description provided for @gamePathFinderTrophy.
  ///
  /// In tr, this message translates to:
  /// **'Robot Ustası'**
  String get gamePathFinderTrophy;

  /// No description provided for @gamePathFinderTrophyDescription.
  ///
  /// In tr, this message translates to:
  /// **'Robot artık her yolu biliyor!'**
  String get gamePathFinderTrophyDescription;

  /// No description provided for @gameCommandOrderTitle.
  ///
  /// In tr, this message translates to:
  /// **'Komutları Sırala'**
  String get gameCommandOrderTitle;

  /// No description provided for @gameCommandOrderDescription.
  ///
  /// In tr, this message translates to:
  /// **'Adımları doğru sıraya diz.'**
  String get gameCommandOrderDescription;

  /// No description provided for @gameCommandOrderTrophy.
  ///
  /// In tr, this message translates to:
  /// **'Algoritma Ustası'**
  String get gameCommandOrderTrophy;

  /// No description provided for @gameCommandOrderTrophyDescription.
  ///
  /// In tr, this message translates to:
  /// **'Adımları sıralamakta bir numarasın!'**
  String get gameCommandOrderTrophyDescription;

  /// No description provided for @gameIfThenTitle.
  ///
  /// In tr, this message translates to:
  /// **'Eğer Böyleyse'**
  String get gameIfThenTitle;

  /// No description provided for @gameIfThenDescription.
  ///
  /// In tr, this message translates to:
  /// **'Duruma göre doğru komutu seç.'**
  String get gameIfThenDescription;

  /// No description provided for @gameIfThenTrophy.
  ///
  /// In tr, this message translates to:
  /// **'Karar Ustası'**
  String get gameIfThenTrophy;

  /// No description provided for @gameIfThenTrophyDescription.
  ///
  /// In tr, this message translates to:
  /// **'Her durumda doğru kararı veriyorsun!'**
  String get gameIfThenTrophyDescription;

  /// No description provided for @gameRepeatTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Et'**
  String get gameRepeatTitle;

  /// No description provided for @gameRepeatDescription.
  ///
  /// In tr, this message translates to:
  /// **'Tekrarlanan hareketleri tek blokla yap.'**
  String get gameRepeatDescription;

  /// No description provided for @gameRepeatTrophy.
  ///
  /// In tr, this message translates to:
  /// **'Döngü Ustası'**
  String get gameRepeatTrophy;

  /// No description provided for @gameRepeatTrophyDescription.
  ///
  /// In tr, this message translates to:
  /// **'Tekrarları ustaca kullanıyorsun!'**
  String get gameRepeatTrophyDescription;

  /// No description provided for @characterTitle.
  ///
  /// In tr, this message translates to:
  /// **'Karakterini seç'**
  String get characterTitle;

  /// No description provided for @characterName.
  ///
  /// In tr, this message translates to:
  /// **'{id, select, robi{Robi} fiyo{Fiyo} pervane{Pervane} isil{Işıl} kahraman{Kahraman} pembe{Pembe} sovalye{Şövalye} piril{Pırıl} other{Robi}}'**
  String characterName(String id);

  /// No description provided for @achievementsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Başarılarım'**
  String get achievementsTitle;

  /// No description provided for @achievementsSummary.
  ///
  /// In tr, this message translates to:
  /// **'{count} ödül kazandın!'**
  String achievementsSummary(int count);

  /// No description provided for @achievementsBadges.
  ///
  /// In tr, this message translates to:
  /// **'Rozetler'**
  String get achievementsBadges;

  /// No description provided for @achievementsBadgesSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Küçük başarılar'**
  String get achievementsBadgesSubtitle;

  /// No description provided for @achievementsBadgesEarned.
  ///
  /// In tr, this message translates to:
  /// **'Kazandığın rozetler'**
  String get achievementsBadgesEarned;

  /// No description provided for @achievementsBadgesLocked.
  ///
  /// In tr, this message translates to:
  /// **'Kazanılacak rozetler'**
  String get achievementsBadgesLocked;

  /// No description provided for @achievementsBadgesEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Henüz rozetin yok. İlk seviyeni bitir!'**
  String get achievementsBadgesEmpty;

  /// No description provided for @achievementsTrophies.
  ///
  /// In tr, this message translates to:
  /// **'Kupalar'**
  String get achievementsTrophies;

  /// No description provided for @achievementsTrophiesSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Büyük hedefler'**
  String get achievementsTrophiesSubtitle;

  /// No description provided for @achievementsTrophiesEarned.
  ///
  /// In tr, this message translates to:
  /// **'Kazandığın kupalar'**
  String get achievementsTrophiesEarned;

  /// No description provided for @achievementsTrophiesLocked.
  ///
  /// In tr, this message translates to:
  /// **'Kilitli kupalar'**
  String get achievementsTrophiesLocked;

  /// No description provided for @achievementsTrophiesEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Henüz kupan yok. Büyük hedeflere doğru devam!'**
  String get achievementsTrophiesEmpty;

  /// No description provided for @achievementsButtonLabel.
  ///
  /// In tr, this message translates to:
  /// **'Başarılarım: {earned}/{total}'**
  String achievementsButtonLabel(Object earned, Object total);

  /// No description provided for @achievementEarned.
  ///
  /// In tr, this message translates to:
  /// **'Kazanıldı!'**
  String get achievementEarned;

  /// No description provided for @achievementCondition.
  ///
  /// In tr, this message translates to:
  /// **'Nasıl kazanılır? '**
  String get achievementCondition;

  /// No description provided for @achievementCardEarned.
  ///
  /// In tr, this message translates to:
  /// **'{title}, kazanıldı'**
  String achievementCardEarned(Object title);

  /// No description provided for @achievementCardLocked.
  ///
  /// In tr, this message translates to:
  /// **'{title}, kilitli'**
  String achievementCardLocked(Object title);

  /// No description provided for @achievementNewBadge.
  ///
  /// In tr, this message translates to:
  /// **'Yeni rozet!'**
  String get achievementNewBadge;

  /// No description provided for @achievementNewTrophy.
  ///
  /// In tr, this message translates to:
  /// **'Yeni kupa kazandın!'**
  String get achievementNewTrophy;

  /// No description provided for @achievementGreat.
  ///
  /// In tr, this message translates to:
  /// **'Harika!'**
  String get achievementGreat;

  /// No description provided for @achievementFirstGameTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlk Oyunum'**
  String get achievementFirstGameTitle;

  /// No description provided for @achievementFirstGameDescription.
  ///
  /// In tr, this message translates to:
  /// **'Kodlama macerana ilk adımı attın!'**
  String get achievementFirstGameDescription;

  /// No description provided for @achievementFirstGameCondition.
  ///
  /// In tr, this message translates to:
  /// **'İlk oyun seviyeni tamamla.'**
  String get achievementFirstGameCondition;

  /// No description provided for @achievementQuickStartTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hızlı Başlangıç'**
  String get achievementQuickStartTitle;

  /// No description provided for @achievementQuickStartDescription.
  ///
  /// In tr, this message translates to:
  /// **'Robotlar seninle gurur duyuyor!'**
  String get achievementQuickStartDescription;

  /// No description provided for @achievementQuickStartCondition.
  ///
  /// In tr, this message translates to:
  /// **'Bir oyunda {goal} seviye tamamla.'**
  String achievementQuickStartCondition(Object goal);

  /// No description provided for @achievementDeterminedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Azimli Oyuncu'**
  String get achievementDeterminedTitle;

  /// No description provided for @achievementDeterminedDescription.
  ///
  /// In tr, this message translates to:
  /// **'Pes etmeden devam ettin!'**
  String get achievementDeterminedDescription;

  /// No description provided for @achievementDeterminedCondition.
  ///
  /// In tr, this message translates to:
  /// **'Bir oyunda {goal} seviye tamamla.'**
  String achievementDeterminedCondition(Object goal);

  /// No description provided for @achievementMasterCoderTitle.
  ///
  /// In tr, this message translates to:
  /// **'Usta Kodlayıcı'**
  String get achievementMasterCoderTitle;

  /// No description provided for @achievementMasterCoderDescription.
  ///
  /// In tr, this message translates to:
  /// **'Bir oyunun bütün seviyelerini bitirdin!'**
  String get achievementMasterCoderDescription;

  /// No description provided for @achievementMasterCoderCondition.
  ///
  /// In tr, this message translates to:
  /// **'Bir oyunun bütün seviyelerini tamamla.'**
  String get achievementMasterCoderCondition;

  /// No description provided for @achievementAllGamesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Oyun Kaşifi'**
  String get achievementAllGamesTitle;

  /// No description provided for @achievementAllGamesDescription.
  ///
  /// In tr, this message translates to:
  /// **'Bütün oyunları denedin!'**
  String get achievementAllGamesDescription;

  /// No description provided for @achievementAllGamesCondition.
  ///
  /// In tr, this message translates to:
  /// **'Bütün oyunlarda en az bir seviye bitir.'**
  String get achievementAllGamesCondition;

  /// No description provided for @achievementStarHunterTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yıldız Avcısı'**
  String get achievementStarHunterTitle;

  /// No description provided for @achievementStarHunterDescription.
  ///
  /// In tr, this message translates to:
  /// **'Yıldızları toplamaya başladın!'**
  String get achievementStarHunterDescription;

  /// No description provided for @achievementStarHunterCondition.
  ///
  /// In tr, this message translates to:
  /// **'Toplam {goal} yıldız kazan.'**
  String achievementStarHunterCondition(Object goal);

  /// No description provided for @achievementStarMasterTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yıldız Ustası'**
  String get achievementStarMasterTitle;

  /// No description provided for @achievementStarMasterDescription.
  ///
  /// In tr, this message translates to:
  /// **'Gökyüzü kadar yıldızın var!'**
  String get achievementStarMasterDescription;

  /// No description provided for @achievementStarMasterCondition.
  ///
  /// In tr, this message translates to:
  /// **'Toplam {goal} yıldız kazan.'**
  String achievementStarMasterCondition(Object goal);

  /// No description provided for @achievementPerfectTitle.
  ///
  /// In tr, this message translates to:
  /// **'Mükemmel Oyuncu'**
  String get achievementPerfectTitle;

  /// No description provided for @achievementPerfectDescription.
  ///
  /// In tr, this message translates to:
  /// **'Bir seviyeyi kusursuz bitirdin!'**
  String get achievementPerfectDescription;

  /// No description provided for @achievementPerfectCondition.
  ///
  /// In tr, this message translates to:
  /// **'Bir seviyeyi {goal} yıldızla tamamla.'**
  String achievementPerfectCondition(Object goal);

  /// No description provided for @achievementNoHintTitle.
  ///
  /// In tr, this message translates to:
  /// **'İpucusuz Kahraman'**
  String get achievementNoHintTitle;

  /// No description provided for @achievementNoHintDescription.
  ///
  /// In tr, this message translates to:
  /// **'Kendi başına çözmeyi başardın!'**
  String get achievementNoHintDescription;

  /// No description provided for @achievementNoHintCondition.
  ///
  /// In tr, this message translates to:
  /// **'{goal} seviyeyi ipucu kullanmadan tamamla.'**
  String achievementNoHintCondition(Object goal);

  /// No description provided for @achievementBigSuccessTitle.
  ///
  /// In tr, this message translates to:
  /// **'Büyük Başarı'**
  String get achievementBigSuccessTitle;

  /// No description provided for @achievementBigSuccessDescription.
  ///
  /// In tr, this message translates to:
  /// **'Bütün oyunları baştan sona bitirdin!'**
  String get achievementBigSuccessDescription;

  /// No description provided for @achievementBigSuccessCondition.
  ///
  /// In tr, this message translates to:
  /// **'Bütün oyunların tüm seviyelerini tamamla.'**
  String get achievementBigSuccessCondition;

  /// No description provided for @achievementFirstAdventureTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlk Macera Kupası'**
  String get achievementFirstAdventureTitle;

  /// No description provided for @achievementFirstAdventureDescription.
  ///
  /// In tr, this message translates to:
  /// **'Bütün oyunlarda ilk adımı attın!'**
  String get achievementFirstAdventureDescription;

  /// No description provided for @achievementFirstAdventureCondition.
  ///
  /// In tr, this message translates to:
  /// **'Her oyunda ilk seviyeyi tamamla.'**
  String get achievementFirstAdventureCondition;

  /// No description provided for @achievementChampionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kodlama Şampiyonu'**
  String get achievementChampionTitle;

  /// No description provided for @achievementChampionDescription.
  ///
  /// In tr, this message translates to:
  /// **'Sen gerçek bir kodlama şampiyonusun!'**
  String get achievementChampionDescription;

  /// No description provided for @achievementChampionCondition.
  ///
  /// In tr, this message translates to:
  /// **'Bütün oyunların bütün seviyelerini bitir.'**
  String get achievementChampionCondition;

  /// No description provided for @achievementGameTrophyCondition.
  ///
  /// In tr, this message translates to:
  /// **'{game} oyununu bitir.'**
  String achievementGameTrophyCondition(Object game);

  /// No description provided for @parentalGateTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ebeveyn onayı'**
  String get parentalGateTitle;

  /// No description provided for @parentalGateIntro.
  ///
  /// In tr, this message translates to:
  /// **'Bu işlem için bir yetişkinin onayı gerekiyor: {action}.'**
  String parentalGateIntro(Object action);

  /// No description provided for @parentalGateAction.
  ///
  /// In tr, this message translates to:
  /// **'{action, select, purchase{Paket satın alma} other{İşlem}}'**
  String parentalGateAction(String action);

  /// No description provided for @parentalGateAnswerHint.
  ///
  /// In tr, this message translates to:
  /// **'Cevabı rakamlarla yazın.'**
  String get parentalGateAnswerHint;

  /// No description provided for @parentalGateCancel.
  ///
  /// In tr, this message translates to:
  /// **'Vazgeç'**
  String get parentalGateCancel;

  /// No description provided for @parentalGateConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Onayla'**
  String get parentalGateConfirm;

  /// No description provided for @parentalGateAnswer.
  ///
  /// In tr, this message translates to:
  /// **'Cevap'**
  String get parentalGateAnswer;

  /// No description provided for @parentalGateWrongAnswer.
  ///
  /// In tr, this message translates to:
  /// **'Cevap yanlış. Biraz bekleyin, sonra yeni soruyu cevaplayın.'**
  String get parentalGateWrongAnswer;

  /// No description provided for @parentalGateQuestion.
  ///
  /// In tr, this message translates to:
  /// **'{first} çarpı {second} kaç eder?'**
  String parentalGateQuestion(String first, String second);

  /// No description provided for @parentalGateTrialLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ebeveyn doğrulamasını dene'**
  String get parentalGateTrialLabel;

  /// No description provided for @parentalGateTrialHint.
  ///
  /// In tr, this message translates to:
  /// **'Yalnızca test derlemesinde görünür. Gerçek satın alma yapılmaz.'**
  String get parentalGateTrialHint;

  /// No description provided for @parentalGateTrialPassed.
  ///
  /// In tr, this message translates to:
  /// **'Doğrulama geçildi; deneme işlemi çalıştı.'**
  String get parentalGateTrialPassed;

  /// No description provided for @parentalGateTrialBlocked.
  ///
  /// In tr, this message translates to:
  /// **'Doğrulama geçilmedi; işlem çalışmadı.'**
  String get parentalGateTrialBlocked;

  /// No description provided for @storeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Paketler'**
  String get storeTitle;

  /// No description provided for @storeIntro.
  ///
  /// In tr, this message translates to:
  /// **'Satın almalar Google Play üzerinden yapılır ve her satın almadan önce ebeveyn onayı istenir. Google Play promosyon kodunu ödeme ekranındaki \"Kodu kullan\" bağlantısından veya Play Store uygulamasından kullanabilirsiniz; kodla alınan paket de burada sahip olunan olarak görünür.'**
  String get storeIntro;

  /// No description provided for @storePaidSection.
  ///
  /// In tr, this message translates to:
  /// **'Satın alınabilir paketler'**
  String get storePaidSection;

  /// No description provided for @storeFreeSection.
  ///
  /// In tr, this message translates to:
  /// **'Ücretsiz paketler'**
  String get storeFreeSection;

  /// No description provided for @storeNoProducts.
  ///
  /// In tr, this message translates to:
  /// **'Şu an satın alınabilir paket yok.'**
  String get storeNoProducts;

  /// No description provided for @storeBundle.
  ///
  /// In tr, this message translates to:
  /// **'Avantajlı paket'**
  String get storeBundle;

  /// No description provided for @storeOwned.
  ///
  /// In tr, this message translates to:
  /// **'Sahipsiniz'**
  String get storeOwned;

  /// No description provided for @storeUnlocks.
  ///
  /// In tr, this message translates to:
  /// **'Satın alındığında açılanlar:'**
  String get storeUnlocks;

  /// No description provided for @storePriceLoading.
  ///
  /// In tr, this message translates to:
  /// **'Fiyat Google Play\'den alınıyor…'**
  String get storePriceLoading;

  /// No description provided for @storePriceUnavailable.
  ///
  /// In tr, this message translates to:
  /// **'Fiyat Google Play\'den alınamadı.'**
  String get storePriceUnavailable;

  /// No description provided for @storeNotInStore.
  ///
  /// In tr, this message translates to:
  /// **'Bu paket şu an Google Play\'de bulunmuyor.'**
  String get storeNotInStore;

  /// No description provided for @storeRetry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar dene'**
  String get storeRetry;

  /// No description provided for @storePartiallyOwned.
  ///
  /// In tr, this message translates to:
  /// **'Bu paketteki içeriklerin bir kısmına zaten sahipsiniz. Google Play fiyatı sahip olduklarınıza göre düşürmediği için aynı içerik için iki kez ödeme yapmamanız adına bu paket satılmıyor. Eksik paketler: {missing}'**
  String storePartiallyOwned(Object missing);

  /// No description provided for @storeRestore.
  ///
  /// In tr, this message translates to:
  /// **'Satın alımları geri yükle'**
  String get storeRestore;

  /// No description provided for @storeRestoreHint.
  ///
  /// In tr, this message translates to:
  /// **'Google Play hesabınızdaki satın alımları yeniden okur; oyun ilerlemesi silinmez.'**
  String get storeRestoreHint;

  /// No description provided for @storeRestored.
  ///
  /// In tr, this message translates to:
  /// **'Satın alımlar Google Play\'den yeniden okundu. Sahip olunan ürün: {count}.'**
  String storeRestored(Object count);

  /// No description provided for @storeRestoreOffline.
  ///
  /// In tr, this message translates to:
  /// **'İnternet bağlantısı yok; cihazdaki satın alma kayıtları geçerli kalır.'**
  String get storeRestoreOffline;

  /// No description provided for @storeRestoreUnavailable.
  ///
  /// In tr, this message translates to:
  /// **'Google Play\'e bağlanılamadı; cihazdaki satın alma kayıtları geçerli kalır.'**
  String get storeRestoreUnavailable;

  /// No description provided for @storeBuy.
  ///
  /// In tr, this message translates to:
  /// **'Satın al – {price}'**
  String storeBuy(Object price);

  /// No description provided for @storeLevels.
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, other{{count} seviye}}'**
  String storeLevels(int count);

  /// No description provided for @storePackLine.
  ///
  /// In tr, this message translates to:
  /// **'{game} – {pack} ({levels})'**
  String storePackLine(Object game, Object pack, Object levels);

  /// No description provided for @storePurchased.
  ///
  /// In tr, this message translates to:
  /// **'Satın alma tamamlandı; paket açıldı.'**
  String get storePurchased;

  /// No description provided for @storePending.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme beklemede. Ödeme tamamlanınca paket kendiliğinden açılır.'**
  String get storePending;

  /// No description provided for @storeCancelled.
  ///
  /// In tr, this message translates to:
  /// **'Satın alma iptal edildi.'**
  String get storeCancelled;

  /// No description provided for @storeAlreadyOwned.
  ///
  /// In tr, this message translates to:
  /// **'Bu pakete zaten sahipsiniz; yeniden satın alınmadı.'**
  String get storeAlreadyOwned;

  /// No description provided for @storeOffline.
  ///
  /// In tr, this message translates to:
  /// **'İnternet bağlantısı yok. Bağlantıyı kontrol edip tekrar deneyin.'**
  String get storeOffline;

  /// No description provided for @storeUnavailable.
  ///
  /// In tr, this message translates to:
  /// **'Google Play\'e bağlanılamadı. Daha sonra tekrar deneyin.'**
  String get storeUnavailable;

  /// No description provided for @storeFailed.
  ///
  /// In tr, this message translates to:
  /// **'Satın alma tamamlanamadı.'**
  String get storeFailed;

  /// No description provided for @storeNotApproved.
  ///
  /// In tr, this message translates to:
  /// **'Ebeveyn onayı verilmedi; satın alma başlatılmadı.'**
  String get storeNotApproved;

  /// No description provided for @gameRobotRunning.
  ///
  /// In tr, this message translates to:
  /// **'Robot yola çıktı...'**
  String get gameRobotRunning;

  /// No description provided for @gameRobotReachedFlag.
  ///
  /// In tr, this message translates to:
  /// **'Harika! Robot bayrağa ulaştı!'**
  String get gameRobotReachedFlag;

  /// No description provided for @gameMissingCoins.
  ///
  /// In tr, this message translates to:
  /// **'Bayrağa ulaştın ama bütün altınları toplamadın. Önce altınları topla.'**
  String get gameMissingCoins;

  /// No description provided for @gameDirection.
  ///
  /// In tr, this message translates to:
  /// **'{direction, select, up{Yukarı} down{Aşağı} left{Sola} other{Sağa}}'**
  String gameDirection(String direction);

  /// No description provided for @gameObstacle.
  ///
  /// In tr, this message translates to:
  /// **'{obstacle, select, rock{taşa} water{suya} other{harita kenarına}}'**
  String gameObstacle(String obstacle);

  /// No description provided for @pathFinderIntro.
  ///
  /// In tr, this message translates to:
  /// **'Robotu bayrağa ulaştırmak için komutları sırayla seç.'**
  String get pathFinderIntro;

  /// No description provided for @pathFinderCoinIntro.
  ///
  /// In tr, this message translates to:
  /// **'Önce bütün altınları topla, sonra bayrağa git.'**
  String get pathFinderCoinIntro;

  /// No description provided for @pathFinderEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Önce bir yön komutu ekle.'**
  String get pathFinderEmpty;

  /// No description provided for @pathFinderFull.
  ///
  /// In tr, this message translates to:
  /// **'Komut sınırına ulaştın. Bir komutu silip yerine başkasını koyabilirsin.'**
  String get pathFinderFull;

  /// No description provided for @pathFinderMissedGoal.
  ///
  /// In tr, this message translates to:
  /// **'Robot bayrağa ulaşamadı. Komut eklemeyi ya da değiştirmeyi dene.'**
  String get pathFinderMissedGoal;

  /// No description provided for @pathFinderTooMany.
  ///
  /// In tr, this message translates to:
  /// **'Bu komutlarla sınır içinde bitiremezsin. Gereksiz adımları silmeyi dene.'**
  String get pathFinderTooMany;

  /// No description provided for @pathFinderSolved.
  ///
  /// In tr, this message translates to:
  /// **'Komutların doğru! Yeşil Başlat tuşuna dokun.'**
  String get pathFinderSolved;

  /// No description provided for @pathFinderEmptyStrip.
  ///
  /// In tr, this message translates to:
  /// **'Yön tuşlarına bas, komutların burada sıralansın.'**
  String get pathFinderEmptyStrip;

  /// No description provided for @pathFinderMoveLeft.
  ///
  /// In tr, this message translates to:
  /// **'Seçili komutu bir sola taşı'**
  String get pathFinderMoveLeft;

  /// No description provided for @pathFinderMoveRight.
  ///
  /// In tr, this message translates to:
  /// **'Seçili komutu bir sağa taşı'**
  String get pathFinderMoveRight;

  /// No description provided for @pathFinderBlocked.
  ///
  /// In tr, this message translates to:
  /// **'Robot {obstacle} çarptı. {number}. komutu değiştirmeyi dene.'**
  String pathFinderBlocked(Object obstacle, Object number);

  /// No description provided for @pathFinderFixCommand.
  ///
  /// In tr, this message translates to:
  /// **'{number}. komut robotu yoldan çıkarıyor. Onu senin için seçtim; silebilir ya da yerini değiştirebilirsin.'**
  String pathFinderFixCommand(Object number);

  /// No description provided for @pathFinderNextMove.
  ///
  /// In tr, this message translates to:
  /// **'Parlayan kareye bak. Sıradaki komut: {direction}.'**
  String pathFinderNextMove(Object direction);

  /// No description provided for @pathFinderAddCommand.
  ///
  /// In tr, this message translates to:
  /// **'{direction} komutu ekle'**
  String pathFinderAddCommand(Object direction);

  /// No description provided for @pathFinderCommandChip.
  ///
  /// In tr, this message translates to:
  /// **'{number}. komut: {direction}'**
  String pathFinderCommandChip(Object number, Object direction);

  /// No description provided for @commandOrderIntro.
  ///
  /// In tr, this message translates to:
  /// **'Görevi bitirmek için kartları doğru sıraya diz. Bir karta dokun ya da onu bir kutuya sürükle.'**
  String get commandOrderIntro;

  /// No description provided for @commandOrderExtrasIntro.
  ///
  /// In tr, this message translates to:
  /// **'Dikkat! Bazı kartlar bu göreve ait değil. Yalnızca gereken kartları sıraya diz.'**
  String get commandOrderExtrasIntro;

  /// No description provided for @commandOrderFull.
  ///
  /// In tr, this message translates to:
  /// **'Bütün kutular dolu. Bir kartı geri almak için ona dokun.'**
  String get commandOrderFull;

  /// No description provided for @commandOrderNotFull.
  ///
  /// In tr, this message translates to:
  /// **'Önce bütün kutuları doldur.'**
  String get commandOrderNotFull;

  /// No description provided for @commandOrderSuccess.
  ///
  /// In tr, this message translates to:
  /// **'Harika! Bütün adımlar doğru sırada.'**
  String get commandOrderSuccess;

  /// No description provided for @commandOrderSolved.
  ///
  /// In tr, this message translates to:
  /// **'Sıralama doğru! Yeşil Kontrol et tuşuna dokun.'**
  String get commandOrderSolved;

  /// No description provided for @commandOrderPoolEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Bütün kartlar yerleşti'**
  String get commandOrderPoolEmpty;

  /// No description provided for @commandOrderCheck.
  ///
  /// In tr, this message translates to:
  /// **'Kontrol et'**
  String get commandOrderCheck;

  /// No description provided for @commandOrderWrongExtra.
  ///
  /// In tr, this message translates to:
  /// **'\"{card}\" bu görev için gerekli değil. Onu kutudan çıkar.'**
  String commandOrderWrongExtra(Object card);

  /// No description provided for @commandOrderWrongTooEarly.
  ///
  /// In tr, this message translates to:
  /// **'{number}. kutudaki \"{card}\" için henüz erken. Ondan önce yapılması gereken bir adım var.'**
  String commandOrderWrongTooEarly(Object number, Object card);

  /// No description provided for @commandOrderHint.
  ///
  /// In tr, this message translates to:
  /// **'{levelHint} Parlayan kart \"{card}\" {number}. kutuya gelmeli.'**
  String commandOrderHint(Object levelHint, Object card, Object number);

  /// No description provided for @commandOrderSlotCard.
  ///
  /// In tr, this message translates to:
  /// **'{number}. kutu: {card}. Geri almak için dokun.'**
  String commandOrderSlotCard(Object number, Object card);

  /// No description provided for @commandOrderEmptySlot.
  ///
  /// In tr, this message translates to:
  /// **'{number}. kutu, boş. Kartın buraya gelmesi için dokun.'**
  String commandOrderEmptySlot(Object number);

  /// No description provided for @ifThenIncomplete.
  ///
  /// In tr, this message translates to:
  /// **'Önce boş kutuları doldur.'**
  String get ifThenIncomplete;

  /// No description provided for @ifThenSuccess.
  ///
  /// In tr, this message translates to:
  /// **'Harika! Robot kurallarını izleyip bayrağa ulaştı!'**
  String get ifThenSuccess;

  /// No description provided for @ifThenSolved.
  ///
  /// In tr, this message translates to:
  /// **'Kuralların doğru! Yeşil Başlat tuşuna dokun.'**
  String get ifThenSolved;

  /// No description provided for @ifThenNoSlot.
  ///
  /// In tr, this message translates to:
  /// **'Bu blok için boş kutu yok. Değiştirmek istediğin kutuya dokunup onu boşalt.'**
  String get ifThenNoSlot;

  /// No description provided for @ifThenLockedSlot.
  ///
  /// In tr, this message translates to:
  /// **'Bu kutu hazır geldi, değiştirilemez. Bloğu boş bir kutuya koy.'**
  String get ifThenLockedSlot;

  /// No description provided for @ifThenWrongType.
  ///
  /// In tr, this message translates to:
  /// **'Bu blok oraya uymaz. Nesneler \"Eğer\" kutusuna, hareketler ok işaretinin yanına gider.'**
  String get ifThenWrongType;

  /// No description provided for @ifThenLane.
  ///
  /// In tr, this message translates to:
  /// **'Robotun yolu'**
  String get ifThenLane;

  /// No description provided for @ifThenObjects.
  ///
  /// In tr, this message translates to:
  /// **'Nesneler'**
  String get ifThenObjects;

  /// No description provided for @ifThenActions.
  ///
  /// In tr, this message translates to:
  /// **'Hareketler'**
  String get ifThenActions;

  /// No description provided for @ifThenIf.
  ///
  /// In tr, this message translates to:
  /// **'Eğer'**
  String get ifThenIf;

  /// No description provided for @ifThenElseIf.
  ///
  /// In tr, this message translates to:
  /// **'Değilse eğer'**
  String get ifThenElseIf;

  /// No description provided for @ifThenElse.
  ///
  /// In tr, this message translates to:
  /// **'Değilse'**
  String get ifThenElse;

  /// No description provided for @ifThenThen.
  ///
  /// In tr, this message translates to:
  /// **'varsa'**
  String get ifThenThen;

  /// No description provided for @ifThenObjectLabel.
  ///
  /// In tr, this message translates to:
  /// **'{object, select, empty{Boş yol} rock{Taş} water{Su} door{Kapı} other{Yıldız}}'**
  String ifThenObjectLabel(String object);

  /// No description provided for @ifThenActionLabel.
  ///
  /// In tr, this message translates to:
  /// **'{action, select, forward{İleri Git} jump{Zıpla} bridge{Köprü Kur} open{Kapıyı Aç} other{Topla}}'**
  String ifThenActionLabel(String action);

  /// No description provided for @ifThenObjectName.
  ///
  /// In tr, this message translates to:
  /// **'{object, select, empty{boş yol} rock{taş} water{su} door{kapı} other{yıldız}}'**
  String ifThenObjectName(String object);

  /// No description provided for @ifThenProblem.
  ///
  /// In tr, this message translates to:
  /// **'{object, select, empty{Boş yolda buna gerek yok.} rock{Taşın içinden geçilemez.} water{Robot yüzemez!} door{Kapı kapalıyken geçilemez.} other{Yıldız yerde kaldı.}}'**
  String ifThenProblem(String object);

  /// No description provided for @ifThenAdvice.
  ///
  /// In tr, this message translates to:
  /// **'{object, select, empty{Yol boşsa robot ileri gidebilir.} rock{Taşın üstünden zıplayarak geçilir.} water{Suyun üstünden geçmek için köprü kurmak gerekir.} door{Kapıdan geçmek için önce kapıyı açmalısın.} other{Yıldızı almak için Topla bloğunu kullan.}}'**
  String ifThenAdvice(String object);

  /// No description provided for @ifThenRuleNumber.
  ///
  /// In tr, this message translates to:
  /// **'{number}. kural'**
  String ifThenRuleNumber(Object number);

  /// No description provided for @ifThenElseRule.
  ///
  /// In tr, this message translates to:
  /// **'\"Değilse\" satırı'**
  String get ifThenElseRule;

  /// No description provided for @ifThenWrong.
  ///
  /// In tr, this message translates to:
  /// **'Önünde {object} vardı. {rule} çalıştı ve robot \"{action}\" yaptı. {problem} Kuralları değiştirip yeniden dene.'**
  String ifThenWrong(Object object, Object rule, Object action, Object problem);

  /// No description provided for @ifThenHint.
  ///
  /// In tr, this message translates to:
  /// **'Parlayan karede {object} var. {advice}'**
  String ifThenHint(Object object, Object advice);

  /// No description provided for @ifThenSlot.
  ///
  /// In tr, this message translates to:
  /// **'{kind, select, condition{Koşul} other{Hareket}} kutusu: {value}'**
  String ifThenSlot(String kind, Object value);

  /// No description provided for @ifThenSlotEmpty.
  ///
  /// In tr, this message translates to:
  /// **'boş'**
  String get ifThenSlotEmpty;

  /// No description provided for @ifThenSlotReady.
  ///
  /// In tr, this message translates to:
  /// **'{label}, hazır'**
  String ifThenSlotReady(Object label);

  /// No description provided for @ifThenPaletteBlock.
  ///
  /// In tr, this message translates to:
  /// **'{kind, select, action{Hareket} other{Nesne}}: {label}'**
  String ifThenPaletteBlock(String kind, Object label);

  /// No description provided for @repeatIntro.
  ///
  /// In tr, this message translates to:
  /// **'Robotu bayrağa götür. Aynı hareketi tekrar tekrar eklemek yerine Tekrarla bloğunu kullan.'**
  String get repeatIntro;

  /// No description provided for @repeatCoinIntro.
  ///
  /// In tr, this message translates to:
  /// **'Önce bütün altınları topla, sonra bayrağa git. Tekrarla bloğu işini kolaylaştırır.'**
  String get repeatCoinIntro;

  /// No description provided for @repeatEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Önce bir ok ya da Tekrarla bloğu ekle.'**
  String get repeatEmpty;

  /// No description provided for @repeatFull.
  ///
  /// In tr, this message translates to:
  /// **'Blok sınırına ulaştın. Hazırsan yeşil Başlat tuşuna dokun; değiştirmek istersen bir bloğu seçip sil.'**
  String get repeatFull;

  /// No description provided for @repeatInsideRepeat.
  ///
  /// In tr, this message translates to:
  /// **'Şimdi eklediğin oklar turuncu bloğun içine girecek. Bitince lacivert Bloktan çık düğmesine dokun.'**
  String get repeatInsideRepeat;

  /// No description provided for @repeatEmptyStrip.
  ///
  /// In tr, this message translates to:
  /// **'Ok ya da Tekrarla bloğu ekle, bloklar burada sıralansın.'**
  String get repeatEmptyStrip;

  /// No description provided for @repeatOutsideRepeat.
  ///
  /// In tr, this message translates to:
  /// **'Şimdi eklediğin oklar bloğun dışına, sona eklenecek.'**
  String get repeatOutsideRepeat;

  /// No description provided for @repeatMovedOut.
  ///
  /// In tr, this message translates to:
  /// **'Ok bloğun dışına çıktı. Şimdi eklediğin oklar da dışarıya, sona eklenecek.'**
  String get repeatMovedOut;

  /// No description provided for @repeatEmptyRepeat.
  ///
  /// In tr, this message translates to:
  /// **'Turuncu bloğun içi boş. Onu seçtim; şimdi içine bir ok ekle.'**
  String get repeatEmptyRepeat;

  /// No description provided for @repeatMissedGoal.
  ///
  /// In tr, this message translates to:
  /// **'Robot bayrağa ulaşamadı. Tekrar sayısını ya da okları değiştirmeyi dene.'**
  String get repeatMissedGoal;

  /// No description provided for @repeatSolved.
  ///
  /// In tr, this message translates to:
  /// **'Blokların doğru! Yeşil Başlat tuşuna dokun.'**
  String get repeatSolved;

  /// No description provided for @repeatFullHint.
  ///
  /// In tr, this message translates to:
  /// **'Blok sınırın doldu. Bir tekrar sayısını değiştirmeyi ya da bir bloğu silip yerine Tekrarla bloğu koymayı dene.'**
  String get repeatFullHint;

  /// No description provided for @repeatAddRepeat.
  ///
  /// In tr, this message translates to:
  /// **'Tekrarla'**
  String get repeatAddRepeat;

  /// No description provided for @repeatLeaveRepeat.
  ///
  /// In tr, this message translates to:
  /// **'Bloktan çık ✓'**
  String get repeatLeaveRepeat;

  /// No description provided for @repeatAddRepeatLabel.
  ///
  /// In tr, this message translates to:
  /// **'Tekrarla bloğu ekle'**
  String get repeatAddRepeatLabel;

  /// No description provided for @repeatLeaveRepeatLabel.
  ///
  /// In tr, this message translates to:
  /// **'Bloktan çık; sonraki oklar dışarıya eklensin'**
  String get repeatLeaveRepeatLabel;

  /// No description provided for @repeatDropHere.
  ///
  /// In tr, this message translates to:
  /// **'Okları buraya ekle'**
  String get repeatDropHere;

  /// No description provided for @repeatEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'Boş'**
  String get repeatEmptyBody;

  /// No description provided for @repeatDecrease.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar sayısını azalt'**
  String get repeatDecrease;

  /// No description provided for @repeatIncrease.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar sayısını artır'**
  String get repeatIncrease;

  /// No description provided for @repeatDeleteLabel.
  ///
  /// In tr, this message translates to:
  /// **'Seçili bloğu sil'**
  String get repeatDeleteLabel;

  /// No description provided for @repeatMoveOutLabel.
  ///
  /// In tr, this message translates to:
  /// **'Seçili oku turuncu bloğun dışına taşı'**
  String get repeatMoveOutLabel;

  /// No description provided for @repeatTimes.
  ///
  /// In tr, this message translates to:
  /// **'{times, plural, other{{times} kez}}'**
  String repeatTimes(int times);

  /// No description provided for @repeatTimesFull.
  ///
  /// In tr, this message translates to:
  /// **'{times, plural, other{{times} kez tekrarla}}'**
  String repeatTimesFull(int times);

  /// No description provided for @repeatAddMove.
  ///
  /// In tr, this message translates to:
  /// **'{direction} oku ekle'**
  String repeatAddMove(Object direction);

  /// No description provided for @repeatArrowName.
  ///
  /// In tr, this message translates to:
  /// **'{number}. ok'**
  String repeatArrowName(Object number);

  /// No description provided for @repeatBlockName.
  ///
  /// In tr, this message translates to:
  /// **'{number}. blok'**
  String repeatBlockName(Object number);

  /// No description provided for @repeatInnerArrowName.
  ///
  /// In tr, this message translates to:
  /// **'{block}. bloğun içindeki {arrow}. ok'**
  String repeatInnerArrowName(Object block, Object arrow);

  /// No description provided for @repeatMoveChip.
  ///
  /// In tr, this message translates to:
  /// **'{name}: {direction}'**
  String repeatMoveChip(Object name, Object direction);

  /// No description provided for @repeatBlockLabel.
  ///
  /// In tr, this message translates to:
  /// **'{number}. blok: {times, plural, other{{times} kez tekrarla}}. İçine ok eklemek için dokun.'**
  String repeatBlockLabel(Object number, int times);

  /// No description provided for @repeatFixCount.
  ///
  /// In tr, this message translates to:
  /// **'{number}. bloğun tekrar sayısını ya da içindeki okları değiştirmeyi dene.'**
  String repeatFixCount(Object number);

  /// No description provided for @repeatOffPath.
  ///
  /// In tr, this message translates to:
  /// **'{place} robotu yoldan çıkarıyor.'**
  String repeatOffPath(Object place);

  /// No description provided for @repeatBlocked.
  ///
  /// In tr, this message translates to:
  /// **'Robot {obstacle} çarptı. {advice}'**
  String repeatBlocked(Object obstacle, Object advice);

  /// No description provided for @repeatBlockedInRound.
  ///
  /// In tr, this message translates to:
  /// **'Robot {round}. turda {obstacle} çarptı. {advice}'**
  String repeatBlockedInRound(Object round, Object obstacle, Object advice);

  /// No description provided for @repeatFixHint.
  ///
  /// In tr, this message translates to:
  /// **'{advice} Yanlış yeri senin için kırmızıyla gösterdim.'**
  String repeatFixHint(Object advice);

  /// No description provided for @repeatNextMoveHint.
  ///
  /// In tr, this message translates to:
  /// **'{levelHint} Parlayan kareye bak; robot oraya {direction} gitmeli.'**
  String repeatNextMoveHint(Object levelHint, Object direction);

  /// No description provided for @repeatL1Intro.
  ///
  /// In tr, this message translates to:
  /// **'Robot 3 kez sağa gitmeli ama yalnızca 2 blok kullanabilirsin. Tekrarla bloğunu ekle, içine sağ oku koy.'**
  String get repeatL1Intro;

  /// No description provided for @repeatL1Hint.
  ///
  /// In tr, this message translates to:
  /// **'Tekrarla bloğu, içindeki oku söylediğin kadar yapar. Kaç kez sağa gitmeli?'**
  String get repeatL1Hint;

  /// No description provided for @repeatL2Intro.
  ///
  /// In tr, this message translates to:
  /// **'Bayrak yukarıda. Aynı oku tekrar tekrar eklemek yerine Tekrarla bloğunu kullan.'**
  String get repeatL2Intro;

  /// No description provided for @repeatL2Hint.
  ///
  /// In tr, this message translates to:
  /// **'Robot hep aynı yöne gidiyor. Hangi yöne ve kaç kez?'**
  String get repeatL2Hint;

  /// No description provided for @repeatL3Hint.
  ///
  /// In tr, this message translates to:
  /// **'Robot aşağı iniyor. Kareleri say ve tekrar sayısını ayarla.'**
  String get repeatL3Hint;

  /// No description provided for @repeatL4Hint.
  ///
  /// In tr, this message translates to:
  /// **'Bu kez sola. Tekrar sayısını − ve + düğmeleriyle değiştirebilirsin.'**
  String get repeatL4Hint;

  /// No description provided for @repeatL5Intro.
  ///
  /// In tr, this message translates to:
  /// **'Yoldaki altınları da topla! Yine yalnızca 2 blok var.'**
  String get repeatL5Intro;

  /// No description provided for @repeatL5Hint.
  ///
  /// In tr, this message translates to:
  /// **'Altınlar robotla bayrak arasında, aynı sırada. Robot yalnızca sağa gidiyor.'**
  String get repeatL5Hint;

  /// No description provided for @repeatL6Intro.
  ///
  /// In tr, this message translates to:
  /// **'Merdiven gibi in: sağa, aşağı, sağa, aşağı... Tekrarla bloğunun içine iki ok koyabilirsin.'**
  String get repeatL6Intro;

  /// No description provided for @repeatL6Hint.
  ///
  /// In tr, this message translates to:
  /// **'Bir basamak: bir sağa, bir aşağı. Kaç basamak var?'**
  String get repeatL6Hint;

  /// No description provided for @repeatL7Hint.
  ///
  /// In tr, this message translates to:
  /// **'İki kez sağa, bir kez yukarı. Bu desen kaç kez tekrar ediyor?'**
  String get repeatL7Hint;

  /// No description provided for @repeatL8Hint.
  ///
  /// In tr, this message translates to:
  /// **'Önce iki sağa, sonra bir aşağı. Bunu tekrar et.'**
  String get repeatL8Hint;

  /// No description provided for @repeatL9Intro.
  ///
  /// In tr, this message translates to:
  /// **'Tekrarla bloğundan sonra tek bir ok da ekleyebilirsin.'**
  String get repeatL9Intro;

  /// No description provided for @repeatL9Hint.
  ///
  /// In tr, this message translates to:
  /// **'Yukarı-sol desenini tekrarla; sonunda bir adım daha gerekebilir.'**
  String get repeatL9Hint;

  /// No description provided for @repeatL10Hint.
  ///
  /// In tr, this message translates to:
  /// **'Her basamak iki kare geniş, bir kare yüksek.'**
  String get repeatL10Hint;

  /// No description provided for @repeatL11Intro.
  ///
  /// In tr, this message translates to:
  /// **'Bu kez iki Tekrarla bloğu gerekiyor: biri sağa, biri aşağı.'**
  String get repeatL11Intro;

  /// No description provided for @repeatL11Hint.
  ///
  /// In tr, this message translates to:
  /// **'Önce sağa kaç kare? Sonra aşağı kaç kare? Her biri için ayrı bir Tekrarla bloğu kullan.'**
  String get repeatL11Hint;

  /// No description provided for @repeatL12Hint.
  ///
  /// In tr, this message translates to:
  /// **'Önce yukarı çık, sonra sağa git. İki Tekrarla bloğu, iki farklı sayı.'**
  String get repeatL12Hint;

  /// No description provided for @repeatL13Hint.
  ///
  /// In tr, this message translates to:
  /// **'Taşların etrafından dolaş: sağa, aşağı, sola. Her yön için kareleri say.'**
  String get repeatL13Hint;

  /// No description provided for @repeatL14Hint.
  ///
  /// In tr, this message translates to:
  /// **'Yol üç parça: sağa, aşağı, yine sağa.'**
  String get repeatL14Hint;

  /// No description provided for @repeatL15Hint.
  ///
  /// In tr, this message translates to:
  /// **'İki altın da yolun köşelerinde. Her düz parçayı bir Tekrarla bloğuyla yap.'**
  String get repeatL15Hint;

  /// No description provided for @repeatL16Intro.
  ///
  /// In tr, this message translates to:
  /// **'Yalnızca 4 blok! Uzun yolu kısa bir desenle yürü.'**
  String get repeatL16Intro;

  /// No description provided for @repeatL16Hint.
  ///
  /// In tr, this message translates to:
  /// **'Altınlar çapraz dizilmiş: sağa-aşağı desenine bak.'**
  String get repeatL16Hint;

  /// No description provided for @repeatL17Hint.
  ///
  /// In tr, this message translates to:
  /// **'Her basamak iki kare yüksek, iki kare geniş.'**
  String get repeatL17Hint;

  /// No description provided for @repeatL18Hint.
  ///
  /// In tr, this message translates to:
  /// **'İki sağa, iki aşağı. Bu desen bayrağa kadar sürüyor.'**
  String get repeatL18Hint;

  /// No description provided for @repeatL19Hint.
  ///
  /// In tr, this message translates to:
  /// **'Altınlar basamakların köşesinde. Bir basamak: iki sağa, bir aşağı.'**
  String get repeatL19Hint;

  /// No description provided for @repeatL20Intro.
  ///
  /// In tr, this message translates to:
  /// **'Yılan gibi kıvrılan uzun bir yol. 10 bloğu akıllıca kullan.'**
  String get repeatL20Intro;

  /// No description provided for @repeatL20Hint.
  ///
  /// In tr, this message translates to:
  /// **'Yol beş düz parçadan oluşuyor. Her parçayı bir Tekrarla bloğuyla yap.'**
  String get repeatL20Hint;

  /// No description provided for @ifThenL1Intro.
  ///
  /// In tr, this message translates to:
  /// **'Önünde taş varsa robot ne yapmalı? Boş kutuya bir hareket koy.'**
  String get ifThenL1Intro;

  /// No description provided for @ifThenL2Intro.
  ///
  /// In tr, this message translates to:
  /// **'Robot yüzemez. Önünde su varsa ne yapmalı?'**
  String get ifThenL2Intro;

  /// No description provided for @ifThenL3Intro.
  ///
  /// In tr, this message translates to:
  /// **'Yolda kapalı bir kapı var. Kapının önüne gelince ne yapmalı?'**
  String get ifThenL3Intro;

  /// No description provided for @ifThenL4Intro.
  ///
  /// In tr, this message translates to:
  /// **'Yıldızları toplamadan geçme! Önünde yıldız varsa ne yapmalı?'**
  String get ifThenL4Intro;

  /// No description provided for @ifThenL5Intro.
  ///
  /// In tr, this message translates to:
  /// **'Bu kez koşulu da sen seç. Yolda ne var?'**
  String get ifThenL5Intro;

  /// No description provided for @ifThenL6Intro.
  ///
  /// In tr, this message translates to:
  /// **'Taş varsa bir şey, yoksa başka bir şey yapmalı. İki kutuyu da doldur.'**
  String get ifThenL6Intro;

  /// No description provided for @ifThenL7Intro.
  ///
  /// In tr, this message translates to:
  /// **'Su varsa ne yapmalı? Su yoksa ne yapmalı?'**
  String get ifThenL7Intro;

  /// No description provided for @ifThenL8Intro.
  ///
  /// In tr, this message translates to:
  /// **'Bu yolda boş kare yok! Kapı yoksa önünde ne var?'**
  String get ifThenL8Intro;

  /// No description provided for @ifThenL9Intro.
  ///
  /// In tr, this message translates to:
  /// **'Koşulu ve iki hareketi sen seç.'**
  String get ifThenL9Intro;

  /// No description provided for @ifThenL10Intro.
  ///
  /// In tr, this message translates to:
  /// **'Yolda taş ve su var. Bir kural ve bir \"değilse\" yeter.'**
  String get ifThenL10Intro;

  /// No description provided for @ifThenL11Intro.
  ///
  /// In tr, this message translates to:
  /// **'Taş da var su da. Her biri için bir kural kur.'**
  String get ifThenL11Intro;

  /// No description provided for @ifThenL12Intro.
  ///
  /// In tr, this message translates to:
  /// **'Kapıları aç, yıldızları topla.'**
  String get ifThenL12Intro;

  /// No description provided for @ifThenL13Intro.
  ///
  /// In tr, this message translates to:
  /// **'Üç farklı şey var ama iki kural satırı. Üçüncüsü için \"değilse\" kullan.'**
  String get ifThenL13Intro;

  /// No description provided for @ifThenL14Intro.
  ///
  /// In tr, this message translates to:
  /// **'Su, kapı ve boş yol. Hangisini \"değilse\"ye bırakırsın?'**
  String get ifThenL14Intro;

  /// No description provided for @ifThenL15Intro.
  ///
  /// In tr, this message translates to:
  /// **'Dikkat: bloklardan biri bu yolda hiç yok.'**
  String get ifThenL15Intro;

  /// No description provided for @ifThenL16Intro.
  ///
  /// In tr, this message translates to:
  /// **'Robot kaleye gidiyor: taşlar, hendekler ve kale kapıları var.'**
  String get ifThenL16Intro;

  /// No description provided for @ifThenL17Intro.
  ///
  /// In tr, this message translates to:
  /// **'Hazine yolu: yıldızları topla, engelleri aş.'**
  String get ifThenL17Intro;

  /// No description provided for @ifThenL18Intro.
  ///
  /// In tr, this message translates to:
  /// **'Bu yolda hiç boş kare yok. Dört şey için dört karar gerek.'**
  String get ifThenL18Intro;

  /// No description provided for @ifThenL19Intro.
  ///
  /// In tr, this message translates to:
  /// **'Uzun bir yolculuk! Su, taş, kapı ve boş yol.'**
  String get ifThenL19Intro;

  /// No description provided for @ifThenL20Intro.
  ///
  /// In tr, this message translates to:
  /// **'Son görev: bütün yıldızları toplayıp bayrağa ulaş.'**
  String get ifThenL20Intro;

  /// No description provided for @pathFinderL1Intro.
  ///
  /// In tr, this message translates to:
  /// **'Robotu bayrağa götür. Sağa okuna bas, sonra yeşil Başlat tuşuna dokun.'**
  String get pathFinderL1Intro;

  /// No description provided for @pathFinderL2Intro.
  ///
  /// In tr, this message translates to:
  /// **'Bayrak robotun yukarısında. Hangi oku seçmelisin?'**
  String get pathFinderL2Intro;

  /// No description provided for @pathFinderL3Intro.
  ///
  /// In tr, this message translates to:
  /// **'Bayrak solda ve iki kare uzakta.'**
  String get pathFinderL3Intro;

  /// No description provided for @pathFinderL4Intro.
  ///
  /// In tr, this message translates to:
  /// **'Robot aşağı inmeli. Kaç kez?'**
  String get pathFinderL4Intro;

  /// No description provided for @pathFinderL5Intro.
  ///
  /// In tr, this message translates to:
  /// **'Bu kez iki farklı yön kullanacaksın.'**
  String get pathFinderL5Intro;

  /// No description provided for @pathFinderL11Intro.
  ///
  /// In tr, this message translates to:
  /// **'Yolda taş var. Taşın etrafından dolaş.'**
  String get pathFinderL11Intro;

  /// No description provided for @pathFinderL12Intro.
  ///
  /// In tr, this message translates to:
  /// **'Taşlar duvar gibi dizilmiş. Altından dolaş.'**
  String get pathFinderL12Intro;

  /// No description provided for @pathFinderL13Intro.
  ///
  /// In tr, this message translates to:
  /// **'Robot suya giremez. Kuru yolu bul.'**
  String get pathFinderL13Intro;

  /// No description provided for @pathFinderL15Intro.
  ///
  /// In tr, this message translates to:
  /// **'Birden çok yol var. En kısasını bulabilir misin?'**
  String get pathFinderL15Intro;

  /// No description provided for @commandOrderL1Title.
  ///
  /// In tr, this message translates to:
  /// **'Çiçeği sula'**
  String get commandOrderL1Title;

  /// No description provided for @commandOrderL1Step1.
  ///
  /// In tr, this message translates to:
  /// **'Sulama kabını doldur'**
  String get commandOrderL1Step1;

  /// No description provided for @commandOrderL1Step2.
  ///
  /// In tr, this message translates to:
  /// **'Çiçeği sula'**
  String get commandOrderL1Step2;

  /// No description provided for @commandOrderL1Hint.
  ///
  /// In tr, this message translates to:
  /// **'Çiçeği sulamak için önce kabın içinde su olmalı.'**
  String get commandOrderL1Hint;

  /// No description provided for @commandOrderL2Title.
  ///
  /// In tr, this message translates to:
  /// **'Dişlerini fırçala'**
  String get commandOrderL2Title;

  /// No description provided for @commandOrderL2Step1.
  ///
  /// In tr, this message translates to:
  /// **'Fırçaya macun sık'**
  String get commandOrderL2Step1;

  /// No description provided for @commandOrderL2Step2.
  ///
  /// In tr, this message translates to:
  /// **'Dişlerini fırçala'**
  String get commandOrderL2Step2;

  /// No description provided for @commandOrderL2Step3.
  ///
  /// In tr, this message translates to:
  /// **'Ağzını çalkala'**
  String get commandOrderL2Step3;

  /// No description provided for @commandOrderL2Hint.
  ///
  /// In tr, this message translates to:
  /// **'Fırçalamaya başlamadan önce fırçanın üstünde macun olmalı.'**
  String get commandOrderL2Hint;

  /// No description provided for @commandOrderL3Title.
  ///
  /// In tr, this message translates to:
  /// **'Ellerini yıka'**
  String get commandOrderL3Title;

  /// No description provided for @commandOrderL3Step1.
  ///
  /// In tr, this message translates to:
  /// **'Ellerini sabunla'**
  String get commandOrderL3Step1;

  /// No description provided for @commandOrderL3Step2.
  ///
  /// In tr, this message translates to:
  /// **'Ellerini durula'**
  String get commandOrderL3Step2;

  /// No description provided for @commandOrderL3Step3.
  ///
  /// In tr, this message translates to:
  /// **'Ellerini kurula'**
  String get commandOrderL3Step3;

  /// No description provided for @commandOrderL3Hint.
  ///
  /// In tr, this message translates to:
  /// **'Köpükler gitmeden elini kurulamak olmaz.'**
  String get commandOrderL3Hint;

  /// No description provided for @commandOrderL4Title.
  ///
  /// In tr, this message translates to:
  /// **'Ayakkabını giy'**
  String get commandOrderL4Title;

  /// No description provided for @commandOrderL4Step1.
  ///
  /// In tr, this message translates to:
  /// **'Çorabını giy'**
  String get commandOrderL4Step1;

  /// No description provided for @commandOrderL4Step2.
  ///
  /// In tr, this message translates to:
  /// **'Ayakkabını giy'**
  String get commandOrderL4Step2;

  /// No description provided for @commandOrderL4Step3.
  ///
  /// In tr, this message translates to:
  /// **'Bağcığını bağla'**
  String get commandOrderL4Step3;

  /// No description provided for @commandOrderL4Hint.
  ///
  /// In tr, this message translates to:
  /// **'Ayakkabının içine girmeden önce ayağında ne olmalı?'**
  String get commandOrderL4Hint;

  /// No description provided for @commandOrderL5Title.
  ///
  /// In tr, this message translates to:
  /// **'Resim yap'**
  String get commandOrderL5Title;

  /// No description provided for @commandOrderL5Step1.
  ///
  /// In tr, this message translates to:
  /// **'Kâğıdı al'**
  String get commandOrderL5Step1;

  /// No description provided for @commandOrderL5Step2.
  ///
  /// In tr, this message translates to:
  /// **'Resmini çiz'**
  String get commandOrderL5Step2;

  /// No description provided for @commandOrderL5Step3.
  ///
  /// In tr, this message translates to:
  /// **'Resmini boya'**
  String get commandOrderL5Step3;

  /// No description provided for @commandOrderL5Hint.
  ///
  /// In tr, this message translates to:
  /// **'Boyamak için önce çizilmiş bir resim gerekir.'**
  String get commandOrderL5Hint;

  /// No description provided for @commandOrderL6Title.
  ///
  /// In tr, this message translates to:
  /// **'Sandviç hazırla'**
  String get commandOrderL6Title;

  /// No description provided for @commandOrderL6Step1.
  ///
  /// In tr, this message translates to:
  /// **'Tabağı masaya koy'**
  String get commandOrderL6Step1;

  /// No description provided for @commandOrderL6Step2.
  ///
  /// In tr, this message translates to:
  /// **'Ekmeği tabağa koy'**
  String get commandOrderL6Step2;

  /// No description provided for @commandOrderL6Step3.
  ///
  /// In tr, this message translates to:
  /// **'Üstüne peynir koy'**
  String get commandOrderL6Step3;

  /// No description provided for @commandOrderL6Step4.
  ///
  /// In tr, this message translates to:
  /// **'Üstünü ekmekle kapat'**
  String get commandOrderL6Step4;

  /// No description provided for @commandOrderL6Step5.
  ///
  /// In tr, this message translates to:
  /// **'Afiyetle ye'**
  String get commandOrderL6Step5;

  /// No description provided for @commandOrderL6Hint.
  ///
  /// In tr, this message translates to:
  /// **'Ekmeği koyacak bir yer lazım. Masada ilk ne olmalı?'**
  String get commandOrderL6Hint;

  /// No description provided for @commandOrderL7Title.
  ///
  /// In tr, this message translates to:
  /// **'Oyuncakları topla'**
  String get commandOrderL7Title;

  /// No description provided for @commandOrderL7Step1.
  ///
  /// In tr, this message translates to:
  /// **'Kutuyu getir'**
  String get commandOrderL7Step1;

  /// No description provided for @commandOrderL7Step2.
  ///
  /// In tr, this message translates to:
  /// **'Oyuncakları kutuya koy'**
  String get commandOrderL7Step2;

  /// No description provided for @commandOrderL7Step3.
  ///
  /// In tr, this message translates to:
  /// **'Kutunun kapağını kapat'**
  String get commandOrderL7Step3;

  /// No description provided for @commandOrderL7Step4.
  ///
  /// In tr, this message translates to:
  /// **'Kutuyu rafa kaldır'**
  String get commandOrderL7Step4;

  /// No description provided for @commandOrderL7Hint.
  ///
  /// In tr, this message translates to:
  /// **'Oyuncakları koyacağın kutu yanında değilse ne yaparsın?'**
  String get commandOrderL7Hint;

  /// No description provided for @commandOrderL8Title.
  ///
  /// In tr, this message translates to:
  /// **'Tohum ek'**
  String get commandOrderL8Title;

  /// No description provided for @commandOrderL8Step1.
  ///
  /// In tr, this message translates to:
  /// **'Toprakta çukur kaz'**
  String get commandOrderL8Step1;

  /// No description provided for @commandOrderL8Step2.
  ///
  /// In tr, this message translates to:
  /// **'Tohumu çukura koy'**
  String get commandOrderL8Step2;

  /// No description provided for @commandOrderL8Step3.
  ///
  /// In tr, this message translates to:
  /// **'Üstünü toprakla ört'**
  String get commandOrderL8Step3;

  /// No description provided for @commandOrderL8Step4.
  ///
  /// In tr, this message translates to:
  /// **'Tohumu sula'**
  String get commandOrderL8Step4;

  /// No description provided for @commandOrderL8Step5.
  ///
  /// In tr, this message translates to:
  /// **'Filizin çıkmasını bekle'**
  String get commandOrderL8Step5;

  /// No description provided for @commandOrderL8Hint.
  ///
  /// In tr, this message translates to:
  /// **'Tohumun gireceği bir çukur olmadan onu toprağa koyamazsın.'**
  String get commandOrderL8Hint;

  /// No description provided for @commandOrderL9Title.
  ///
  /// In tr, this message translates to:
  /// **'Okula hazırlan'**
  String get commandOrderL9Title;

  /// No description provided for @commandOrderL9Step1.
  ///
  /// In tr, this message translates to:
  /// **'Alarm çalınca uyan'**
  String get commandOrderL9Step1;

  /// No description provided for @commandOrderL9Step2.
  ///
  /// In tr, this message translates to:
  /// **'Okul kıyafetini giy'**
  String get commandOrderL9Step2;

  /// No description provided for @commandOrderL9Step3.
  ///
  /// In tr, this message translates to:
  /// **'Çantanı sırtına tak'**
  String get commandOrderL9Step3;

  /// No description provided for @commandOrderL9Step4.
  ///
  /// In tr, this message translates to:
  /// **'Servise bin'**
  String get commandOrderL9Step4;

  /// No description provided for @commandOrderL9Hint.
  ///
  /// In tr, this message translates to:
  /// **'Uyanmadan giyinmek olmaz. Sabah ilk ne olur?'**
  String get commandOrderL9Hint;

  /// No description provided for @commandOrderL10Title.
  ///
  /// In tr, this message translates to:
  /// **'Mektup gönder'**
  String get commandOrderL10Title;

  /// No description provided for @commandOrderL10Step1.
  ///
  /// In tr, this message translates to:
  /// **'Mektubu yaz'**
  String get commandOrderL10Step1;

  /// No description provided for @commandOrderL10Step2.
  ///
  /// In tr, this message translates to:
  /// **'Mektubu zarfa koy'**
  String get commandOrderL10Step2;

  /// No description provided for @commandOrderL10Step3.
  ///
  /// In tr, this message translates to:
  /// **'Zarfı kapat'**
  String get commandOrderL10Step3;

  /// No description provided for @commandOrderL10Step4.
  ///
  /// In tr, this message translates to:
  /// **'Posta kutusuna at'**
  String get commandOrderL10Step4;

  /// No description provided for @commandOrderL10Hint.
  ///
  /// In tr, this message translates to:
  /// **'Zarfın içine koyacak bir mektup olmalı.'**
  String get commandOrderL10Hint;

  /// No description provided for @commandOrderL11Title.
  ///
  /// In tr, this message translates to:
  /// **'Kek yap'**
  String get commandOrderL11Title;

  /// No description provided for @commandOrderL11Stage1.
  ///
  /// In tr, this message translates to:
  /// **'Hamuru hazırla'**
  String get commandOrderL11Stage1;

  /// No description provided for @commandOrderL11Stage2.
  ///
  /// In tr, this message translates to:
  /// **'Keki pişir'**
  String get commandOrderL11Stage2;

  /// No description provided for @commandOrderL11Step1.
  ///
  /// In tr, this message translates to:
  /// **'Malzemeleri masaya koy'**
  String get commandOrderL11Step1;

  /// No description provided for @commandOrderL11Step2.
  ///
  /// In tr, this message translates to:
  /// **'Hepsini kapta karıştır'**
  String get commandOrderL11Step2;

  /// No description provided for @commandOrderL11Step3.
  ///
  /// In tr, this message translates to:
  /// **'Hamuru kalıba dök'**
  String get commandOrderL11Step3;

  /// No description provided for @commandOrderL11Step4.
  ///
  /// In tr, this message translates to:
  /// **'Kalıbı fırına koy'**
  String get commandOrderL11Step4;

  /// No description provided for @commandOrderL11Step5.
  ///
  /// In tr, this message translates to:
  /// **'Pişmesini bekle'**
  String get commandOrderL11Step5;

  /// No description provided for @commandOrderL11Step6.
  ///
  /// In tr, this message translates to:
  /// **'Keki dilimle'**
  String get commandOrderL11Step6;

  /// No description provided for @commandOrderL11Hint.
  ///
  /// In tr, this message translates to:
  /// **'Hamur hazır olmadan fırına bir şey koyamazsın.'**
  String get commandOrderL11Hint;

  /// No description provided for @commandOrderL12Title.
  ///
  /// In tr, this message translates to:
  /// **'Banyo yap'**
  String get commandOrderL12Title;

  /// No description provided for @commandOrderL12Stage1.
  ///
  /// In tr, this message translates to:
  /// **'Banyoya hazırlan'**
  String get commandOrderL12Stage1;

  /// No description provided for @commandOrderL12Stage2.
  ///
  /// In tr, this message translates to:
  /// **'Yıkan'**
  String get commandOrderL12Stage2;

  /// No description provided for @commandOrderL12Stage3.
  ///
  /// In tr, this message translates to:
  /// **'Kurulan'**
  String get commandOrderL12Stage3;

  /// No description provided for @commandOrderL12Step1.
  ///
  /// In tr, this message translates to:
  /// **'Küveti suyla doldur'**
  String get commandOrderL12Step1;

  /// No description provided for @commandOrderL12Step2.
  ///
  /// In tr, this message translates to:
  /// **'Küvete gir'**
  String get commandOrderL12Step2;

  /// No description provided for @commandOrderL12Step3.
  ///
  /// In tr, this message translates to:
  /// **'Saçını şampuanla'**
  String get commandOrderL12Step3;

  /// No description provided for @commandOrderL12Step4.
  ///
  /// In tr, this message translates to:
  /// **'Köpükleri durula'**
  String get commandOrderL12Step4;

  /// No description provided for @commandOrderL12Step5.
  ///
  /// In tr, this message translates to:
  /// **'Havluyla kurulan'**
  String get commandOrderL12Step5;

  /// No description provided for @commandOrderL12Hint.
  ///
  /// In tr, this message translates to:
  /// **'Boş küvete girersen yıkanamazsın.'**
  String get commandOrderL12Hint;

  /// No description provided for @commandOrderL13Title.
  ///
  /// In tr, this message translates to:
  /// **'Bisiklet sür'**
  String get commandOrderL13Title;

  /// No description provided for @commandOrderL13Stage1.
  ///
  /// In tr, this message translates to:
  /// **'Hazırlan'**
  String get commandOrderL13Stage1;

  /// No description provided for @commandOrderL13Stage2.
  ///
  /// In tr, this message translates to:
  /// **'Sür'**
  String get commandOrderL13Stage2;

  /// No description provided for @commandOrderL13Stage3.
  ///
  /// In tr, this message translates to:
  /// **'Bitir'**
  String get commandOrderL13Stage3;

  /// No description provided for @commandOrderL13Step1.
  ///
  /// In tr, this message translates to:
  /// **'Kaskını tak'**
  String get commandOrderL13Step1;

  /// No description provided for @commandOrderL13Step2.
  ///
  /// In tr, this message translates to:
  /// **'Bisiklete bin'**
  String get commandOrderL13Step2;

  /// No description provided for @commandOrderL13Step3.
  ///
  /// In tr, this message translates to:
  /// **'Pedal çevir'**
  String get commandOrderL13Step3;

  /// No description provided for @commandOrderL13Step4.
  ///
  /// In tr, this message translates to:
  /// **'Fren yap'**
  String get commandOrderL13Step4;

  /// No description provided for @commandOrderL13Step5.
  ///
  /// In tr, this message translates to:
  /// **'Bisikletten in'**
  String get commandOrderL13Step5;

  /// No description provided for @commandOrderL13Hint.
  ///
  /// In tr, this message translates to:
  /// **'Güvenlik önce gelir. Bisiklete binmeden ne takarsın?'**
  String get commandOrderL13Hint;

  /// No description provided for @commandOrderL14Title.
  ///
  /// In tr, this message translates to:
  /// **'Kütüphaneden kitap al'**
  String get commandOrderL14Title;

  /// No description provided for @commandOrderL14Stage1.
  ///
  /// In tr, this message translates to:
  /// **'Kütüphanede'**
  String get commandOrderL14Stage1;

  /// No description provided for @commandOrderL14Stage2.
  ///
  /// In tr, this message translates to:
  /// **'Evde'**
  String get commandOrderL14Stage2;

  /// No description provided for @commandOrderL14Stage3.
  ///
  /// In tr, this message translates to:
  /// **'Geri ver'**
  String get commandOrderL14Stage3;

  /// No description provided for @commandOrderL14Step1.
  ///
  /// In tr, this message translates to:
  /// **'Kütüphaneye git'**
  String get commandOrderL14Step1;

  /// No description provided for @commandOrderL14Step2.
  ///
  /// In tr, this message translates to:
  /// **'Bir kitap seç'**
  String get commandOrderL14Step2;

  /// No description provided for @commandOrderL14Step3.
  ///
  /// In tr, this message translates to:
  /// **'Kitabı ödünç al'**
  String get commandOrderL14Step3;

  /// No description provided for @commandOrderL14Step4.
  ///
  /// In tr, this message translates to:
  /// **'Kitabı eve getir'**
  String get commandOrderL14Step4;

  /// No description provided for @commandOrderL14Step5.
  ///
  /// In tr, this message translates to:
  /// **'Kitabı oku'**
  String get commandOrderL14Step5;

  /// No description provided for @commandOrderL14Step6.
  ///
  /// In tr, this message translates to:
  /// **'Kitabı geri götür'**
  String get commandOrderL14Step6;

  /// No description provided for @commandOrderL14Hint.
  ///
  /// In tr, this message translates to:
  /// **'Kitap seçmek için önce kitapların olduğu yere gitmelisin.'**
  String get commandOrderL14Hint;

  /// No description provided for @commandOrderL15Title.
  ///
  /// In tr, this message translates to:
  /// **'Çadır kur'**
  String get commandOrderL15Title;

  /// No description provided for @commandOrderL15Stage1.
  ///
  /// In tr, this message translates to:
  /// **'Yeri hazırla'**
  String get commandOrderL15Stage1;

  /// No description provided for @commandOrderL15Stage2.
  ///
  /// In tr, this message translates to:
  /// **'Çadırı kur'**
  String get commandOrderL15Stage2;

  /// No description provided for @commandOrderL15Stage3.
  ///
  /// In tr, this message translates to:
  /// **'İçini hazırla'**
  String get commandOrderL15Stage3;

  /// No description provided for @commandOrderL15Step1.
  ///
  /// In tr, this message translates to:
  /// **'Düz bir yer bul'**
  String get commandOrderL15Step1;

  /// No description provided for @commandOrderL15Step2.
  ///
  /// In tr, this message translates to:
  /// **'Çadırı yere ser'**
  String get commandOrderL15Step2;

  /// No description provided for @commandOrderL15Step3.
  ///
  /// In tr, this message translates to:
  /// **'Direkleri tak'**
  String get commandOrderL15Step3;

  /// No description provided for @commandOrderL15Step4.
  ///
  /// In tr, this message translates to:
  /// **'Çadırı kaldır'**
  String get commandOrderL15Step4;

  /// No description provided for @commandOrderL15Step5.
  ///
  /// In tr, this message translates to:
  /// **'Kazıklarla sabitle'**
  String get commandOrderL15Step5;

  /// No description provided for @commandOrderL15Step6.
  ///
  /// In tr, this message translates to:
  /// **'Uyku tulumunu içine koy'**
  String get commandOrderL15Step6;

  /// No description provided for @commandOrderL15Step7.
  ///
  /// In tr, this message translates to:
  /// **'Fenerini yak'**
  String get commandOrderL15Step7;

  /// No description provided for @commandOrderL15Hint.
  ///
  /// In tr, this message translates to:
  /// **'Çadırı sermek için önce uygun bir yer bulmalısın.'**
  String get commandOrderL15Hint;

  /// No description provided for @commandOrderL16Title.
  ///
  /// In tr, this message translates to:
  /// **'Pizza yap'**
  String get commandOrderL16Title;

  /// No description provided for @commandOrderL16Stage1.
  ///
  /// In tr, this message translates to:
  /// **'Hamur'**
  String get commandOrderL16Stage1;

  /// No description provided for @commandOrderL16Stage2.
  ///
  /// In tr, this message translates to:
  /// **'Malzemeler'**
  String get commandOrderL16Stage2;

  /// No description provided for @commandOrderL16Stage3.
  ///
  /// In tr, this message translates to:
  /// **'Pişirme'**
  String get commandOrderL16Stage3;

  /// No description provided for @commandOrderL16Step1.
  ///
  /// In tr, this message translates to:
  /// **'Hamuru aç'**
  String get commandOrderL16Step1;

  /// No description provided for @commandOrderL16Step2.
  ///
  /// In tr, this message translates to:
  /// **'Domates sosu sür'**
  String get commandOrderL16Step2;

  /// No description provided for @commandOrderL16Step3.
  ///
  /// In tr, this message translates to:
  /// **'Peynir serp'**
  String get commandOrderL16Step3;

  /// No description provided for @commandOrderL16Step4.
  ///
  /// In tr, this message translates to:
  /// **'Fırına koy'**
  String get commandOrderL16Step4;

  /// No description provided for @commandOrderL16Step5.
  ///
  /// In tr, this message translates to:
  /// **'Pişmesini bekle'**
  String get commandOrderL16Step5;

  /// No description provided for @commandOrderL16Step6.
  ///
  /// In tr, this message translates to:
  /// **'Dilimle'**
  String get commandOrderL16Step6;

  /// No description provided for @commandOrderL16Extra1.
  ///
  /// In tr, this message translates to:
  /// **'Televizyon aç'**
  String get commandOrderL16Extra1;

  /// No description provided for @commandOrderL16Hint.
  ///
  /// In tr, this message translates to:
  /// **'Her kart bu göreve ait değil. Pizza yaparken televizyona gerek var mı?'**
  String get commandOrderL16Hint;

  /// No description provided for @commandOrderL17Title.
  ///
  /// In tr, this message translates to:
  /// **'Çamaşır yıka'**
  String get commandOrderL17Title;

  /// No description provided for @commandOrderL17Stage1.
  ///
  /// In tr, this message translates to:
  /// **'Hazırlık'**
  String get commandOrderL17Stage1;

  /// No description provided for @commandOrderL17Stage2.
  ///
  /// In tr, this message translates to:
  /// **'Yıkama'**
  String get commandOrderL17Stage2;

  /// No description provided for @commandOrderL17Stage3.
  ///
  /// In tr, this message translates to:
  /// **'Kurutma'**
  String get commandOrderL17Stage3;

  /// No description provided for @commandOrderL17Step1.
  ///
  /// In tr, this message translates to:
  /// **'Kirlileri topla'**
  String get commandOrderL17Step1;

  /// No description provided for @commandOrderL17Step2.
  ///
  /// In tr, this message translates to:
  /// **'Makineye koy'**
  String get commandOrderL17Step2;

  /// No description provided for @commandOrderL17Step3.
  ///
  /// In tr, this message translates to:
  /// **'Deterjanı ekle'**
  String get commandOrderL17Step3;

  /// No description provided for @commandOrderL17Step4.
  ///
  /// In tr, this message translates to:
  /// **'Makineyi çalıştır'**
  String get commandOrderL17Step4;

  /// No description provided for @commandOrderL17Step5.
  ///
  /// In tr, this message translates to:
  /// **'Çamaşırları as'**
  String get commandOrderL17Step5;

  /// No description provided for @commandOrderL17Step6.
  ///
  /// In tr, this message translates to:
  /// **'Kuruyunca katla'**
  String get commandOrderL17Step6;

  /// No description provided for @commandOrderL17Extra1.
  ///
  /// In tr, this message translates to:
  /// **'Top oyna'**
  String get commandOrderL17Extra1;

  /// No description provided for @commandOrderL17Hint.
  ///
  /// In tr, this message translates to:
  /// **'Kirli çamaşırlar bir yere dağılmışsa önce ne yapmalısın?'**
  String get commandOrderL17Hint;

  /// No description provided for @commandOrderL18Title.
  ///
  /// In tr, this message translates to:
  /// **'Trenle yolculuk'**
  String get commandOrderL18Title;

  /// No description provided for @commandOrderL18Stage1.
  ///
  /// In tr, this message translates to:
  /// **'İstasyonda'**
  String get commandOrderL18Stage1;

  /// No description provided for @commandOrderL18Stage2.
  ///
  /// In tr, this message translates to:
  /// **'Trende'**
  String get commandOrderL18Stage2;

  /// No description provided for @commandOrderL18Stage3.
  ///
  /// In tr, this message translates to:
  /// **'Varış'**
  String get commandOrderL18Stage3;

  /// No description provided for @commandOrderL18Step1.
  ///
  /// In tr, this message translates to:
  /// **'Bilet al'**
  String get commandOrderL18Step1;

  /// No description provided for @commandOrderL18Step2.
  ///
  /// In tr, this message translates to:
  /// **'Perona git'**
  String get commandOrderL18Step2;

  /// No description provided for @commandOrderL18Step3.
  ///
  /// In tr, this message translates to:
  /// **'Treni bekle'**
  String get commandOrderL18Step3;

  /// No description provided for @commandOrderL18Step4.
  ///
  /// In tr, this message translates to:
  /// **'Trene bin'**
  String get commandOrderL18Step4;

  /// No description provided for @commandOrderL18Step5.
  ///
  /// In tr, this message translates to:
  /// **'Koltuğuna otur'**
  String get commandOrderL18Step5;

  /// No description provided for @commandOrderL18Step6.
  ///
  /// In tr, this message translates to:
  /// **'Durağında in'**
  String get commandOrderL18Step6;

  /// No description provided for @commandOrderL18Extra1.
  ///
  /// In tr, this message translates to:
  /// **'Uçağa bin'**
  String get commandOrderL18Extra1;

  /// No description provided for @commandOrderL18Hint.
  ///
  /// In tr, this message translates to:
  /// **'Trene binmek için yanında ne olmalı?'**
  String get commandOrderL18Hint;

  /// No description provided for @commandOrderL19Title.
  ///
  /// In tr, this message translates to:
  /// **'Fidan yetiştir'**
  String get commandOrderL19Title;

  /// No description provided for @commandOrderL19Stage1.
  ///
  /// In tr, this message translates to:
  /// **'Ek'**
  String get commandOrderL19Stage1;

  /// No description provided for @commandOrderL19Stage2.
  ///
  /// In tr, this message translates to:
  /// **'Bakım yap'**
  String get commandOrderL19Stage2;

  /// No description provided for @commandOrderL19Stage3.
  ///
  /// In tr, this message translates to:
  /// **'Büyüt'**
  String get commandOrderL19Stage3;

  /// No description provided for @commandOrderL19Step1.
  ///
  /// In tr, this message translates to:
  /// **'Saksıya toprak koy'**
  String get commandOrderL19Step1;

  /// No description provided for @commandOrderL19Step2.
  ///
  /// In tr, this message translates to:
  /// **'Tohumu ek'**
  String get commandOrderL19Step2;

  /// No description provided for @commandOrderL19Step3.
  ///
  /// In tr, this message translates to:
  /// **'Tohumu sula'**
  String get commandOrderL19Step3;

  /// No description provided for @commandOrderL19Step4.
  ///
  /// In tr, this message translates to:
  /// **'Saksıyı güneşe koy'**
  String get commandOrderL19Step4;

  /// No description provided for @commandOrderL19Step5.
  ///
  /// In tr, this message translates to:
  /// **'Filizi bekle'**
  String get commandOrderL19Step5;

  /// No description provided for @commandOrderL19Step6.
  ///
  /// In tr, this message translates to:
  /// **'Bahçeye dik'**
  String get commandOrderL19Step6;

  /// No description provided for @commandOrderL19Extra1.
  ///
  /// In tr, this message translates to:
  /// **'Şemsiye aç'**
  String get commandOrderL19Extra1;

  /// No description provided for @commandOrderL19Extra2.
  ///
  /// In tr, this message translates to:
  /// **'Saksıyı karanlığa koy'**
  String get commandOrderL19Extra2;

  /// No description provided for @commandOrderL19Hint.
  ///
  /// In tr, this message translates to:
  /// **'Bitkiler büyümek için su ve güneş ister. Hangi kartlar onlara zarar verir?'**
  String get commandOrderL19Hint;

  /// No description provided for @commandOrderL20Title.
  ///
  /// In tr, this message translates to:
  /// **'Kurabiye yap ve paylaş'**
  String get commandOrderL20Title;

  /// No description provided for @commandOrderL20Stage1.
  ///
  /// In tr, this message translates to:
  /// **'Hazırla'**
  String get commandOrderL20Stage1;

  /// No description provided for @commandOrderL20Stage2.
  ///
  /// In tr, this message translates to:
  /// **'Pişir'**
  String get commandOrderL20Stage2;

  /// No description provided for @commandOrderL20Stage3.
  ///
  /// In tr, this message translates to:
  /// **'Paylaş'**
  String get commandOrderL20Stage3;

  /// No description provided for @commandOrderL20Step1.
  ///
  /// In tr, this message translates to:
  /// **'Ellerini yıka'**
  String get commandOrderL20Step1;

  /// No description provided for @commandOrderL20Step2.
  ///
  /// In tr, this message translates to:
  /// **'Malzemeleri karıştır'**
  String get commandOrderL20Step2;

  /// No description provided for @commandOrderL20Step3.
  ///
  /// In tr, this message translates to:
  /// **'Hamura şekil ver'**
  String get commandOrderL20Step3;

  /// No description provided for @commandOrderL20Step4.
  ///
  /// In tr, this message translates to:
  /// **'Fırında pişir'**
  String get commandOrderL20Step4;

  /// No description provided for @commandOrderL20Step5.
  ///
  /// In tr, this message translates to:
  /// **'Soğumasını bekle'**
  String get commandOrderL20Step5;

  /// No description provided for @commandOrderL20Step6.
  ///
  /// In tr, this message translates to:
  /// **'Kutuya koy'**
  String get commandOrderL20Step6;

  /// No description provided for @commandOrderL20Step7.
  ///
  /// In tr, this message translates to:
  /// **'Arkadaşlarına ikram et'**
  String get commandOrderL20Step7;

  /// No description provided for @commandOrderL20Extra1.
  ///
  /// In tr, this message translates to:
  /// **'Oyuncak araba sür'**
  String get commandOrderL20Extra1;

  /// No description provided for @commandOrderL20Extra2.
  ///
  /// In tr, this message translates to:
  /// **'Uyumaya git'**
  String get commandOrderL20Extra2;

  /// No description provided for @commandOrderL20Hint.
  ///
  /// In tr, this message translates to:
  /// **'Mutfakta çalışmadan önce temizlik gerekir.'**
  String get commandOrderL20Hint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'id',
    'it',
    'pt',
    'tr',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
