FROM jupyter/base-notebook:python-3.11.4
USER root
RUN fix-permissions /etc/jupyter/
WORKDIR /app
COPY requirements.txt .

RUN pip install --quiet --no-cache-dir -r requirements.txt && \
 fix-permissions "${CONDA_DIR}" && \
 fix-permissions "/home/${NB_USER}"

COPY . /app/
ENV PYTHONPATH=/app/src
RUN python src/preparation.py
CMD ["jupyter", "notebook", "--allow-root", "--ip='*'", "--NotebookApp.token='token'"]
