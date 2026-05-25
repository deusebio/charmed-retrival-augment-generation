# Install gpu operator

helm repo add nvidia https://helm.ngc.nvidia.com/nvidia
helm repo update
helm install --generate-name -n gpu-operator-resources --create-namespace nvidia/gpu-operator

# Wait for gpu operator components to be ready
while ! kubectl logs -n gpu-operator-resources -l app=nvidia-operator-validator | grep "all validations are successful"
do
  echo "--------------------------------------------------------------------------------------------------------------------"
  echo "waiting for validations"
  kubectl get pods -n gpu-operator-resources
  sleep 60
  echo "--------------------------------------------------------------------------------------------------------------------"
done
