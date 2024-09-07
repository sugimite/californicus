FROM node:18.15.0 as node
FROM ruby:3.2.2

ENV RAILS_ENV development
ENV NODE_ENV development

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /opt/yarn-* /opt/yarn/
RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn

RUN apt-get update && \
    apt-get install -y vim libpq-dev postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID rails && \
    useradd -u $UID -g $GID -m rails

COPY --chown=rails:rails . /work

USER rails
WORKDIR /work

RUN bundle install -j4 && \
    yarn install
