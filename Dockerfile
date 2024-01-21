# Use the official Python image
FROM python:3.11.3-bullseye

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install poetry
RUN pip install poetry

# Install PostgreSQL client
RUN apt-get update && \
    apt-get install -y libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy only the pyproject.toml to the working directory
COPY pyproject.toml /app/

# Install project dependencies
RUN poetry config virtualenvs.create false && poetry install --no-root

# Copy the content of the local src directory to the working directory
COPY ./app /app/

# Expose the port the app runs on
EXPOSE 8000

# Command to run on container start
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
