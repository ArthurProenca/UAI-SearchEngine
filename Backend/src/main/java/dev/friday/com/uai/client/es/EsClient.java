package dev.friday.com.uai.client.es;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.json.jackson.JacksonJsonpMapper;
import co.elastic.clients.transport.ElasticsearchTransport;
import co.elastic.clients.transport.rest_client.RestClientTransport;
import nl.altindag.ssl.SSLFactory;
import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.nio.client.HttpAsyncClientBuilder;
import org.elasticsearch.client.RestClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class EsClient {

    @Value("${spring.elasticsearch.username}")
    private String username;

    @Value("${spring.elasticsearch.password}")
    private String password;

    @Value("${spring.elasticsearch.host}")
    private String host;

    @Value("${spring.elasticsearch.port}")
    private Integer port;

    @Value("${spring.elasticsearch.protocol}")
    private String protocol;

    public ElasticsearchClient getConfiguredElasticSearchClient() {
        return new ElasticsearchClient(getConfiguredElasticsearchTransport());
    }

    private ElasticsearchTransport getConfiguredElasticsearchTransport() {
        return new RestClientTransport(
                getConfiguredRestClient(),
                new JacksonJsonpMapper()
        );
    }

    private RestClient getConfiguredRestClient() {
        SSLFactory sslFactory = getConfiguredSSL();

        return RestClient.builder(new HttpHost(host, port, protocol))
                .setHttpClientConfigCallback((HttpAsyncClientBuilder httpClientBuilder) -> httpClientBuilder
                        .setDefaultCredentialsProvider(getConfiguredCredentialProvider())
                        .setSSLContext(sslFactory.getSslContext())
                        .setSSLHostnameVerifier(sslFactory.getHostnameVerifier())
                ).build();
    }

    private CredentialsProvider getConfiguredCredentialProvider() {
        CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
        credentialsProvider.setCredentials(AuthScope.ANY,
                new UsernamePasswordCredentials(username, password));
        return credentialsProvider;
    }

    private SSLFactory getConfiguredSSL() {
        return SSLFactory.builder()
                .withUnsafeTrustMaterial()
                .withUnsafeHostnameVerifier()
                .build();
    }
}
