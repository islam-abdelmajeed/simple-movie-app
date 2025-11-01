import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback? onTap;

  const MovieCard({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF3A3A3A) : const Color(0xFFF5F5F5);

    return Card(
      color: cardColor,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: movie.posterPath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: movie.posterUrl,
                  width: 60,
                  height: 90,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(width: 60, height: 90, color: const Color(0xFFE0E0E0), child: const Icon(Icons.image)),
                  errorWidget: (context, url, error) =>
                      Container(width: 60, height: 90, color: const Color(0xFFE0E0E0), child: const Icon(Icons.broken_image)),
                ),
              )
            : Container(
                width: 60,
                height: 90,
                decoration: BoxDecoration(color: const Color(0xFF9E9E9E), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.image),
              ),
        title: Text(movie.title, style: Theme.of(context).textTheme.titleMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFFFC107), size: 16),
                const SizedBox(width: 4),
                Text('${movie.voteAverage?.toStringAsFixed(1) ?? 'N/A'}/10', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: isDark ? const Color(0xB3FFFFFF) : const Color(0x8A000000)),
        onTap: onTap,
      ),
    );
  }
}
