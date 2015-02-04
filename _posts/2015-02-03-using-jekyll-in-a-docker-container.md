---
title: Using jekyll in a docker container
tags:
  - jekyll
  - docker
---

In a previous article, I've been writing about running jekyll in a virtual machine using vagrant. Here is a quick follow up on how to do it in a docker container.

Dockerfile:

    FROM ruby:2.1

    RUN gem install github-pages --no-ri --no-rdoc
    RUN apt-get update && apt-get install -y nodejs && \
        rm -rf /var/lib/apt/lists/*

    EXPOSE 4000

    WORKDIR /home

    CMD jekyll serve -P 4000 --watch --force_polling

Build the container:

    docker build -t=jekyll .

Run it, mounting your jekyll project folder as a volume in the container:

    docker run -v /path/to/project/on/host:/home -p 4000:4000 --name jekyll  jekyll

Done!
