from flask import Flask, request

app = Flask(__name__)

@app.route("/logs", methods=["POST"])
def get_logs():
    log_data = request.data
    print(log_data)
    return "OKIE DOKIE"

if __name__ == "__main__":
    app.run(port=10001, host="0.0.0.0")

