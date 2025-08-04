# Use nginx as base image
FROM nginx:alpine

# Copy the web application files
COPY ./webapp /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]