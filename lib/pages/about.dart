import 'package:flutter/material.dart';

import '../features/history_drawer.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../features/header.dart';
import '../features/info_card.dart';
import '../features/link_text.dart';
import '../features/underlined_title.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    return Scaffold(
      drawer: HistoryDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: isMobile ? 56 : 80),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 8 : 24,
                    vertical: isMobile ? 12 : 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Hoe werkt Critify?",
                          style: TextStyle(
                            fontSize: isMobile ? Sizes.fontSizeBig : Sizes.fontSizeTitle,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(isMobile ? 8 : 64),
                        child: isMobile
                            ? Column(
                                children: [
                                  _AboutSectionLeft(isMobile: true),
                                  SizedBox(height: 16),
                                  _AboutSectionRight(isMobile: true),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(flex: 4, child: _AboutSectionLeft()),
                                  const SizedBox(width: Sizes.spaceBetweenSections),
                                  Flexible(flex: 6, child: _AboutSectionRight()),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  color: CustomColors.primary,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 16),
                    child: Text(
                      "Factcheck Zelf",
                      style: TextStyle(
                        fontSize: isMobile ? Sizes.fontSizeBig : Sizes.fontSizeTitle,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: CustomColors.primary,
                  alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Wat is Fake News?",
                            style: TextStyle(
                              fontSize: isMobile ? Sizes.fontSizeTitle : Sizes.fontSizeBig,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, bottom: isMobile ? 12 : 24),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 8 : 48,
                                ),
                                child: Text(
                                  "Fake news, oftewel nepnieuws, verwijst naar valse of misleidende informatie die wordt verspreid als nieuws. "
                                  "\nHet kan bewust worden gecreëerd om te misleiden, te manipuleren of om bepaalde overtuigingen te versterken. "
                                      "\n(Bron: World Economic Forum, Europese Unie, UGent)",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: Sizes.spaceBetweenSectionsBig,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 16 : 48
                                ),
                                child: isMobile
                                    ? Column(
                                  children: [
                                    _FakeNewsSection1(isMobile: true),
                                    SizedBox(height: 12),
                                    _FakeNewsSection2(isMobile: true),
                                    SizedBox(height: 12),
                                    _FakeNewsSection3(isMobile: true),
                                  ],
                                )
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(flex: 3, child: _FakeNewsSection1()),
                                    const SizedBox(width: Sizes.spaceBetweenSections),
                                    Flexible(flex: 4, child: _FakeNewsSection2()),
                                    const SizedBox(width: Sizes.spaceBetweenSections),
                                    Flexible(flex: 3, child: _FakeNewsSection3()),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Header(title: "Over Critify"),
          ),
        ],
      ),
    );
  }
}

