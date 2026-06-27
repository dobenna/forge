# Forge Project

## Visión

Forge es un framework personal para provisionar, configurar y mantener estaciones de trabajo Linux orientadas a DevOps, Cloud, Automatización y Desarrollo.

Su objetivo es convertir una instalación Linux limpia en un entorno de trabajo reproducible, documentado y versionado.

---

## Estado actual

Versión actual: 0.1.0

Rama estable: main  
Rama de desarrollo: develop

---

## Filosofía

Forge no instala herramientas de forma aislada.

Forge construye capacidades.

Cada rol debe responder:

- Qué problema resuelve.
- Qué instala o configura.
- Cómo se valida.
- Cómo se mantiene.

---

## Arquitectura

```text
forge/
├── install.sh
├── bootstrap.sh
├── config.sh
├── roles/
├── lib/
├── templates/
├── logs/
├── tmp/
├── README.md
├── PROJECT.md
├── ROADMAP.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── VERSION
└── LICENSE
