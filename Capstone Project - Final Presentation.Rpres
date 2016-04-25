Capstone Project - Final Presentation
========================================================
author: Jill Beck
date: April 25, 2016
autosize: true

This presentation will briefly cover an application that can be leveraged for predicting the next word.

This application can be leveraged on all form factors to faciltate quicker typing of thoughts across all social media, email and other communications platforms.

Goal and Motivation
========================================================

The main objective of this project was to build a Shiny application in R that is able to predict the next word. 

In order to complete this assignment, techniques such as data cleansing, exploratory analysis, predictive modeling, etc. were used.

Three types of data, which included blogs, news and twitter, were utilized to create the model.

Various word combinations (NGrams) were then created using clean data sets and a predictive algorithm was applied to predict the next word. The final predictive model was configured to work as a Shiny application.


Core Functionality
========================================================

* User is prompted to enter a partial sentence in the text box, and to then press “Next Word” button.
* The predicted next word is displayed with a note indicating which specific NGram was applied.

<div style="align:center"><img src="WordPredictorSnapshot.jpg"/></div>

Application Specifics
========================================================

The basic algorithm to produce a word prediction is as follows:

1. Create a sample data set from the corpus.
2. Clean the sample (convert to lowercase, remove punctuation/profanity, strip out whitespace, etc.)
3. Tokenize the sample into NGrams. [http://en.wikipedia.org/wiki/N-gram](http://en.wikipedia.org/wiki/N-gram)
4. Take the Uni-, Bi, Tri- and 4-Gram frequencies and place them into lookup data frames.
5. Predict the next word in the inputted sequence using the data frames.

Additional Information
========================================================

* All text data used to create a frequency dictionary and then subsequently leveraged to predict the next word comes from a corpus known as [HC Corpora](http://www.corpora.heliohost.org/). 

* This application is currently being hosted on shinyapps.io: [https://jcbeck.shinyapps.io/PredictionAppEngine/](https://jcbeck.shinyapps.io/PredictionAppEngine/)

* All background code and reporting for entire Capstone project can be found at this GitHub repository: [https://github.com/jcbeck/Capstone-Project](https://github.com/jcbeck/Capstone-Project)

* This pitch deck is located here: [http://rpubs.com/jcbeck/capstonefinalproject](http://rpubs.com/jcbeck/capstonefinalproject)
