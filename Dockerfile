FROM gradle:7.6-jdk17 as builder

WORKDIR /app

COPY ./ ./

RUN gradle clean build --no-daemon

# APP
FROM openjdk:17.0-slim

WORKDIR /app

# 타임존을 한국(KST)으로 설정
RUN apt-get update && apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean

# 빌더 이미지에서 jar 파일만 복사
COPY --from=builder /app/build/libs/daboa-1.0.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
