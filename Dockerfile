# Use Nginx base image
FROM nginx:latest

# Remove default nginx web page
RUN rm -rf /usr/share/nginx/html/*

# Copy your custom HTML to nginx directory
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80
