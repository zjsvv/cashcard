# Building a REST API with Spring Boot
This repository contains the source code from [Building a REST API with Spring Boot](https://spring.academy/courses/building-a-rest-api-with-spring-boot).

# To build docker image
## Use Jib
### 1. Add the following in the build.gradle
```groovy
jib {
	from {
		image = "eclipse-temurin:21-jdk-alpine"
	}
	to {
		image = "com.example/cashcard"
		tags = [version, 'latest']
	}
	container {
		mainClass = "${group}.Application"
		jvmFlags = ["-Xms${findProperty('MEMORY')?:'256'}m", '-Xdebug']
		ports = ['80']
		volumes = ['/data']
		environment = [
			'VERSION': version,
			'DATA_DIR': '/data',
			'APPLICATION_PORT' : '80',
			'DEVELOPMENT_MODE' : 'false'
		]
	}
}
```
### 2. run
```sh
$ gradle jibDockerBuild
```

## Use Spring Boot Gradle Plugin
check [here](https://docs.spring.io/spring-boot/docs/current/gradle-plugin/reference/htmlsingle) if need customized
```sh
$ gradle bootBuildImage
```

## Use multi-stage Dockerfile
```sh
$ docker build -f Dockerfile -t ex:latest .  --build-arg TARGET_JAR_VERSION=0.0.1-SNAPSHOT
```
