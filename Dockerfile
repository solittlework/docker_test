master:
  image: gettyimages/spark
  command: bin/spark-class org.apache.spark.deploy.master.Master -h master
  hostname: master
  environment:
    MASTER: spark://master:7077
    SPARK_CONF_DIR: /conf
    SPARK_PUBLIC_DNS: localhost
  expose:
    - 7001
    - 7002
    - 7003
    - 7004
    - 7005
    - 7006
    - 7077
    - 6066
  ports:
    - 4040:4040
    - 6066:6066
    - 7077:7077
    - 8080:8080
  volumes:
    - ./conf/master:/conf
    - ./data:/tmp/data

worker:
  image: gettyimages/spark
  command: bin/spark-class org.apache.spark.deploy.worker.Worker spark://master:7077
  hostname: worker
  environment:
    SPARK_CONF_DIR: /conf
    SPARK_WORKER_CORES: 2
    SPARK_WORKER_MEMORY: 1g
    SPARK_WORKER_PORT: 8881
    SPARK_WORKER_WEBUI_PORT: 8081
    SPARK_PUBLIC_DNS: localhost
  links:
    - master
  expose:
    - 7012
    - 7013
    - 7014
    - 7015
    - 7016
    - 8881
  ports:
    - 8081:8081
  volumes:
    - ./conf/worker:/conf
    - ./data:/tmp/data
    - ./app:/app
