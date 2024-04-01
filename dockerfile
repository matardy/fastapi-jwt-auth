# Official Python image
FROM python:3.9-slim

# Copy the requirements .txt file into the container (allows install only changes in requirements.txt) 
COPY requirements.txt /app/requirements.txt

# Working directory inside the container
WORKDIR /app 

# Install dependencies 
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt 

# Copy the rest of the application code into de container 
COPY . /app/

#Expose port 5000 
EXPOSE 5000 

# Command to run your FastAPI app 
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]
