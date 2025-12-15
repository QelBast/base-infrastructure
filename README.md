# Qelb infrastructure (In early development!)

## Description

My infra with max-automized deploy based on Proxmox + k8s using Packer, Terraform, ArgoCD and other interesting tools

The project was born out of my idea to deploy a local production-level infrastructure.

### Basic principles of development

* Security;
* OSS stack (or at least with free commercial use);
* Without a lot of shitcode;
* Deployment in several primitive actions on the part of the user;

### This is the meta repository of the project

If you're looking for subsidiaries, here's a list of them.:

* Node VM packing - <https://github.com/QelBast/packer-k8s-node-builders>;

## Stages

0) Deploy launch from user-oriented client;
    * 0.1) Cross-platform TUI; ❌
    * 0.2) Cross-platform Desktop app; ❌
    * 0.3) Minimal console cross-platform app based on make commands; ❌
1) Prepare Proxmox for deploy;
    * 1.1) Golden image on Windows (HyperV); ❌
    * 1.2) Golden image on Linux (QEMU); ❌
    * 1.3) Bare-metal __TBA__; ❌
2) Deploy Proxmox;
    * 2.1) Deploy on Windows (HyperV); ❌
    * 2.2) Deploy on Linux (QEMU); ❌
3) Prepare golden image for Kubernetes nodes;
    * 3.1) Ubuntu 24.04; ❌
    * 3.2) Alpine __TBA__; ❌
    * 3.3) Rocky __TBA__; ❌
4) Deploy nodes in Proxmox; ❌
5) Configure nodes by Kubespray __TBA__; ❌
6) Configure nodes by ArgoCD __TBA__; ❌
