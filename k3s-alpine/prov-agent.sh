curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent \\
  --write-kubeconfig-mode 644 \\ 
  --server https://<ip of your server previously installed> \\
  --token=<string copied form the output above>" \\  
  sh -


