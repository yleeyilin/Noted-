// ignore_for_file: non_constant_identifier_names

double calculate_score(int selfPost, int likes, int comments, int read) {
  double score = 1 * selfPost + 0.75 * likes + 0.5 * comments + 0.25 * read;
  return score;
}

// Similarity Algorithm
int calculate_selfPost(String userEmail, String articleAddress) {
  return null;
}

int calculate_likes(String userEmail, String articleAddress) {
  return null;
}

int calculate_comments(String userEmail, String articleAddress) {
  return null;
}

int calculate_read(String userEmail, String articleAddress) {
  return null;
}