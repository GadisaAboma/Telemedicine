from tensorflow.keras.models import load_model
from flask import Flask, jsonify, request
import time
import json
import pickle
import random
import numpy as np
import pathlib

import nltk

from nltk.stem import WordNetLemmatizer

import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'


lemmatizer = WordNetLemmatizer()
path = pathlib.Path().resolve()
intents = json.loads(open(path.joinpath('chatbotServer\intents.json')).read())

words = pickle.load(open("words.pkl", "rb"))
classes = pickle.load(open("classes.pkl", "rb"))
model = load_model("chatbotmodel.model")


def cleanUpSentence(sentence):
    sentenceWords = nltk.word_tokenize(sentence)
    sentenceWords = [lemmatizer.lemmatize(word) for word in sentenceWords]
    return sentenceWords


def bagOfWords(sentence):
    sentenceWords = cleanUpSentence(sentence)
    bag = [0] * len(words)
    for w in sentenceWords:
        for i, word in enumerate(words):
            if word == w:
                bag[i] = 1
    return np.array(bag)


def predictClass(sentence):
    bow = bagOfWords(sentence)
    res = model.predict(np.array([bow]))[0]
    ERROR_THRESHOLD = 0.25
    results = [[i, r] for i, r in enumerate(res) if r > ERROR_THRESHOLD]
    results.sort(key=lambda x: x[1], reverse=True)
    returnList = []
    for r in results:
        returnList.append({'intent': classes[r[0]], 'probablity': str(r[1])})
    return returnList


def getResponse(intentsList, intentsJson):
    tag = intentsList[0]['intent']
    listOfIntents = intentsJson['intents']
    for i in listOfIntents:
        if i['tag'] == tag:
            result = random.choice(i['responses'])
            break
    return result

app = Flask(__name__)

@app.route("/bot", methods=["post"])
# response
def response():
    query = dict(request.form)['query']
    ints = predictClass(query)
    result = getResponse(ints, intents)
    return jsonify({"response": result})


if __name__ == "__main__":
    app.run(host="0.0.0.0")
