<<<<<<< HEAD
FROM python:3.9-alpine3.13
LABEL maintainer="kalyanjetti.com"

# Ensure Python output is not buffered
ENV PYTHONBUFFERED 1

# Copy the requirements files
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

# Copy the application code
COPY ./app /app

# Set the working directory
WORKDIR /app

# Expose the Django default port
EXPOSE 8000

# Argument to distinguish between development and production
ARG DEV=false

# Create virtual environment and install dependencies
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    # If in development mode, install additional dev dependencies
    if [ "$DEV" = "true" ]; then \
        /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    # Clean up the temporary files to keep the image clean
    rm -rf /tmp && \
    # Create a new user for running the application (non-root user)
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# Ensure the virtual environment's bin folder is added to the PATH
ENV PATH="/py/bin:$PATH"

# Switch to the non-root user
USER django-user
=======
FROM python:3.9-alpine3.13
LABEL maintainer="kalyanjetti.com"

# Ensure Python output is not buffered
ENV PYTHONBUFFERED 1

# Copy the requirements files
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

# Copy the application code
COPY ./app /app

# Set the working directory
WORKDIR /app

# Expose the Django default port
EXPOSE 8000

# Argument to distinguish between development and production
ARG DEV=false

# Create virtual environment and install dependencies
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    # If in development mode, install additional dev dependencies
    if [ "$DEV" = "true" ]; then \
        /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    # Clean up the temporary files to keep the image clean
    rm -rf /tmp && \
    # Create a new user for running the application (non-root user)
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# Ensure the virtual environment's bin folder is added to the PATH
ENV PATH="/py/bin:$PATH"

# Switch to the non-root user
USER django-user
>>>>>>> ff34fe32da42d5264b72bdf7b81573dda8a215df
