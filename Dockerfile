FROM redis:latest

RUN apt-get -y update
RUN apt-get install -y wget unzip tar cmake 

RUN CD /tmp \
    && wget https://github.com/RedisLabsModules/RediSearch/archive/v0.19.3.tar.gz \
    && tar -xvzf v0.19.3.tar.gz \
    && cd RedisSearch-0.19.3 \
    && make all 

USER redis 

CMD ["redis-server", "--appendonly", "yes", "-requirepass", "glasgoware", "--loadmodule", "//RediSearch-0.19.3/src/redisearch.so"]