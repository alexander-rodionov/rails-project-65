FROM ruby

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm postgresql-client && \
    apt-get clean

# Set the working directory in the container
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application code
COPY . .

# Precompile assets (if applicable)
RUN bundle exec rails assets:precompile

# Expose the port the app runs on
EXPOSE 80

# Command to run the application
CMD ["rails", "server", "-b", "0.0.0.0"]