from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/api/health')
def health():
    return jsonify({
        "status": "healthy",
        "service": "backend",
        "version": "1.0.0",
        "tier": "private — no public IP"
    })

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8000)
