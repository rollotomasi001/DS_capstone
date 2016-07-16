Data Science Capstone Prediction Algorithm
========================================================
author: AT 
date: 07/15/16
autosize: true

First Slide
========================================================

The purpose of this project is to analyze a corpus of text documents to discover the structure in the data and how words are put together. It will cover cleaning and analyzing text data, building and sampling from a predictive text model.

To run the app:

- Type a word or phrase in the text box
- Click the blue button
- Wait approximately 15 seconds for the next predicted word to display below the blue button

Data Conditioning
========================================================

The following steps were required to condition the data.

- Read in data from News, Blogs, and Twitter text datasets
- Create a sample subset of the data to explore, using 750 lines per dataset. Anything more would result in memory errors in future steps.
- Remove non-ASCII characters.
- Remove profanity, stop words, numbers, punctuation, white space, and set to lowercase.`

Building the Predictive Model
========================================================

To build the predictive model, the following approach was taken.

- Using the ngram package, create a descending list of 5,4,3,2-grams.
- For a given input word (or phrase), save a list of n-gram entries that contained the input word
- Return nothing if a match is not found
- Make a list of words that followed the input word
- Rank the words with highest frequency of entries, and return the word with the highest frequency


Lessons Learned
========================================================

During this project, the following lessons were learned:

- Computer memory issues reduced the fidelity of the sample set
- English stopwords were initially removed, but should be added back to accurately predict the next word if it is a stopword
- Additional time is needed to learn the ShinyApp design, including adding a progress bar while the code is running

References 
========================================================

Source code is accessible on GitHub:

https://github.com/rollotomasi001/DS_capstone
