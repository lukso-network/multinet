
{{/*
Environment prefix for the host
*/}}
{{- define "env-prefix-host" -}}
{{- $environment := default "dev" .Release.Namespace }}
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
{{- $environment := default "dev" .Release.Namespace }}
{{- if eq $environment "dev" -}}
{{- "dev-" -}}
{{- end -}}
{{- if eq $environment "staging" -}}
{{- "staging-" -}}
{{- end -}}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "ingress-annotations" -}}
acme.cert-manager.io/http01-edit-in-place: 'true'
cert-manager.io/cluster-issuer: letsencrypt-prod
kubernetes.io/tls-acme: 'true'
kubernetes.io/ingress.class: kong
{{- end }}