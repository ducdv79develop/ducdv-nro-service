# **DUCDV-NRO-SERVICE**  

## **📌 Overview**  
`ducdv-nro-service` is a 2D game server system built with Spring Boot and Vue.js. This project consists of multiple components running on Docker for easy deployment and management.  

### **📌 Main Components**  
- **MySQL Database** (`database`): Stores game data.  
- **Game Server** (`server`): Handles game logic.  
- **Admin API** (`admin-api`): Provides management API.  
- **Admin Console** (`admin-console`): Admin interface running on Nginx.  

---

## **📦 Project Structure**  
```
ducdv-nro-service/
│── ducdv-nro-admin-api/      # Backend API (Spring Boot)
│── ducdv-nro-admin-console/  # Vue.js Admin Console
│── ducdv-nro-java-server/    # Game Server (Spring Boot)
│── ducdv-docker/             # Docker configurations
│   ├── mysql/                # MySQL Docker setup
│   ├── java-server/          # Game server Docker setup
│   ├── admin-api/            # Admin API Docker setup
│   ├── admin-console/        # Nginx + Vue setup
│   ├── admin-console-builder/# Vue build process
│── docker-compose.yml        # Docker Compose configuration
│── .env                      # Environment variables
│── README.md                 # Project documentation
└── ...
```

---

## **🚀 How to Build & Run**  

### **1️⃣ Clone Repository**  
```sh
  git clone https://github.com/ducdv79develop/ducdv-nro-service.git
  cd ducdv-nro-service
```

### **2️⃣ Setup Environment Variables**  
Copy a `.env` from `.env.example` file and configure the settings:  
```
DB_DATABASE=nro
DB_USER=user
DB_PASSWORD=password
DB_ROOT_PASSWORD=root
DB_PORT=3306

SERVER_PORT=8088
APP_CLIENT_PORT=7979
APP_SERVER_PORT=14445

API_SERVER_PORT=8082
NGINX_PORT=8000
```

### **3️⃣ Build & Run with Docker Compose**  
```sh
  docker-compose up --build -d
```
This command will:  
✅ Start MySQL Database  
✅ Build & run the Game Server  
✅ Build & run the Admin API  
✅ Build Vue.js & run the Admin Console on Nginx  

---

## **🔧 Logs & Debugging**  
All logs will be stored in the `logs_data` volume and mounted outside to `/home/user/docker-logs`.  

### **📜 View logs per container**  
```sh
    docker logs -f ducdv-nro-mysql-db
    docker logs -f ducdv-nro-game-server
    docker logs -f ducdv-nro-admin-api
    docker logs -f ducdv-nro-admin-console
```

### **📜 Log storage configuration on the host**  
The log volume is defined in `docker-compose.yml` as follows:  
```yaml
volumes:
  logs_data:
    driver: local
    driver_opts:
      type: none
      device: ${OUTPUT_LOGS_LOCAL:-/home/user/docker-logs}
      o: bind
```
This means logs will be saved to `/home/user/docker-logs`. To change the log storage location, update the `OUTPUT_LOGS_LOCAL` value in the `.env` file.  

---

## **📌 Common Issues & Fixes**  
- **Port conflicts?** Check which ports are in use:  
  ```sh
  netstat -tulnp | grep <port-number>
  ```
- **Database connection issues?** Verify using:  
  ```sh
  docker-compose exec database mysql -u root -p
  ```
- **Vue app not displaying?** Check Nginx logs:  
  ```sh
  docker logs -f ducdv-nro-admin-console
  ```

---

## **🛠️ Useful Commands**  
**Stop all containers:**  
```sh
  docker-compose down
```
**Restart a specific container:**  
```sh
  docker-compose restart <service-name>
```
**Remove all containers and volumes:**  
```sh
  docker-compose down -v
```

---

## **🌍 Access & Usage**  
- **Game Server** runs on: `http://localhost:8088`  
- **Admin Console**: [`http://localhost:8000`](http://localhost:8000)  

---

If you need additional details, feel free to ask! 🚀
