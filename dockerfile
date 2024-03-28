# Official Python image
FROM python:3.9-slim

# Working directory inside the container
WORKDIR /app 

# Copy the requirements .txt file into the container 
COPY requirements.txt /app/requirements.txt

# Install dependencies 
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt 

# Copy the rest of the application code into de container 
COPY /app/ /app/

#Expose port 5000 
EXPOSE 5000 

# Command to run your FastAPI app 
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]
