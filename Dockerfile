FROM ghcr.io/graalvm/graalvm-ce:22.3.1

RUN microdnf install -y zip unzip libstdc++-static
RUN gu install native-image

COPY pom.xml mvnw ./
COPY .mvn ./.mvn
COPY src ./src
RUN --mount=type=cache,target=/root/.m2 ./mvnw native:compile -Pnative
RUN chmod +x ./target/demo

ENTRYPOINT ["/app/target/demo"]
