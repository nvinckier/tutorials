# ICA Service Connector on HPC
Instructions for running an ICA Service Connector as a scheduled job on the HPC.

1. Download the `qsub-connector.sh` script from the link below:

	[SGE connector job script](https://ilmn-my.sharepoint.com/:u:/g/personal/nvinckier_illumina_com/EY3i05RgbtZIst1RNMIuK0UB0TYnJG7QbGNminsL2pm6dg?e=bw3XS5).

### Install the connector

1. Log into the HPC via the `ussd-rnd` head node.
```bash
ssh ${USER}@ussd-rnd
```
Alternative login hosts:
`ussd-prd-rdln03`
`ussd-prd-rdln04`

1. Create install directory and upload/download directories as needed for the connector to be run. See the example below.
```bash
mkdir -p /illumina-sdcolo-01/scratch/EIBU-CS/${USER}/ica/{connector,downloads,uploads}
```
1. Follow the instructions on [this page](https://help.ica.illumina.com/project/p-connectivity/service-connector#creating-a-new-connector) to create and install the connector. Be sure to run the installer in headless mode with the command below.
```bash
bash illumina_unix_develop.sh -c
```
1. When asked, provide the desired install location, such as from the example folders created above: 
```bash
/illumina-sdcolo-01/scratch/EIBU-CS/${USER}/ica/connector
```

### Start connector job script

1. Submit the job script to the scheduler.
```bash
qsub qsub-connector.sh
```
1. Verify the job is running. The `state` should show as `r` a minute or two after submitting the job.
```bash
qstat -u ${USER}
```
 The connector should stay running indefinitely, but may need an occasional restart. For example, if the HPC needs to stop jobs for maintenance, or an update to the service connector infrastructure requires a connector restart.