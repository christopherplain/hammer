######################
# Stage: Builder
FROM ruby:2.5.1 as builder

ARG BUNDLE_WITHOUT
ARG EXECJS_RUNTIME
ARG FOLDERS_TO_REMOVE
ARG NODE_ENV
ARG RAILS_ENV
ARG RAILS_MASTER_KEY

ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}
ENV EXECJS_RUNTIME ${EXECJS_RUNTIME}
ENV NODE_ENV ${NODE_ENV}
ENV RAILS_ENV ${RAILS_ENV}
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}
ENV RAILS_SERVE_STATIC_FILES true

# Install Ubuntu packages
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get update && apt-get install -y \
      build-essential \
      nodejs

WORKDIR /app

# Install gems
ADD Gemfile* /app/
RUN bundle install --jobs 20 --retry 5 \
    # Remove unneeded files (cached *.gem, *.o, *.c)
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

# Add the Rails app
ADD . /app

# Precompile assets
RUN bundle exec rake assets:precompile

# Remove folders no longer needed
RUN rm -rf $FOLDERS_TO_REMOVE

######################
# Stage: Final
FROM ruby:2.5.1
MAINTAINER cplain@attunix.com

ARG ADDITIONAL_PACKAGES
ARG EXECJS_RUNTIME

ENV EXECJS_RUNTIME ${EXECJS_RUNTIME}
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true

# Install Ubuntu packages
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get update && apt-get install -y \
      ${ADDITIONAL_PACKAGES}

# Copy app with gems from former build stage
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /app /app

WORKDIR /app

# Expose Puma port
EXPOSE 3000

# Save timestamp of image build
RUN date -u > BUILD_TIME

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
