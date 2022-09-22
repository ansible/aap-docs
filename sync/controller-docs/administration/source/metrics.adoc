[[ag_metrics]]
== Metrics

A metrics endpoint is available in the API: `/api/v2/metrics/` that
surfaces instantaneous metrics about the controller, which can be
consumed by system monitoring software like the open source project
Prometheus.

The type of data shown at the `metrics/` endpoint is
`Content-type: text/plain` and `application/json` as well. This endpoint
contains useful information, such as counts of how many active user
sessions there are, or how many jobs are actively running on each
controller node. Prometheus can be configured to scrape these metrics
from the controller by hitting the controller metrics endpoint and
storing this data in a time-series database. Clients can later use
Prometheus in conjunction with other software like Grafana or
Metricsbeat to visualize that data and set up alerts.

=== Set up Prometheus

To set up and use Prometheus, you will need to install Prometheus on a
virtual machine or container. Refer to the
https://prometheus.io/docs/introduction/first_steps/[Prometheus
documentation] for further detail.

[arabic]
. In the Prometheus config file (typically `prometheus.yml`), specify a
`<token_value>`, a valid user/password for a controller user you have
created, and a `<controller_host>`.
+
_______________________________________________________________________________________________________________________________________________________________________________________________
Note

Alternatively, you can provide an OAuth2 token (which can be generated
at `/api/v2/users/N/personal_tokens/`). By default, the config assumes a
user with username=admin and password=password.
_______________________________________________________________________________________________________________________________________________________________________________________________

_________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
--
Using an OAuth2 Token, created at the `/api/v2/tokens` endpoint to
authenticate prometheus with the controller, the following example
provides a valid scrape config if the URL for your controller's metrics
endpoint was `https://controller_host:443/metrics`.

....
scrape_configs

  - job_name: 'controller'
    tls_config:
        insecure_skip_verify: True
    metrics_path: /api/v2/metrics
    scrape_interval: 5s
    scheme: https
    bearer_token: <token_value>
    # basic_auth:
    #   username: admin
    #   password: password
    static_configs:
        - targets: 
            - <controller_host>
....

For help configuring other aspects of Prometheus, such as alerts and
service discovery configurations, refer to the link:[Prometheus
configuration docs].

If Prometheus is already running, you must restart it in order to apply
the configuration changes by making a *POST* to the reload endpoint, or
by killing the Prometheus process or service.

--
_________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

[arabic, start=2]
. Use a browser to navigate to your graph in the Prometheus UI at
`http://your_prometheus:9090/graph` and test out some queries. For
example, you can query the current number of active controller user
sessions by executing: `awx_sessions_total{type="user"}`.

image:metrics-prometheus-ui-query-example.png[image]

Refer to the metrics endpoint in the controller API for your instance
(`api/v2/metrics`) for more ways to query.
