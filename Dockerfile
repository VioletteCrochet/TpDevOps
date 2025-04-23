# Étape 1 : Build avec Maven et JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS builder

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers Maven
COPY pom.xml .
COPY src ./src

# Compiler le projet
RUN mvn clean package -DskipTests

# Étape 2 : Image finale avec JDK 21 uniquement
FROM eclipse-temurin:21-jdk

# Définir le répertoire de travail
WORKDIR /app

# Copier le jar depuis le builder
COPY --from=builder /app/target/*.jar app.jar

# Exposer le port (modifie si nécessaire)
EXPOSE 9090

# Commande de démarrage
ENTRYPOINT ["java", "-jar", "app.jar"]
