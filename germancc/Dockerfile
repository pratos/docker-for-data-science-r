FROM rocker/r-base

RUN apt-get update && apt-get -y upgrade && apt-get install -y \
	build-essential libssl-dev libffi-dev libxml2-dev libcurl4-openssl-dev

RUN Rscript -e "install.packages(c('caret', 'tidyverse', 'gbm', 'pROC', 'corrplot', 'doParallel', 'dummies', 'futile.logger'), dependencies=TRUE)"

ENV INSTALL_PATH /germancc

RUN mkdir -p $INSTALL_PATH

COPY . $INSTALL_PATH

WORKDIR $INSTALL_PATH

VOLUME ["$INSTALL_PATH/assets/models", "$INSTALL_PATH/assets/intermediate-files", "$INSTALL_PATH/assets/data", "$INSTALL_PATH/assets/metrics"]

CMD Rscript $INSTALL_PATH/src/modelling.R
