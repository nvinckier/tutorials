#!/bin/bash
#$ -v USER
#$ -e stderr.jupyter.log
#$ -o stdout.jupyter.log
#$ -m abe
#$ -N jupyter
#$ -pe threaded 8
#$ -cwd

function printJupyterURL() {
        JUPYTER_PORT=$(grep -E "^c.(Server|Notebook)App.port" ~/.jupyter/jupyter_notebook_config.py | sed 's/.*= \?//');
        if [[ -z ${JUPYTER_PORT} ]]; then
            JUPYTER_PORT=8888
        fi
        while [[ ! $(qstat | grep -w "jupyter" | awk '{print $5}') == 'r' ]]; do
                sleep 5
                printf "Job \"jupyter\" is not yet running; waiting 5 seconds\n"
        done
        JUPYTER_IP_ADDR=$(nslookup $(qstat | grep -w "jupyter" | awk '{print $8}' | sed 's/.*\@//') | grep Address | tail -n 1 | sed 's/Address: //');
        JUPYTER_ACCESS_URL=$(echo "http://${JUPYTER_IP_ADDR}:${JUPYTER_PORT}/lab");
        echo "${JUPYTER_ACCESS_URL}"
}

WORKING_DIR=/illumina-sdcolo-01/scratch/EIBU-CS/${USER}
cd ${WORKING_DIR}

source ./jupyter/bin/activate
jupyter-lab --no-browser "${@}" 1>> stdout.jupyter.log 2>> stderr.jupyter.log &
printJupyterURL > jupyterURL.txt

while true; do sleep 3600; done