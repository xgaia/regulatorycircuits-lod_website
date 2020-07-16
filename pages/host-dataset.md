<!--
.. title: Host dataset
.. slug: host-dataset
.. date: 2020-07-16 14:42:27 UTC+02:00
.. tags: 
.. category: 
.. link: 
.. description: 
.. type: text
.. hidetitle: true
-->

The LOD SPARQL endpoint can be deployed on your server following this documentation.

## Download RDF data

Create a new directory and download the nquads from the website.

```bash
mkdir nquads && cd nquads
wget -p -r --reject="*.html*,*.txt*,*.tmp*" -nH -nd https://regulatorycircuits-lod.genouest.org/dumps/
```

## Host the LOD endpoint with docker

- Pull [virtuoso docker image](https://github.com/askomics/docker-virtuoso)

```bash
docker pull askomics/virtuoso:7.2.5.1
```

- Run a docker container and mount the directory containing the `.nq.gz` files into the container `ToLoad` directory (replace `/path/to/nquads` with the real path).

```bash
docker run -d --name virtuoso-lod -p 8890:8890 -v /path/to/nquads:/usr/local/virtuoso-opensource/var/lib/virtuoso/db/toLoad askomics/virtuoso:7.2.5.1
```

Virtuoso will load all nquads files and expose the SPARQL endpoint at [localhost:8890/sparql](http://localhost:8890/sparql).
