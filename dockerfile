# Use the official Nginx image
FROM nginx:alpine

#Remove the default static files in Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copy your HTML and static files to Nginx directory
COPY ./aryan.html/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 and 443
EXPOSE 80
EXPOSE 443

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
    