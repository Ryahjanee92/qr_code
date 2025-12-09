# Use the official Python image from the Python Docker Hub repository as the base image
FROM python:3.12-slim

# Set the working directory to /app in the container
WORKDIR /app

# Create a non-root user named 'myuser' with a home directory

# Copy the requirements.txt file to the container to install Python dependencies
COPY requirements.txt ./

# Install the Python packages specified in requirements.txt
RUN useradd -m myuser && pip install --no-cache-dir -r requirements.txt && \
    mkdir -p logs qr_codes && chmod 777 logs qr_codes
# Before copying the application code, create the logs and qr_codes directories
# with write permissions for all users (needed for Docker volume mounts)

# Copy the rest of the application's source code into the container, setting ownership to 'myuser'
COPY --chown=myuser:myuser . .

# Use the Python interpreter as the entrypoint and the script as the first argument
# This allows additional command-line arguments to be passed to the script via the docker run command
ENTRYPOINT ["python", "main.py"]
# this sets a default argument, its also set in the program but this just illustrates how to use cmd and override it from the terminal
CMD ["--url","http://github.com/kaw393939"]
