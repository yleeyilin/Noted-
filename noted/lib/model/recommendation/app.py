import logging
from flask import Flask, request, jsonify
import topicmodelling
from flask_cors import CORS

app = Flask(__name__)
cors = CORS(app)

# Configure logging
logging.basicConfig(level=logging.DEBUG)

@app.route('/calculate-similarity', methods=['POST'])
def calculate_similarity():
    try:
        data = request.get_json()
        article1 = data['article1']
        article2 = data['article2']

        similarity_score = topicmodelling.calculate_similarity(article1, article2)
        response = {'similarityScore': similarity_score}
        return jsonify(response)

    except Exception as e:
        # Log the error
        logging.exception(f"An error occurred while calculating similarity: {e}")

        # Return an error response
        return jsonify({'error': 'Failed to calculate similarity'}), 500

if __name__ == '__main__':
    app.run()