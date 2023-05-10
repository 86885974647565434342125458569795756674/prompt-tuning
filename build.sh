#!/bin/bash

# Copyright 2022 The T5X Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

echo "Ensure you run this script from the top-level directory of the repo"

CONTAINER="prompt-tuning"

#添加到Shell的参数个数
if [ $# -eq 1 ]
then
    echo $1
    CONTAINER=$1
else
    echo "Usage: bash build <container name>"
    exit
fi

# building container here 
#build 命令的 PATH 或 URL 指定的路径中的文件的集合。在镜像 build 过程中可以引用上下文中的任何文件，比如我们要介绍的 COPY 和 ADD 命令，就可以引用上下文中的文件。
docker build -t $CONTAINER . -f Dockerfile
