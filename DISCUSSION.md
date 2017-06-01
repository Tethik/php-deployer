# Discussion
Here I'm writing down some of my thoughts and ideas for this mini project.

## Problems
### Caching 
Right now docker will cache the git clone and not detect changes upstream unless you use a new value every run for the build argument **BUILD_ID**.
This is why I use $RANDOM. 

Optimal behaviour would be if we could invalidate the cache when there is a new version.

[A thread on stackoverflow suggests the following.](https://stackoverflow.com/questions/36996046/how-to-prevent-dockerfile-caching-git-clone)
```
ADD https://api.github.com/repos/$USER/$REPO/git/refs/heads/$BRANCH version.json
```

However problem is that I am using ssh authentication on a private github repository. This only works with https and token authentication. 
I also would not have this problem if I used a public repo.

#### Potential Solutions
1. Add timestamp / random bit to command or file in the dockerfile to invalidate cache for anything after it. Con: always clones the repo regardless if there is new content or not.

2. Proxy to external server returning a similar thing to githubs api, i.e. the latest commit hash or similar. Use "ADD" on this url. Con: adds dependency on this external service.

3. Clone repository locally before dockerfile, check version. But then we can also skip cloning inside the build.


### Authentication credentials
Authentication details should preferably not be stored in a git repository. For demo purposes I will put ssh details in the `credentials` folder.

#### Potential Solutions
Try out vault and see if I can somehow store my details there. Question is if it can store ssh details in a meaningful way in terms of security.

## Potential features to add
Some ideas which could improve the dockerfile.

## PHP package installer
It would perhaps be nice to automatically also install dependencies that the PHP target repo may have. I think composer is the norm here.

## Github token authentication 
I chose to not use this because I don't want to have/give away a token with write access and acceess to my other repos. Github does afaik not provide a way of creating 
a token with access only to the target repo.

An alternative would be to create a completely new bot account and use the token from that.

Either way, it would also require some extra commands in the dockerfile. Easy way is probably to copy files into the `~/.git/` directory.

## Subpath
In case the root directory of the target git repository does not contain the code we could add an option to use a subpath to copy the php files into the web root directory. 
This could also be made automatic using some directory traversal.