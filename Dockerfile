FROM nginx:latest

# Copy the HTML file to NGINX root directory
COPY index.html /usr/share/nginx/html/index.html

# Expose ports 80 and 443 for HTTP and HTTPS
EXPOSE 80 443

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
