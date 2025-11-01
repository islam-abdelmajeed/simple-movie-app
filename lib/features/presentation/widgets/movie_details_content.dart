import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/movie_details_model.dart';

class MovieDetailsContent extends StatelessWidget {
  final MovieDetailsModel movieDetails;

  const MovieDetailsContent({super.key, required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: movieDetails.posterPath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: movieDetails.posterUrl,
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        height: 400,
                        color: const Color(0xFFE0E0E0),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: double.infinity,
                        height: 400,
                        color: const Color(0xFFE0E0E0),
                        child: const Icon(Icons.broken_image, size: 64),
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.image, size: 64),
                  ),
          ),
          const SizedBox(height: 24),
          Text(
            movieDetails.title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFFFC107), size: 24),
              const SizedBox(width: 8),
              Text(
                '${movieDetails.voteAverage?.toStringAsFixed(1) ?? 'N/A'} / 10',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (movieDetails.genres.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: movieDetails.genres.map((genre) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF424242) : const Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    genre.name,
                    style: TextStyle(
                      color: isDark ? const Color(0xB3FFFFFF) : const Color(0xDE000000),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: 24),
          Text('Description', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            movieDetails.overview ?? 'No description available',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
