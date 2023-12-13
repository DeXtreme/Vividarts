from flask import Flask, render_template, request, jsonify
import os

app = Flask(__name__)

# Get api url from environment variable
API_URL = os.environ.get("API_URL")

@app.route('/')
def index():
    # Render template with variable
    return render_template('index.html',API_URL=API_URL)


if __name__ == '__main__':
    app.run("0.0.0.0",debug=True)