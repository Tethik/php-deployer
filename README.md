# php-deployer
Takes arbitary php git repo and attempts to run it in docker.

# Usage
1. Clone the directory.
```bash
git clone https://github.com/Tethik/php-deployer
```

2. Build the docker image.
```bash
docker build --build-arg GITHUB_URI="git@github.com:Tethik/healthcheck.git" \
             --build-arg SSH_CREDENTIALS=credentials/* \
             --build-arg BUILD_ID=$RANDOM \
             --build-arg GIT_SUBDIRECTORY=web/ \
             -t php-app .
```

3. Run the image in a new container
```bash
docker run --env HELLO_WORLD_MSG="from Joakim" -p 80:80 --dns 205.251.197.132 php-app
```

4. Navigate to [http://localhost/web](http://localhost/web)


## Build arguments
The dockerfile takes three build arguments.

**GITHUB_URI**: The url to the git repository.

**SSH_CREDENTIALS**: The local relative path to the ssh credentials used for git authentication. (optional)

**BUILD_ID**: An id used to control cache. Set to e.g. `$RANDOM` to avoid caching the git clone that the Dockerfile performs. (optional)

**GIT_SUBDIRECTORY**: Subdirectory inside the git repository containing the actual code. (optional)

## Other examples

### Building a public git repo
If we want to build a public repo we can skip the **SSH_CREDENTIALS** build argument.
```bash
docker build --build-arg GITHUB_URI="https://github.com/bdart/piibe.git" \
             --build-arg BUILD_ID=$RANDOM \
             -t php-app .
```

## Alternative solution
https://docs.docker.com/engine/reference/commandline/build/#build-with-url

Instead put a Dockerfile at the root of the target repo. Git clone -> docker build instead of repo being built inside the docker image. 
I think this is preferable.

## Existing solution
Someone already created something that would fulfill most of the requirements here:
https://hub.docker.com/r/richarvey/nginx-php-fpm/ (https://github.com/ngineered/nginx-php-fpm)

Although they don't clone the git repo at build time.
