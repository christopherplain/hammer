######################
# Stage: Builder
FROM ruby:2.5.1 as builder

ARG BUNDLE_WITHOUT
ARG FOLDERS_TO_REMOVE
ARG RAILS_ENV
ARG RAILS_MASTER_KEY
ARG RAILS_SERVE_STATIC_FILES
ARG NODE_ENV

ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}
ENV RAILS_ENV ${RAILS_ENV}
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}
ENV RAILS_SERVE_STATIC_FILES ${RAILS_SERVE_STATIC_FILES}
ENV NODE_ENV ${NODE_ENV}

RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs

WORKDIR /app

# Install gems
ADD Gemfile* Gemfile.lock /app/
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

ARG EXECJS_RUNTIME
ARG RAILS_ENV
ARG RAILS_LOG_TO_STDOUT
ARG RAILS_SERVE_STATIC_FILES

# Add user
RUN adduser --uid 1000 --system app --group
USER app

# Copy app with gems from former build stage
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder --chown=app:app /app /app

# Set Rails env
ENV EXECJS_RUNTIME ${EXECJS_RUNTIME}
ENV RAILS_ENV ${RAILS_ENV}
ENV RAILS_LOG_TO_STDOUT ${RAILS_LOG_TO_STDOUT}
ENV RAILS_SERVE_STATIC_FILES ${RAILS_SERVE_STATIC_FILES}

WORKDIR /app

# Expose Puma port
EXPOSE 3000

# Save timestamp of image build
RUN date -u > BUILD_TIME

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
