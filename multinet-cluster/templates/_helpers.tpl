
{{/*
Environment prefix for the host
*/}}
{{- define "env-prefix-host" -}}
{{- $environment := default "dev" .Values.environment }}
{{- if eq $environment "dev" -}}
{{- "dev." -}}
{{- end -}}
{{- if eq $environment "staging" -}}
{{- "staging." -}}
{{- end -}}
{{- end }}

{{/*
Environment prefix for the secret
*/}}
{{- define "env-prefix-secret" -}}
{{- $environment := default "dev" .Values.environment }}
{{- if eq $environment "dev" -}}
{{- "dev-" -}}
{{- end -}}
{{- if eq $environment "staging" -}}
{{- "staging-" -}}
{{- end -}}
{{- end }}

