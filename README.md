# php-deployer
Takes arbitary php git repo and attempts to run it in docker.

```bash
docker build --build-arg GITHUB_URI="git@github.com:Tethik/healthcheck.git" -t php-app . 
```

```bash
docker run --env-file environment_variables -p 80:80 --dns 205.251.197.132 php-app
```


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
