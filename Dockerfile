# We set the base image to be ruby 2.3.1
FROM ruby:2.3.1

# Things we will need.
RUN apt-get update && \
apt-get install -y nodejs \
build-essential \
libpq-dev \
--no-install-recommends && \
rm -rf /var/lib/apt/lists/*

# We set it as env variable
ENV RAILS_ROOT /var/www/html/dockerize
ENV APP_ROOT /var/www/html/rails_docker

# Init the root path
RUN mkdir -p $RAILS_ROOT
#WORKDIR $RAILS_ROOT

# We add the gemfiles of the project
COPY Gemfile $RAILS_ROOT/Gemfile
COPY Gemfile.lock $RAILS_ROOT/Gemfile.lock

# We copy all the project to the root path
#COPY modules $RAILS_ROOT/modules
#COPY entrypoint.sh /usr/bin/

# We set /home/ubuntu/myProject to be the root of the project
WORKDIR $RAILS_ROOT

#ENV RAILS_ENV = 'production'

# We install bundler
RUN gem install bundler -v 1.17.3

# Run bundle install to install al the gems
RUN bundle install

# Precompile the assets
#RUN bundle exec rake assets:precompile
COPY . $RAILS_ROOT
# Add a script to be executed every time the container starts.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
