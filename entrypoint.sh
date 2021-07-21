#!/bin/sh
export PATH=$PATH:/root/.local/bin:/usr/local/bin

aws proton --region "$AWS_DEFAULT_REGION" get-service --name "$SERVICE_NAME" | jq -r .service.spec > service.yaml
yq w service.yaml 'instances[*].spec.image' "$IMAGE" > rendered_service.yaml

cat rendered_service.yaml

aws proton --region "$AWS_DEFAULT_REGION" update-service-instance \
           --deployment-type CURRENT_VERSION \
           --name "$SERVICE_INSTANCE_NAME" \
           --service-name "$SERVICE_NAME" \
           --spec file://rendered_service.yaml
