FROM ruby:2.6.5

# RUN mkdir -p /app
# RUN mkdir -p /config

COPY . ./
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN chmod 777 ./tmp
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs ghostscript
#RUN apt-get update 
RUN gem install bundler

RUN bundle update
RUN bundle install
EXPOSE 6379
EXPOSE 3306
EXPOSE 3000
EXPOSE 5672
EXPOSE 15672
EXPOSE 9200
EXPOSE 9300
EXPOSE 443
EXPOSE 8080
RUN chmod 777 ./entrypoint.sh
RUN chmod 777 ./entrypoint2.sh
# RUN rails db:migrate
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
#CMD ["rails", "s"]

