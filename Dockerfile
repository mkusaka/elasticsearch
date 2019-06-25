FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.7.1

RUN elasticsearch-plugin list \
 && elasticsearch-plugin install --batch analysis-icu \
 && elasticsearch-plugin install --batch analysis-kuromoji

ENV ES_JAVA_OPTS="-Xms256m -Xmx256m" \
    bootstrap.memory_lock="true" \
    cluster.name="docker-cluster" \
    discovery.type="single-node" \
    http.host="0.0.0.0" \
    indices.breaker.fielddata.limit="50%" \
    indices.fielddata.cache.size="40%" \
    logger.deprecation.level="warn" \
    transport.host="127.0.0.1"

HEALTHCHECK --interval=10s --timeout=30s --retries=10 CMD curl --ipv4 --fail http://127.0.0.1:9200/_cluster/health || exit 1
