import re

import matplotlib

matplotlib.use('TkAgg')

import nltk
from nltk import word_tokenize, FreqDist, WordNetLemmatizer, re_show
from nltk.corpus import gutenberg, webtext, nps_chat, brown, reuters

porter = nltk.PorterStemmer()
lancaster = nltk.LancasterStemmer()


print(
    '''
########################
#  Imported utilities  #
########################

porter          # Porter Stemmer()
lancaster       # Lancaster Stemmer

###############
#  Reminders  #
###############
Creating nlt.Text object
    tokens = word_tokenize(raw: str)
    text = nltk.Text(tokens)

Use <corpus>.fileids() to see what is in the corpus

Corpus are lazzily loaded. Need to first type the name
to get text completions. 

#############
#  Corpora  #
#############
use help(nltk.corpus.reader)
gutenberg: established literature
webtext: less formal languages
nps_chat: instant messaging chat sessions
brown: see http://icame.uib.no/brown/bcm-los.html
reuters: news documents classified into 90 topics
        '''
)
