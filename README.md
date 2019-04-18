# docker-stacklift-runner

## Build

```
$ docker build -t syginc/stacklift-runner -f python3.7/Dockerfile .
```

## Usage

Stacklift config template file location is `/work/config.in.yaml`.

### Validate stacklift config files

```
$ /validate-configs.sh <archive_location> <config_dir>
```

### Validate emrichen environment files

```
$ /validate-envs.sh <archive_location> <env_dir>
```

### Deploy

```
$ /start-deploy.sh <archive_location> <env_file> <group1> [<group2> ...]
```

### Deploy via codebuild

```
$ /start-codebuild.sh <archive_location> <env_file> <s3_path> <project_name> [<codebuild_param> ...]
```
