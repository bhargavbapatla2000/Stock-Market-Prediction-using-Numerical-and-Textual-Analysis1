##Stock-Market-Prediction-using-Numerical-and-Textual-Analysis
 ##TASK 7             



library(quantmod)        
getSymbols("YESBANK.NS",src="yahoo")
head(YESBANK.NS)
chartSeries(YESBANK.NS)
addMACD()              ## Moving average convergence divergence
addBBands()            ## Bollinger Bands
addCCI()               ## The Commodity Channel Index 
addADX()               ## Average Directional Movement Index
addCMF()               ## Chaikin Money Flow 
seriesHi(YESBANK.NS)
b <- weeklyReturn(AMZN) ## gives weekly returns
tail(b)

getSymbols("^BSESN",src="yahoo")
head(BSESN)
chartSeries(BSESN)
addMACD()             ## Moving average convergence divergence
addBBands()           ## Bollinger Bands
addCCI()              ## The Commodity Channel Index
addADX()              ## Average Directional Movement Index
addCMF()               ## Chaikin Money Flow 
seriesHi(BSESN)
b <- weeklyReturn(BSESN)
tail(b)

##TEXT ANALYSIS

install.packages('tm')
library(tm)

docs<- Corpus(DirSource('/Users/Admin/Documents/text_mining_data'))  ##CREATING CORPPUS


writeLines(as.character(docs[[1:15]]))

tospace <- content_transformer(function(x,pattern) { return(gsub(pattern," ", x))})

docs<- tm_map(docs,tospace, "-")  ##CLEANINGG DATA
docs<- tm_map(docs,tospace, ":")
docs<- tm_map(docs,tospace, "'")

docs<- tm_map(docs,removePunctuation)
docs<- tm_map(docs,content_transformer(tolower))  ##TOLOWER CASE
docs<- tm_map(docs,removeNumbers)

docs<- tm_map(docs,removeWords,stopwords("english"))
docs<- tm_map(docs,stripWhitespace)

writeLines(as.character(docs[[1]]))

install.packages("SnowballC")
library(SnowballC)
docs<- tm_map(docs,stemDocument)  ##STEMMING

docs<- tm_map(docs,content_transformer(gsub), pattern="revolut",replacement="revolution")
docs<- tm_map(docs,content_transformer(gsub),pattern="industri",replacement="industrial")
docs<- tm_map(docs,content_transformer(gsub),pattern="machin",replacement="machine")

dtm<- DocumentTermMatrix(docs)
inspect(dtm)

freq<- colSums(as.matrix(dtm))
length(freq)

ord<- order(freq,decreasing = TRUE)
freq[head(ord)]