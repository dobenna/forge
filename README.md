# Forge

> Personal Linux Workstation Provisioning Framework

Forge es un framework modular desarrollado para aprovisionar, configurar y mantener estaciones de trabajo Linux orientadas a DevOps, Cloud, Automatización y Desarrollo.

Nació durante la construcción de **Legolas**, una estación de trabajo basada en Debian 12, pero fue diseñado para poder reutilizarse en cualquier equipo Linux compatible.

---

# Objetivos

* Automatizar la configuración de una estación de trabajo.
* Mantener una estructura modular y fácilmente extensible.
* Evitar configuraciones manuales repetitivas.
* Versionar toda la infraestructura personal.
* Servir como laboratorio para practicar buenas prácticas DevOps.

---

# Características

* Arquitectura modular basada en roles.
* Configuración centralizada.
* Librerías reutilizables.
* Instalación selectiva o completa.
* Proyecto completamente versionable mediante Git.
* Pensado para crecer sin modificar el núcleo del framework.

---

# Estructura del proyecto

```text
forge/
│
├── install.sh              # Orquestador principal
├── bootstrap.sh            # Inicialización del framework
├── config.sh               # Configuración global
│
├── roles/
│   ├── 10-base.sh
│   ├── 20-git.sh
│   ├── 30-docker.sh
│   ├── 40-kubernetes.sh
│   ├── 50-terraform.sh
│   ├── 60-vscode.sh
│   ├── 70-chrome.sh
│   ├── 80-terminal.sh
│   └── 90-verify.sh
│
├── lib/
│   ├── common.sh
│   ├── apt.sh
│   └── system.sh
│
├── logs/
├── tmp/
│
├── README.md
├── LICENSE
└── .gitignore
```

---

# Filosofía

Cada componente tiene una única responsabilidad.

* **roles/** contiene tareas de instalación o configuración.
* **lib/** contiene funciones reutilizables.
* **config.sh** centraliza toda la configuración.
* **install.sh** orquesta la ejecución.

Esto permite que el proyecto pueda crecer durante años sin perder mantenibilidad.

---

# Requisitos

Actualmente Forge está desarrollado para:

* Debian 12 Bookworm
* Bash
* Acceso como root mediante sudo
* Conexión a Internet

---

# Instalación

Clonar el repositorio:

```bash
git clone <REPOSITORIO>
```

Entrar al proyecto:

```bash
cd forge
```

Dar permisos:

```bash
chmod +x install.sh
```

---

# Uso

## Listar roles disponibles

```bash
./install.sh list
```

## Ejecutar un rol

```bash
sudo ./install.sh docker
```

## Ejecutar todos los roles

```bash
sudo ./install.sh all
```

---

# Configuración

Toda la configuración del framework se encuentra en:

```text
config.sh
```

Ejemplos:

* Usuario del sistema
* Configuración de Git
* Zona horaria
* Editor por defecto
* Roles habilitados
* Versiones de componentes

No es necesario modificar los scripts para cambiar la configuración.

---

# Roles actuales

| Rol    | Descripción                            |
| ------ | -------------------------------------- |
| Base   | Instalación de herramientas esenciales |
| Git    | Configuración global de Git            |
| Docker | Instalación y configuración de Docker  |

---

# Roles planificados

* Kubernetes
* Helm
* Kind
* Terraform
* Visual Studio Code
* Google Chrome
* Terminal (Zsh + Powerlevel10k)
* AWS CLI
* Azure CLI
* Ansible
* OpenShift CLI
* K9s
* LazyDocker
* Tailscale
* PostgreSQL
* Redis
* Monitoring
* Verify

---

# Librerías

Las funciones reutilizables están organizadas por responsabilidad.

## common.sh

* log()
* warn()
* success()
* error()

## apt.sh

* apt_update()
* install_packages()
* remove_packages()

## system.sh

* require_root()
* enable_service()
* command_exists()

---

# Principios del proyecto

Forge sigue varios principios de diseño:

* Modularidad
* Simplicidad
* Reutilización
* Configuración centralizada
* Separación entre lógica y configuración
* Idempotencia siempre que sea posible

---

# Roadmap

## Fase 1

* Base
* Git
* Docker

## Fase 2

* Kubernetes
* Terraform
* VS Code
* Chrome

## Fase 3

* Terminal personalizada
* AWS
* Azure
* Ansible

## Fase 4

* Laboratorio Kubernetes
* Observabilidad
* Automatización avanzada

---

# Contribución

Actualmente Forge es un proyecto personal, pero su arquitectura busca seguir buenas prácticas para facilitar futuras mejoras y colaboraciones.

---

# Licencia

MIT License

---

# Autor

**Elba Guerra**

Ingeniera de Sistemas | Linux | DevOps | Automatización | Cloud

---

## Visión

Forge no es solo un conjunto de scripts.

Es una plataforma para construir, mantener y evolucionar una estación de trabajo reproducible, donde cada cambio queda documentado y versionado, permitiendo recrear un entorno completo de desarrollo con un único comando.

