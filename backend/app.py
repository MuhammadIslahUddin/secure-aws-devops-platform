from flask import Flask, jsonify
from datetime import datetime

app = Flask(__name__)

@app.route('/api/health', methods=['GET'])
def health():
    return jsonify({
        "status": "healthy",
        "message": "DevOps Platform Backend is running successfully!",
        "timestamp": datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S UTC"),
        "version": "1.0.0"
    })

@app.route('/api', methods=['GET'])
def root():
    return jsonify({
        "project": "AWS DevOps Portfolio",
        "author": "Islah",
        "endpoints": {
            "health": "/api/health"
        }
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
