#--------------------------------------------------
# R Server Code for the Capstone Project Shiny App
#--------------------------------------------------

suppressWarnings(library(tm))
suppressWarnings(library(stringr))
suppressWarnings(library(shiny))

# Load UniGram, BiGram, TriGram and 4-Gram data frame files
# This data is already cleansed with NGrams frequency in descending order
# The data was converted to lower case, with the punctuation, numbers,
# white spaces and non print characters removed

load("fDF1.RData");
load("fDF2.RData");
load("fDF3.RData");
load("fDF4.RData");
mesg <- as.character(NULL);

#-------------------------------------------------
# This function "Clean up" the user input string 
# before it is used to predict the next term
#-------------------------------------------------
CleanInputString <- function(inStr)
{
  # Test sentence
  #inStr <- "This is. the; -  .   use's 12"
  
  # Remove the non-alpha characters
  inStr <- iconv(inStr, "latin1", "ASCII", sub=" ");
  inStr <- gsub("[^[:alpha:][:space:][:punct:]]", "", inStr);
  
  # Convert to a Corpus
  inStrCrps <- VCorpus(VectorSource(inStr))
  
  # Convert the input sentence to lower case, and remove punctuation,
  # white spaces, numbers and non-alpha characters
  inStrCrps <- tm_map(inStrCrps, content_transformer(tolower))
  inStrCrps <- tm_map(inStrCrps, removePunctuation)
  inStrCrps <- tm_map(inStrCrps, removeNumbers)
  inStrCrps <- tm_map(inStrCrps, stripWhitespace)
  inStr <- as.character(inStrCrps[[1]])
  inStr <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", inStr)
  
  # Return the sentence
  # If the resulting string is empty, return empty.
  if (nchar(inStr) > 0) {
    return(inStr); 
  } else {
    return("");
  }
}

#---------------------------------------
# Description of the Back Off Algorithm
#---------------------------------------
# To predict the next term of the user specified sentence
# 1. Initially, we use a 4-Gram; 1st 3 words of which are the last 3 words 
#    of the user provided sentencefor which we are trying to predict the next 
#    word. The FourGram is already sorted from highest to lowest frequency
# 2. If no 4-Gram is found, we back off to TriGram (first two words of 
#    ThreeGram last two words of the sentence)
# 3. If no TriGram is found, we back off to TwoGram (first word of TwoGram 
#    last word of the sentence)
# 4. If no TwoGram is found, we back off to UniGram (the most common word 
#    with highest frequency)
#
PredNextTerm <- function(inStr)
{
  assign("mesg", "in PredNextTerm", envir = .GlobalEnv)
  
  # Clean up the input string and extract only the words with no leading and trailing white spaces
  inStr <- CleanInputString(inStr);
  
  # Split the input string across white spaces and then extract the length
  inStr <- unlist(strsplit(inStr, split=" "));
  inStrLen <- length(inStr);
  
  nxtTermFound <- FALSE;
  predNxtTerm <- as.character(NULL);
  #mesg <<- as.character(NULL);
  # 1. First test 4-Gram using the 4-Gram data frame
  if (inStrLen >= 3 & !nxtTermFound)
  {
    # Assemble the terms of the input string separated by one space
    inStr1 <- paste(inStr[(inStrLen-2):inStrLen], collapse=" ");
    
    # Subset 4-Gram data frame 
    searchStr <- paste("^",inStr1, sep = "");
    fDF4Temp <- fDF4[grep (searchStr, fDF4$terms), ];
    
    # Check to see if any matching record returned
    if ( length(fDF4Temp[, 1]) > 1 )
    {
      predNxtTerm <- fDF4Temp[1,1];
      nxtTermFound <- TRUE;
      mesg <<- "Next word is predicted using 4-Gram."
    }
    fDF4Temp <- NULL;
  }
  
  # 2. Next test the TriGram using the TriGram data frame
  if (inStrLen >= 2 & !nxtTermFound)
  {
    # Assemble the terms of the input string separated by one space
    inStr1 <- paste(inStr[(inStrLen-1):inStrLen], collapse=" ");
    
    # Subset the TriGram data frame 
    searchStr <- paste("^",inStr1, sep = "");
    fDF3Temp <- fDF3[grep (searchStr, fDF3$terms), ];
    
    # Check to see if any matching record returned
    if ( length(fDF3Temp[, 1]) > 1 )
    {
      predNxtTerm <- fDF3Temp[1,1];
      nxtTermFound <- TRUE;
      mesg <<- "Next word is predicted using TriGram."
    }
    fDF3Temp <- NULL;
  }
  
  # 3. Next test the BiGram using the BiGram data frame
  if (inStrLen >= 1 & !nxtTermFound)
  {
    # Assemble the terms of the input string separated by one space
    inStr1 <- inStr[inStrLen];
    
    # Subset the BiGram data frame 
    searchStr <- paste("^",inStr1, sep = "");
    fDF2Temp <- fDF2[grep (searchStr, fDF2$terms), ];
    
    # Check to see if any matching record returned
    if ( length(fDF2Temp[, 1]) > 1 )
    {
      predNxtTerm <- fDF2Temp[1,1];
      nxtTermFound <- TRUE;
      mesg <<- "Next word is predicted using BiGram.";
    }
    fDF2Temp <- NULL;
  }
  
  # 4. If no next term found in 4-, Tri and Bi Grams return the most
  #    frequently used term from the UniGram using the UniGram data frame
  if (!nxtTermFound & inStrLen > 0)
  {
    predNxtTerm <- fDF1$terms[1];
    mesg <- "No next word found, the most frequent word has been selected as next word."
  }
  
  nextTerm <- word(predNxtTerm, -1);
  
  if (inStrLen > 0){
    dfTemp1 <- data.frame(nextTerm, mesg);
    return(dfTemp1);
  } else {
    nextTerm <- "";
    mesg <-"";
    dfTemp1 <- data.frame(nextTerm, mesg);
    return(dfTemp1);
  }
}

msg <- ""
shinyServer(function(input, output) {
  output$prediction <- renderPrint({
    str2 <- CleanInputString(input$inputString);
    strDF <- PredNextTerm(str2);
    input$action;
    msg <<- as.character(strDF[1,2]);
    cat("", as.character(strDF[1,1]))
    cat("\n\t");
    cat("\n\t");
    cat("NGram Applied: ", as.character(strDF[1,2]));
  })
  
  output$text1 <- renderText({
    paste("Input Sentence: ", input$inputString)});
  
  output$text2 <- renderText({
    input$action;
    #paste("Note: ", msg);
  })
}
)