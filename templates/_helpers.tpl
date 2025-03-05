{{/*
Nombre base para los recursos.
*/}}
{{- define "rollout-k8s.name" -}}
{{- if .Values.nameOverride }}
  {{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Nombre completo del recurso.
*/}}
{{- define "rollout-k8s.fullname" -}}
{{- if .Values.fullnameOverride }}
  {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- $name := include "rollout-k8s.name" . }}
  {{- if contains .Release.Name $name }}
    {{- .Release.Name | trunc 63 | trimSuffix "-" }}
  {{- else }}
    {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
  {{- end }}
{{- end }}
{{- end }}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rollout-k8s.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rollout-k8s.labels" -}}
helm.sh/chart: {{ include "rollout-k8s.chart" . }}
{{ include "rollout-k8s.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rollout-k8s.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rollout-k8s.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rollout-k8s.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
  {{- default (include "rollout-k8s.fullname" .) .Values.serviceAccount.name }}
{{- else }}
  {{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

