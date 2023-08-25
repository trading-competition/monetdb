# Dockerfile for MonetDB
FROM debian:bullseye
LABEL authors="erwinvink"

# Add user and group for monetdb
RUN addgroup monetdb && \
    adduser --system --ingroup monetdb monetdb

# Install necessary packages
RUN apt update && \
    apt install -y curl apt-transport-https gnupg

# Add the MonetDB repository to your system
RUN curl --location https://dev.monetdb.org/downloads/MonetDB-GPG-KEY.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/monetdb.gpg && \
    echo "deb https://dev.monetdb.org/downloads/deb/ bullseye monetdb" > /etc/apt/sources.list.d/monetdb.list && \
    echo "deb-src https://dev.monetdb.org/downloads/deb/ bullseye monetdb" >> /etc/apt/sources.list.d/monetdb.list

RUN apt-key finger

# Update your system's package list and install MonetDB
RUN apt update && \
    apt install -y monetdb5-sql monetdb-client

# Expose the default MonetDB port
EXPOSE 50000

# Define volume for persistent data
VOLUME /var/lib/monetdb

# Copy initialization script
COPY init-monetdb.sh /init-monetdb.sh

# Make the script executable
RUN chmod +x /init-monetdb.sh

# Start the database farm and initialization script when the container launches
CMD [ "sh", "-c", "/init-monetdb.sh" ]