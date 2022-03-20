FROM ruby:3.0.0
RUN curl https://deb.nodesource.com/setup_14.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# Install libraries
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  yarn \
  libnss3-dev
# add user
RUN useradd developer
# Create folder developer
RUN mkdir -p /home/developer
# set folder
WORKDIR /home
# set permission to folderexit
RUN chown -R developer:developer developer
RUN chmod 755 developer
# set user
USER developer
# Create folder app
RUN mkdir -p /home/developer/app
# use folder app
WORKDIR /home/developer/app
# Copy the main app
COPY ./ .
RUN gem install bundler:2.3.9
# run console
# CMD  ["entrypoint.sh"]
CMD ruby -e "loop do ; end"
