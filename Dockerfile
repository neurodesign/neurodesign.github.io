FROM ruby:2.1

RUN gem install github-pages --no-ri --no-rdoc
RUN apt-get update && apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 4000

WORKDIR /home

CMD jekyll serve -P 4000 --watch --force_polling
