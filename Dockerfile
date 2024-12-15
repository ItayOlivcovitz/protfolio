# Use a lightweight NGINX image
FROM nginx:alpine

# Remove default NGINX welcome page
RUN rm -rf /usr/share/nginx/html/*

# Copy portfolio files to NGINX root directory
COPY . /usr/share/nginx/html

# Set proper permissions for the NGINX root directory
RUN chmod -R 755 /usr/share/nginx/html \
    && chown -R nginx:nginx /usr/share/nginx/html

# Copy custom NGINX configuration
COPY config/nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["sh", "-c", "envsubst '${PORT}' < /usr/share/nginx/html/config/nginx.conf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
