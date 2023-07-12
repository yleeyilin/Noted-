import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.decomposition import LatentDirichletAllocation
from sklearn.metrics.pairwise import cosine_similarity
import sys
import ssl

try:
    _create_unverified_https_context = ssl._create_unverified_context
except AttributeError:
    pass
else:
    ssl._create_default_https_context = _create_unverified_https_context

# Preprocessing
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('wordnet')

def preprocess_text(text):
    stop_words = set(stopwords.words('english'))
    lemmatizer = WordNetLemmatizer()
    tokens = word_tokenize(text.lower())
    tokens = [lemmatizer.lemmatize(token) for token in tokens if token.isalpha() and token not in stop_words]
    return " ".join(tokens)

def calculate_similarity(article1, article2):
    preprocessed_article1 = preprocess_text(article1)
    preprocessed_article2 = preprocess_text(article2)

    # Corpus
    corpus = [preprocessed_article1, preprocessed_article2]
    vectorizer = CountVectorizer()
    X = vectorizer.fit_transform(corpus)

    num_topics = 5
    lda_model = LatentDirichletAllocation(n_components=num_topics, random_state=3)
    lda_model.fit(X)

    article1_topic_dist = lda_model.transform(vectorizer.transform([preprocessed_article1]))
    article2_topic_dist = lda_model.transform(vectorizer.transform([preprocessed_article2]))

    similarity_score = cosine_similarity(article1_topic_dist, article2_topic_dist)[0][0]

    return similarity_score

if __name__ == '__main__':
    print("1")
    article1 = sys.stdin.readline().strip()
    article2 = sys.stdin.readline().strip()
    similarity_score = calculate_similarity(article1, article2)
    sys.stdout.write(str(similarity_score))