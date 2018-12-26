library(wordcloud)
library(DT)
library(keras)

model <- application_resnet50(weights = 'imagenet')
TOP_CLASSES <- 10

get_header <- function() {
  HTML("<!-- common header-->
        <div id='headerSection'>
          <h1>Image Recognition App using Keras</h1>
          <span style='font-size: 1.2em'>
            <span>Created by </span>
            <a href='http://gerinberg.com'>Ger Inberg</a>
            &bull;
            <span>December 2018</span>
            &bull;
            <a href='http://shiny.gerinberg.com'>More apps</a> by Ger
          </span>
        </div>")
}