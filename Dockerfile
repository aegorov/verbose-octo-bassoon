FROM ruby:2.5
WORKDIR /usr/src/app
RUN gem install rspec
COPY . .
CMD irb -I .
