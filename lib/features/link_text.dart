import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatelessWidget {
  final String title;
  final String url;

  const LinkText({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
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
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ),
      ],
    );
  }
}

