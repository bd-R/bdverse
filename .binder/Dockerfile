FROM bdverse/bdverse-binder:2020-03-15
LABEL maintainer='Tomer Gueta'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}


RUN wget https://github.com/bd-R/bdverse/raw/master/DESCRIPTION && R -e "options(repos = list(CRAN = 'https://cran.microsoft.com/snapshot/2020-03-15/')); \
devtools::install_deps(upgrade = 'never'); \
devtools::install_github('bd-R/bdverse'); \
devtools::install_github('bd-R/dashboard.demo')"

RUN rm DESCRIPTION.1; exit 0
