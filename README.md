The template structure:
```
.devpanel/              Reserved
|-dumps/
|--db.sql.tgz           Database dump
|--files.tgz            Static files dump
|-.drone.yml            CI/CD
|-config.yml            K8S Pod Template
|-init.sh               Creates application from scratch
|-re-init.sh            Clones application
```