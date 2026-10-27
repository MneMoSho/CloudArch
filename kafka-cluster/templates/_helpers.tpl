{{- define "podeAntiAffinity" -}}
affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              strimzi.io/cluster: {{ .clusterName}}
              strimzi.io/pool-name: {{ .poolName | default "controller-pool"}} 
          topologyKey: kubernetes.io/hostname

{{- end }}

{{- define "topologySpreadConstraints" -}}
topologySpreadConstraints:
  - maxSkew: 1
    topologyKey: topology.kubernetes.io/zone
    whenUnsatisfiable: DoNotSchedule
    labelSelector:
      matchLabels:
        strimzi.io/cluster: {{ .clusterName }}
        strimzi.io/pool-name: {{ .poolName }}
{{- end }}

{{ define "configRack" }}
config:
  default.replication.factor: 3
  min.insync.replicas: 2
  offsets.topic.replication.factor: 3
  transaction.state.log.replication.factor: 3
  transaction.state.log.min.isr: 2
  auto.create.topics.enable: false
  num.partitions: 6
  log.retention.hours: 168
{{- end }}