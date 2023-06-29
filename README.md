# Meteor CircleCI Base Image

## Building Docker image for NodeJS version 14
```bash
docker build . -t meteor/circleci
```
## Building Docker image for NodeJS version 18
```bash
docker build -f DockerfileNode18 . -t meteor/circleci
```

## Publishing `latest` Docker tag
```bash
docker push meteor/circleci
``` 
    
## Publishing specific Docker tag
```bash
docker tag <last-id> meteor/circleci:<newtag>
docker push meteor/circleci:<newtag>
```
