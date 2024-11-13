from flask import Flask, request, Response, jsonify
from tortoise.api_fast import TextToSpeech
from utils.audio import load_voices
import spacy

app = Flask(__name__)
tts = TextToSpeech()
nlp = spacy.load("en_core_web_sm")

def generate_audio_stream(text, voice_name):
    voice_samples, conditioning_latents = load_voices([voice_name])
    stream = tts.tts_stream(
        text,
        voice_samples=voice_samples,
        conditioning_latents=conditioning_latents,
        verbose=True,
        stream_chunk_size=40
    )
    for audio_chunk in stream:
        yield audio_chunk.cpu().numpy().flatten().tobytes()

def split_text(text, max_length=200):
    doc = nlp(text)
    chunks = []
    chunk = []
    length = 0

    for sent in doc.sents:
        sent_length = len(sent.text)
        if length + sent_length > max_length:
            chunks.append(' '.join(chunk))
            chunk = []
            length = 0
        chunk.append(sent.text)
        length += sent_length + 1

    if chunk:
        chunks.append(' '.join(chunk))

    return chunks

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "healthy"}), 200

@app.route('/', methods=['POST'])
def stream_audio():
    data = request.get_json()
    text = data.get("text")
    voice_name = data.get("voice")

    if not text or not voice_name:
        return jsonify({"error": "Text and voice are required"}), 400

    text_chunks = split_text(text)
    def audio_generator():
        for chunk in text_chunks:
            audio_stream = generate_audio_stream(chunk, voice_name)
            for audio_chunk in audio_stream:
                yield audio_chunk
        yield b"END_OF_AUDIO"

    return Response(audio_generator(), mimetype='application/octet-stream')


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
