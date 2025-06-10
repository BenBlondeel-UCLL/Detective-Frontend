import 'package:detective/features/history_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../features/header.dart';
import '../features/info_card.dart';
import '../features/underlined_title.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HistoryDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 80), // leave space for header
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Hoe werkt Critify?",
                          style: TextStyle(
                            fontSize: Sizes.fontSizeTitle,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(64),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 4,
                              child: Container(
                                height: 600,
                                padding: const EdgeInsets.all(
                                  Sizes.spaceBetweenSections,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.borderRadiusMedium,
                                  ),
                                  color: CustomColors.quaternary,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const UnderlinedTitle(
                                      title: "Het Critify Proces",
                                    ),
                                    const SizedBox(
                                      height: Sizes.spaceBetweenItems,
                                    ),
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
                              ),
                            ),
                            const SizedBox(width: Sizes.spaceBetweenSections),
                            Flexible(
                              flex: 6,
                              child: Container(
                                height: 600,
                                padding: const EdgeInsets.all(
                                  Sizes.spaceBetweenSections,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.borderRadiusMedium,
                                  ),
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
                                    const SizedBox(
                                      height: Sizes.spaceBetweenSections,
                                    ),
                                    InfoCard(
                                      icon: Icons.checklist_rtl,
                                      title: "Controle van Stellingen",
                                      description:
                                          "Het systeem controleert auatomatisch de feitelijke claims in de tekst. "
                                          "Het identificeert uitspraken die waar of onwaar kunnen zijn en genereert effectieve zoekopdrachten om relevante bronnen van het internet te verzamelen. "
                                          "Vervolgens evalueert de applicatie de waarheidsgetrouwheid van elke claim en biedt een korte uitleg en ondersteunende URL's. "
                                          "Dit proces helpt gebruikers om desinformatie te herkennen en te begrijpen welke delen van de tekst goed onderbouwd zijn.",
                                    ),
                                    const SizedBox(
                                      height: Sizes.spaceBetweenSections,
                                    ),
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
                              ),
                            ),
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
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Factcheck Zelf",
                      style: TextStyle(
                        fontSize: Sizes.fontSizeTitle,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Wat is Fake News?",
                            style: TextStyle(
                              fontSize: Sizes.fontSizeBig,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 24),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 48,
                                ),
                                child: Text(
                                  "Fake news, oftewel nepnieuws, verwijst naar valse of misleidende informatie die wordt verspreid als nieuws. "
                                  "\nHet kan bewust worden gecreëerd om te misleiden, te manipuleren of om bepaalde overtuigingen te versterken. (Bron: World Economic Forum, Europese Unie, UGent)",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: Sizes.spaceBetweenSectionsBig,
                              ),
                              SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: Container(
                                        height: 350,
                                        padding: const EdgeInsets.all(
                                          Sizes.spaceBetweenSections,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            Sizes.borderRadiusMedium,
                                          ),
                                          color: CustomColors.quinary,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const UnderlinedTitle(
                                              title:
                                                  "Belangrijke componenten van fake news:",
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              height: Sizes.spaceBetweenItems,
                                            ),
                                            Text(
                                              "\t\t• Sensationalistische of emotionele koppen"
                                              "\n\t\t• Onbetrouwbare of anonieme bronnen"
                                              "\n\t\t• Manipulatie van beelden of video’s"
                                              "\n\t\t• Verkeerde context of verdraaide feiten"
                                              "\n\t\t• Snelle verspreiding via sociale media",
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: Sizes.spaceBetweenSections,
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: Container(
                                        height: 350,
                                        padding: const EdgeInsets.all(
                                          Sizes.spaceBetweenSections,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            Sizes.borderRadiusMedium,
                                          ),
                                          color: CustomColors.quinary,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const UnderlinedTitle(
                                              title:
                                                  "Hoe kunnen we fake news bestrijden?",
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              height: Sizes.spaceBetweenItems,
                                            ),
                                            Text(
                                              "\t\t• Controleer bronnen en zoek naar betrouwbare nieuwswebsites (bijv. Ground News)"
                                              "\n\t\t• Gebruik factcheck-platforms en AI-tools om nieuws te verifiëren (zie World Economic Forum, Coursera project)"
                                              "\n\t\t• Wees kritisch op sensationele berichten en deel niet zomaar informatie"
                                              "\n\t\t• Blijf op de hoogte van nieuwe technologieën en methoden om desinformatie te herkennen (zie arXiv, UGent publicaties)"
                                              "\n\t\t• Snelle verspreiding via sociale media",
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: Sizes.spaceBetweenSections,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Container(
                                        height: 350,
                                        padding: const EdgeInsets.all(
                                          Sizes.spaceBetweenSections,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            Sizes.borderRadiusMedium,
                                          ),
                                          color: CustomColors.quinary,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const UnderlinedTitle(
                                              title:
                                                  "Meer weten? Bekijk deze bronnen:",
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              height: Sizes.spaceBetweenItems,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _LinkText(
                                                  title:
                                                      "World Economic Forum: AI tegen desinformatie",
                                                  url:
                                                      "https://www.weforum.org/stories/2024/06/ai-combat-online-misinformation-disinformation/",
                                                ),
                                                _LinkText(
                                                  title:
                                                      "EU Studie over fake news",
                                                  url:
                                                      "https://www.europarl.europa.eu/RegData/etudes/STUD/2019/624278/EPRS_STU(2019)624278_EN.pdf",
                                                ),
                                                _LinkText(
                                                  title: "Ground News",
                                                  url: "https://ground.news/",
                                                ),
                                                _LinkText(
                                                  title:
                                                      "Coursera: Fake News Detector",
                                                  url:
                                                      "https://www.coursera.org/projects/nlp-fake-news-detector",
                                                ),
                                                _LinkText(
                                                  title:
                                                      "GitHub: Fake News Detection",
                                                  url:
                                                      "https://github.com/alihassanml/fake-news-detection",
                                                ),
                                                _LinkText(
                                                  title:
                                                      "arXiv: Detecting Fake News with AI",
                                                  url:
                                                      "https://arxiv.org/html/2409.17416v1",
                                                ),
                                                _LinkText(
                                                  title:
                                                      "UGent: Onderzoek naar desinformatie",
                                                  url:
                                                      "https://backoffice.biblio.ugent.be/download/01HSV6D56D8T9AJFS1WG933FSY/01HSV6FBG1VM2K76BMQQY6P8QE",
                                                ),
                                                _LinkText(
                                                  title: "UGent Publicatie 1",
                                                  url:
                                                      "https://biblio.ugent.be/publication/8743302",
                                                ),
                                                _LinkText(
                                                  title: "UGent Publicatie 2",
                                                  url:
                                                      "https://biblio.ugent.be/publication/01JJKDBK1W5RZ2VQ47Y54BV2DD",
                                                ),
                                                _LinkText(
                                                  title:
                                                      "OSF: Dataset en tools",
                                                  url:
                                                      "https://osf.io/9htuv/files/osfstorage",
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

class _LinkText extends StatelessWidget {
  final String title;
  final String url;

  const _LinkText({required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () async {
            final url = Uri.parse(
              this.url.startsWith('http') ? this.url : 'https://${this.url}',
            );
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
          child: Text(
            title,
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
