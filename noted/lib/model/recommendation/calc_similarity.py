from flask import Flask, request
import topicmodelling

app = Flask(__name__)

@app.route('/calculate-similarity', methods=['POST'])
def calculate_similarity():
    data = request.get_json()
    article1 = data['article1']
    article2 = data['article2']

    similarity_score = topicmodelling.calculate_similarity(article1, article2)
    return {'similarityScore': similarity_score}

if __name__ == '__main__':
    app.run()