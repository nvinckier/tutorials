
# Jupyter on HPC
Instructions for setting up a python environment to run Jupyter on the HPC as a scheduled job and connect via local web browser.

### Set up Python virtual environment

1. Log into the HPC via `ussd-rnd` head node.
```bash
ssh {username}@ussd-rnd
```
Alternative login hosts:
`ussd-prd-rdln03`
`ussd-prd-rdln04`

1. Recommended: start an interactive qlogin during environment setup.
```bash
qlogin
```
1. Navigate to your scratch space (i.e., `/illumina-sdcolo-01/scratch/EIBU-CS/{username}`)
```bash
cd /illumina-sdcolo-01/scratch/EIBU-CS/${USER}
```

1. Create a Python virtual environment with `venv` (in this exampel the environment is named "jupyter").
```bash
python3 -m venv jupyter ./
```

1. Activate the virtual environment.
```bash
source ./jupyter/bin/activate
```

1. Ensure pip is upgraded | 
```bash
pip3 install --upgrade pip
```
### Install and configure JupyterLab in the virtual environment

1. Install jupyterlab using `pip3`
```bash
pip3 install jupyterlab
```

1. Create a config file for jupyter.
```bash
jupyter notebook --generate-config
```

1. Open the config file to edit.
```bash
vim ~/.jupyter/jupyter_notebook_config.py
```

1. Paste the following lines to the top of the above file:
```bash
	c = get_config()
	c.ServerApp.allow_credentials = True
	c.ServerApp.ip = '*'
	c.ServerApp.open_browser = False
	c.ServerApp.port = 10000
```
1. Set a password for access to your implementation of Jupyter server.
```bash
jupyter server password
```

### Run JupyterLab
1. Submit the script to the scheduler.
```bash
qsub qsub-jupyter.sh
```

1. When the job is up and running, a file will be created called `jupyterURL.txt` that will contain the URL to access the jupyter lab instance from a local web browser.

1. To end the job, run the command below.
```bash
qdel {job-ID}
```