# Logging in Docker Containers

## Overview
This document explains the purpose of logging, how logs are structured, and how to mount logs from Docker containers to the host system.

## Purpose of Logging
Logs are essential for debugging, monitoring, and analyzing the performance of applications running inside Docker containers. By centralizing logs, we can easily access and manage them outside the container.

## Log Structure
The logs are stored in the following directory inside the container:

```
/var/log/nginx/admin-console/
```

Each container writes logs in its respective subdirectory to keep logs organized and easily identifiable.

## Mounting Logs to Host
To persist logs and make them accessible from the host system, we use Docker volumes. The following volume configuration is used in \`docker-compose.yml\`:

```yaml
volumes:
  logs_data:
    driver: local
  driver_opts:
  type: none
  device: /home/user/docker-logs
  o: bind
```

### Steps to Mount Logs
1. **Ensure the Log Directory Exists**  
   Create the directory on your host machine (e.g., `/home/user/docker-logs`).

   ```sh
   mkdir -p /home/user/docker-logs
   ```

2. **Update `docker-compose.yml`**  
   Define the volume in \`docker-compose.yml\` and mount it in your service configuration:

   ```yaml
   services:
    admin-console:
      volumes:
        - logs_data:/var/log/nginx/admin-console
   ```

3. **Rebuild and Restart Containers**  
   If you've updated the volume, rebuild the container to apply changes:

   ```sh
   docker-compose down -v
   docker-compose up -d
   ```

4. **Verify Logs**  
   Check if logs are being written in the host directory:

   ```sh
   ls -l /home/user/docker-logs
   ```

    ```
    >>> output:
            docker-logs/
                admin-api/
                    *.log
                admin-console/
                    *.log
                mysql/
                    *.log
                java-server/
                    *.log
                error.log
    ```

### Handling Log Rotation
To prevent log files from growing indefinitely, consider setting up log rotation using `logrotate` or configuring Docker's logging driver.  
