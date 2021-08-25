![Build Badge](https://github.com/aakashsur/docker-salsa/actions/workflows/continuous-integration.yml/badge.svg)

# Salsa in Docker

  [Salsa](https://github.com/marbl/SALSA) is a popular Hi-C scaffolding method. The container is available via Docker Hub.

## Usage

```
# Index assembly.
samtools faidx \
    assembly.fasta

# Bam to bed. 
bedtools bamtobed \
    -i alignment.bam | \
    sort -k 4 > \
    alignment.bed

# Pull image. 
docker pull \
  aakashsur/salsa

# Run salsa.
docker run \
  --rm \
	--volume $PWD:/root/results \
	--workdir $PWD:/root/results \
	aakashsur/salsa \
	salsa \
	-a assembly.fasta \
	-l assembly.fasta.fai \
	-b alignment.bed \
	-e GATC \
	-o scaffolds
```

# Details

  The `salsa` command has been placed in $PATH. Salsa requires an index of the assembly, and a conversion of the alignment bam file into a bed file. Once those are in place, you can run the command and scaffold your assembly.

  To build from scratch - 

```
docker build \
  -t username/salsa:latest \
  path_to_dockerfile
```

For running in an HPC setting, where singularity is often the choice of containerization - 

```
singularity pull \
  docker://aakashsur/salsa
  
singularity run \
	--bind $PWD:/root/results \
	--home $PWD:/root/results \
	~/software/salsa/salsa_latest.sif \
	salsa \
	-a assembly.fasta \
	-l assembly.fasta.fai \
	-b alignment.bed \
	-e GATC \
	-o scaffolds
```
