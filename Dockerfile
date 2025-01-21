# Use Python 3.10 as the base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python build tools
RUN pip install --upgrade pip setuptools wheel

# Set the working directory
WORKDIR /app

# Copy the repository code into the container
COPY . /app

# Install Python dependencies using requirements.txt
RUN pip install -r requirements.txt

# Install Python dependencies using pyproject.toml as fallback
RUN pip install .

# Default command to verify PyTorch Lightning installation
CMD ["python", "-c", "import lightning; print('PyTorch Lightning imported successfully')"]
