# Meteor CircleCI Base Image

## Building

    docker build . -t meteor/circleci

## Publishing latest
    
    docker push meteor/circleci
    
    
## Publishing tag
    docker tag <last id> <newtag>
    docker push meteor/circleci:<newtag>
