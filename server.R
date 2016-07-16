# server.R
# Call the required libraries and set the working directory.
library(NLP)
library(tm)
library(RWeka)
library(ngram)
library(shiny)

Trim <- function( x ) {
  gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
}

# Read in the data
samp_ng_2 <- read.table("news_ngrams.csv", sep=",", header=TRUE)
samp_ng_2 <- as.character(samp_ng_2$x)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the dataset
  datasetInput <- reactive({
    find_next_word(tolower(input$current_sentence))
  })
  
  output$value <- renderPrint({ paste(find_next_word(tolower(input$text))) })
  
  find_next_word <- function(current_sentence) { 
    if (nchar(Trim(current_sentence)) == 0)
      return ('')
    

  # find entries where entry is matched
  matches <- c()
  current_sentence <- paste0(Trim(current_sentence)," ")
  for (phrase in samp_ng_2) {
    if (grepl(paste0('\\<',current_sentence), phrase)) {
      matches <- c(matches, phrase)
    }
  }

  # return nothing if a match is not found
  if (is.null(matches))
    return ('')

  # make a list of subsequent words
  nextwords <- c()
  for (a_match in matches) {
    best_match <- strsplit(x = a_match, split = current_sentence)[[1]]
    best_match <-  strsplit(x = best_match[[2]], split = " ")[[1]]
    best_match <- best_match[[1]]
    nextwords <- c(nextwords, best_match)
  }

  # sort the subsequent words with highest frequency first
  nextwords2 <- Corpus(VectorSource(nextwords))
  dtm_next <- DocumentTermMatrix(nextwords2)
  dtm2_next <- as.matrix(dtm_next)
  frequencynext <- colSums(dtm2_next)
  frequencynext <- sort(frequencynext, decreasing=TRUE)

  # return highest frequency word
  return (names(frequencynext)[1]) 
  }
  
})