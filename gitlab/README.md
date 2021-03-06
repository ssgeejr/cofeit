# GITLAB Setup Docker Community Edition

https://registry.hub.docker.com/r/gitlab/gitlab-ce/

```
#Community: 
gitlab/gitlab-ce

#Enterprise
gitlab/gitlab-ee

```



https://docs.gitlab.com/omnibus/docker/



The following shows how to change the ports for startup: 

```
web:
  image: 'gitlab/gitlab-ee:latest'
  restart: always
  hostname: 'gitlab.example.com'
  environment:
    GITLAB_OMNIBUS_CONFIG: |
      external_url 'http://gitlab.example.com:8929'
      gitlab_rails['gitlab_shell_ssh_port'] = 2224
  ports:
    - '8929:8929'
    - '2224:22'
  volumes:
    - '$GITLAB_HOME/config:/etc/gitlab'
    - '$GITLAB_HOME/logs:/var/log/gitlab'
    - '$GITLAB_HOME/data:/var/opt/gitlab'
```

Once it starts up - and it does take some time ... create your password. 
To login, use 'root' and '<your password>' 

Create a simple web-app that we can work with: 

mvn archetype:generate \
-DarchetypeGroupId=org.apache.maven.archetypes \
-DarchetypeArtifactId=maven-archetype-webapp \
-DarchetypeVersion=1.4 