// Responsive left section for About
class _AboutSectionLeft extends StatelessWidget {
  final bool isMobile;
  const _AboutSectionLeft({this.isMobile = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? null : 600,
      padding: EdgeInsets.all(isMobile ? 8 : Sizes.spaceBetweenSections),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
        color: CustomColors.quaternary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UnderlinedTitle(title: "Het Critify Proces"),
          const SizedBox(height: Sizes.spaceBetweenItems),
          Text(
            "Critify analyseert nieuwsartikelen en sociale media posts om mogelijke desinformatie te identificeren. "
            "Het is een hulpmiddel dat gebruikers helpt kritisch na te denken over de informatie die ze online tegenkomen. "
            "\n\nCritify doet dit door een reeks geautomatiseerde controles uit te voeren, waaronder een spelling- en grammaticacontrole, controle van stellingen, detectie van AI-gegenereerde inhoud, sensatie-waarde (emotionele intensiteit) scoring en beoordeling van bronbetrouwbaarheid. "
            "\n\nDe resultaten van deze controles worden gepresenteerd op de resultaten pagina van de Critify-website, zodat gebruikers weloverwogen beslissingen kunnen nemen over de inhoud die ze online vinden."
            "\n\nCritify is geen definitieve bron van waarheid, maar eerder een hulpmiddel om gebruikers te helpen in hun kritisch denkproces. "
            "Het is belangrijk om informatie te controleren met meerdere bronnen en je eigen oordeel te gebruiken bij het evalueren van de geloofwaardigheid van online inhoud. "
            "\n\nGebruikers kunnen inloggen op Critify om hun resultaten op te slaan en later terug te komen op deze resultaten. ",
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}

// Responsive right section for About
class _AboutSectionRight extends StatelessWidget {
  final bool isMobile;
  const _AboutSectionRight({this.isMobile = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? null : 600,
      padding: EdgeInsets.all(isMobile ? 8 : Sizes.spaceBetweenSections),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
        color: CustomColors.quaternary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoCard(
            icon: Icons.language,
            title: "Spelling en Grammatica Controle",
            description:
                "We gebruiken geavanceerde taaltools om je tekst te scannen op spelfouten en grammaticafouten. "
                "Deze stap helpt fouten te identificeren die de duidelijkheid of geloofwaardigheid van het artikel kunnen beïnvloeden. "
                "Correct taalgebruik is belangrijk omdat fouten het vertrouwen kunnen ondermijnen en het verifiëren van feiten moeilijker maken.",
          ),
          const SizedBox(height: Sizes.spaceBetweenSections),
          InfoCard(
            icon: Icons.checklist_rtl,
            title: "Controle van Stellingen",
            description:
                "Het systeem controleert auatomatisch de feitelijke claims in de tekst. "
                "Het identificeert uitspraken die waar of onwaar kunnen zijn en genereert effectieve zoekopdrachten om relevante bronnen van het internet te verzamelen. "
                "Vervolgens evalueert de applicatie de waarheidsgetrouwheid van elke claim en biedt een korte uitleg en ondersteunende URL's. "
                "Dit proces helpt gebruikers om desinformatie te herkennen en te begrijpen welke delen van de tekst goed onderbouwd zijn.",
          ),
          const SizedBox(height: Sizes.spaceBetweenSections),
          InfoCard(
            icon: Icons.add,
            title: "Extra Controles",
            description:
                "Als aanvulling op de hoofdcontroles voert Critify verschillende andere analyses uit: "
                "Het detecteert AI-gegenereerde inhoud, scoort de emotionele intensiteit van de tekst en evalueert de betrouwbaarheid van bronnen. "
                "Deze extra controles bieden een uitgebreider beeld van de kwaliteit van het artikel en helpen gebruikers om mogelijke vooroordelen of manipulatieve taal te begrijpen.",
          ),
        ],
      ),
    );
  }
}

// Responsive fake news sections
class _FakeNewsSection1 extends StatelessWidget {
  final bool isMobile;
  const _FakeNewsSection1({this.isMobile = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? null : 350,
      padding: EdgeInsets.all(isMobile ? 8 : Sizes.spaceBetweenSections),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
        color: CustomColors.quinary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UnderlinedTitle(
            title: "Belangrijke componenten van fake news:",
            color: Colors.white,
          ),
          const SizedBox(height: Sizes.spaceBetweenItems),
          Text(
            "\t\t• Sensationalistische of emotionele koppen"
            "\n\t\t• Onbetrouwbare of anonieme bronnen"
            "\n\t\t• Manipulatie van beelden of video’s"
            "\n\t\t• Verkeerde context of verdraaide feiten"
            "\n\t\t• Snelle verspreiding via sociale media",
            softWrap: true,
            overflow: TextOverflow.visible,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
class _FakeNewsSection2 extends StatelessWidget {
  final bool isMobile;
  const _FakeNewsSection2({this.isMobile = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? null : 350,
      padding: EdgeInsets.all(isMobile ? 8 : Sizes.spaceBetweenSections),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
        color: CustomColors.quinary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UnderlinedTitle(
            title: "Hoe kunnen we fake news bestrijden?",
            color: Colors.white,
          ),
          const SizedBox(height: Sizes.spaceBetweenItems),
          Text(
            "\t\t• Controleer bronnen en zoek naar betrouwbare nieuwswebsites (bijv. Ground News)"
            "\n\t\t• Gebruik factcheck-platforms en AI-tools om nieuws te verifiëren (zie World Economic Forum, Coursera project)"
            "\n\t\t• Wees kritisch op sensationele berichten en deel niet zomaar informatie"
            "\n\t\t• Blijf op de hoogte van nieuwe technologieën en methoden om desinformatie te herkennen (zie arXiv, UGent publicaties)"
            "\n\t\t• Snelle verspreiding via sociale media",
            softWrap: true,
            overflow: TextOverflow.visible,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
class _FakeNewsSection3 extends StatelessWidget {
  final bool isMobile;
  const _FakeNewsSection3({this.isMobile = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? null : 350,
      padding: EdgeInsets.all(isMobile ? 8 : Sizes.spaceBetweenSections),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
        color: CustomColors.quinary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UnderlinedTitle(
            title: "Meer weten? Bekijk deze bronnen:",
            color: Colors.white,
          ),
          const SizedBox(height: Sizes.spaceBetweenItems),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinkText(
                title: "World Economic Forum: AI tegen desinformatie",
                url: "https://www.weforum.org/stories/2024/06/ai-combat-online-misinformation-disinformation/",
              ),
              LinkText(
                title: "EU Studie over fake news",
                url: "https://www.europarl.europa.eu/RegData/etudes/STUD/2019/624278/EPRS_STU(2019)624278_EN.pdf",
              ),
              LinkText(
                title: "Ground News",
                url: "https://ground.news/",
              ),
              LinkText(
                title: "Coursera: Fake News Detector",
                url: "https://www.coursera.org/projects/nlp-fake-news-detector",
              ),
              LinkText(
                title: "GitHub: Fake News Detection",
                url: "https://github.com/alihassanml/fake-news-detection",
              ),
              LinkText(
                title: "arXiv: Detecting Fake News with AI",
                url: "https://arxiv.org/html/2409.17416v1",
              ),
              LinkText(
                title: "UGent: Onderzoek naar desinformatie",
                url: "https://backoffice.biblio.ugent.be/download/01HSV6D56D8T9AJFS1WG933FSY/01HSV6FBG1VM2K76BMQQY6P8QE",
              ),
              LinkText(
                title: "UGent Publicatie 1",
                url: "https://biblio.ugent.be/publication/8743302",
              ),
              LinkText(
                title: "UGent Publicatie 2",
                url: "https://biblio.ugent.be/publication/01JJKDBK1W5RZ2VQ47Y54BV2DD",
              ),
              LinkText(
                title: "OSF: Dataset en tools",
                url: "https://osf.io/9htuv/files/osfstorage",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
