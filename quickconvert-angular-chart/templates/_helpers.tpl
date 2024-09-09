{{/*
Create the name of the application using release name and chart name.
*/}}
{{- define "quickconvert-angular-app.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fully qualified name for resources.
*/}}
{{- define "quickconvert-angular-app.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "quickconvert-angular-app.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a name for the deployment.
*/}}
{{- define "quickconvert-angular-app.deploymentName" -}}
{{- printf "%s-deployment" (include "quickconvert-angular-app.fullname" .) -}}
{{- end -}}
