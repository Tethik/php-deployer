# php-deployer
Takes arbitary php git repo and attempts to run it in docker.

```bash
docker build --build-arg GITHUB_URI="git@github.com:Tethik/healthcheck.git" -t php-app . 
```

```bash
docker run --env-file environment_variables -p 80:80 --dns 205.251.197.132 php-app
```

## Caching Problem
Right now docker will cache the git clone and not detect changes upstream.

Optimal behaviour would be if we could invalidate the cache when there is a new version.

https://stackoverflow.com/questions/36996046/how-to-prevent-dockerfile-caching-git-clone 
suggests the following.
```
ADD https://api.github.com/repos/$USER/$REPO/git/refs/heads/$BRANCH version.json
```

However problem is that I am using ssh authentication. This only works with https and token authentication. 
I also would not have this problem if I used a public repo.

### Potential Solutions
1. Add timestamp / random bit to command or file in the dockerfile to invalidate cache for anything after it. Con: always clones the repo regardless if there is new content or not.

2. Proxy to external server returning a similar thing to githubs api, i.e. the latest commit hash or similar. Use "ADD" on this url. Con: adds dependency on this external service.

3. Clone repository locally before dockerfile, check version. (Feels like cheating)

## Alternative solution
https://docs.docker.com/engine/reference/commandline/build/#build-with-url

Instead put a dockerfile at the root of the target repo. 
```bash
docker build github.com/creack/docker-firefox
```

## Existing solution
Someone already created something that would fulfill most of the requirements here:
https://github.com/ngineered/nginx-php-fpm

Although they don't add the git repo at build time.
