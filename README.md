# **TP1 Créer des VM sur GCP à l'aide de Terraform et déployer une application Wordpress dans ces VM avec Ansible**#

## **Compétence visée au titre RNCP Administrateur Devops: Automatiser le déploiement d'une infrastructure dans le cloud**

### **Arborescence des [répertoires] et fichiers:** 

* [Ansible]  
  - [templates]  
    - wordpress.conf.j2
  - ansible.cfg
  - gcp_compute.yml
  - group_vars.yml
  - playbook_database.yml
  - playbook_wordpress.yml  
 
* [Terraform]  
  - main.tf  

* deploiement.sh  

### **Pré requis:**

-> Avoir un compte GCP associé à un compte de facturation ou bénéficier
pour la première fois de l'essai des 300$ offerts.  

-> Activer l'éditeur Cloud Shell pour définir l'arboresence du code 
et ouvrir le terminal gcloud CLI.  

### **Schéma de présentation du déploiement:** 
1. Cloner le dossier TP1_VM_WORDPRESS
2. Se placer dans le dossier cloné cd TP1_VM_WORDPRESS
3. Modifier les variables USER, PROJET et ZONE dans le fichier déploiement.sh
4. Modifier la varibale projects dans Ansible/gcp_compute.yml 
5. Modifier ou non les variables bd_user, db_pass, db_name dans Ansible/group_vars.yml 
6. Se placer à la racine du dossier parent TP1_VM_WORDPRESS et lancer le script d'excécution : sh deploiement.sh
7. Attendre quelques minutes pour que le script soit entièrement exécuté, puis
copier l'adresse IP pour la coller dans un navigateur. Le nom d'utilisateur à indiquer 
dans la page web Wordpress est le nom de l'utilisateur de la VM Wordpress. 
Suivre les étapes de configuration et entrer les valeurs des variables db_user, db_pass et bd_name
pour accéder à la base de données ainsi que le mot de passe qui sera générer. 





