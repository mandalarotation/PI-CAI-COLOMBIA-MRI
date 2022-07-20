FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu18.04

ENV X=3
ENV Y=8
ENV Z=13

RUN apt-get update -y && \
	DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata && \
	apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
	libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
	xz-utils tk-dev libffi-dev liblzma-dev git && \
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
	export PATH=$HOME/.pyenv/bin:$PATH && \
	echo "export PATH=$HOME/.pyenv/bin:$PATH" >>  ~/.bashrc && \
	pyenv install $X.$Y.$Z && \
	PYENVPATH=$HOME/.pyenv/versions/$X.$Y.$Z && \
	echo "export PATH=$PATH:$PYENVPATH/bin" >> ~/.bashrc && \
	echo "export PYTHONPATH=$PYENVPATH/lib/python$X.$Y/site-packages" >> ~/.bashrc && \
	echo "export PATH=$PATH:$PYENVPATH/bin" >> ~/.profile && \
	echo "export PYTHONPATH=$PYENVPATH/lib/python3.8/site-packages" >> ~/.profile && \
	export PATH=$PATH:$PYENVPATH/bin && \ 
	export PYTHONPATH=$PYENVPATH/lib/python$X.$Y/site-packages && \
	# Only cuda 11.0 
	# echo "ln -s /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcusolver.so.10 /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcusolver.so.11" >> ~/.bashrc && \
	echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc && \
	# Only cuda 11.0
	# echo "ln -s /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcusolver.so.10 /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcusolver.so.11" >> ~/.profile && \
	echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH" >> ~/.profile && \
	pip install jupyter jupyterlab
	 


CMD  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH && \
	# Only cuda 11.0
	# ln -s /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcusolver.so.10 /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcusolver.so.11
 	export PATH=$PATH:$HOME/.pyenv/versions/$X.$Y.$Z/bin && \
	export PYTHONPATH=/root/.pyenv/versions/$X.$Y.$Z/lib/python$X.$Y/site-packages && \
	jupyter lab --port=8888 --no-browser --ip=0.0.0.0 --allow-root










