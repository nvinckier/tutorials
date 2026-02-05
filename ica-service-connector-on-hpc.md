# ICA Service Connector on HPC
Instructions for running an ICA Service Connector as a scheduled job on the HPC.

1. Use the links below to download the `qsub-connector.sh` or `sbatch-connector.sh` script for SGE or Slurm, respectively:

	[SGE connector job script](https://ilmn-my.sharepoint.com/:u:/g/personal/nvinckier_illumina_com/IQBQbH5cO8-HRY_PefjRT_TkAWpumvGZSPhgQGUTZoVzWjg?e=XcXwcz).
	[Slurm connector job script](https://ilmn-my.sharepoint.com/:u:/g/personal/nvinckier_illumina_com/IQAZhE-JqXhsSq0RMTqA0kTvAaKa6ln15sGV1MYS6AqWwBY?e=bfXykR).

### Install the connector

1. Log into the HPC via the `ussd-rnd` head node.
```bash
ssh ${USER}@ussd-rnd
```
Alternative login hosts:
`ussd-prd-rdln03`
`ussd-prd-rdln04`

2. Create install directory and upload/download directories as needed for the connector to be run. See the example below.
```bash
mkdir -p /illumina-sdcolo-01/scratch/EIBU-CS/${USER}/ica/{connector,downloads,uploads}
```
3. Follow the instructions on [this page](https://help.ica.illumina.com/project/p-connectivity/service-connector#creating-a-new-connector) to create and install the connector. Be sure to run the installer in headless mode with the command below.
```bash
bash illumina_unix_develop.sh -c
```
4. When asked, provide the desired install location, such as from the example folders created above: 
```bash
/illumina-sdcolo-01/scratch/EIBU-CS/${USER}/ica/connector
```

### Start connector job script

1. Submit the job script to the scheduler.
```bash
qsub qsub-connector.sh             # For SGE systems
sbatch qsub sbatch-connector.sh    # For Slurm systems
```
2. Verify the job is running. The `state` should show as `r` a minute or two after submitting the job.
```bash
qstat -u ${USER}
```
 The connector should stay running indefinitely, but may need an occasional restart. For example, if the HPC needs to stop jobs for maintenance, or an update to the service connector infrastructure requires a connector restart.