# Use a lightweight base image
FROM alpine:latest

# Install required dependencies
RUN apk --no-cache add git build-base cmake libuv-dev libmicrohttpd-dev

# Clone XMRig repository
RUN git clone --single-branch --depth 1 https://github.com/xmrig/xmrig.git /xmrig

# Build XMRig
RUN cd /xmrig && mkdir build && cd build && cmake .. && make

# Set working directory
WORKDIR /xmrig

# Copy configuration file (xmrig config.json)
COPY config.json .

# Expose ports for mining (adjust these according to your XMRig config)
EXPOSE 3333
EXPOSE 5555

# Start XMRig
CMD ["./xmrig", "--config=config.json"]
