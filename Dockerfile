# JDK 17 slim 이미지 사용
FROM openjdk:17-jdk-slim

# 작업 디렉토리 설정
WORKDIR /app

# 타임존을 한국(KST)으로 설정
RUN apt-get update && apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean

# 빌드된 JAR 복사
COPY build/libs/*.jar app.jar

ENV SPRING_PROFILES_ACTIVE=develop

# 실행 명령어
ENTRYPOINT ["java", "-jar", "app.jar"]
