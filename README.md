# Домашнее задание к занятию "`Дипломная работа профессии Системный администратор`" - `Дунаев Дмитрий`

### Сделано:

1. Terraform

resources.tf - разворачиваем хосты:

    sys-29-dw-basthost (через cloud-init ставим ansible)
    sys-29-dw-kibana
    sys-29-dw-zabbix
    sys-29-dw-elas
    sys-29-dw-web1
    sys-29-dw-web2

2. Скриптом записываем в файл их внешние и внутренние адреса для дальнейшей с ними работы.

### Необходимо сделать

3. Подготовка Ansible плейбука для раскатки nginx на веб-серверах.

4. Создание и настройка балансировщика для веб-хостов.

5. Подготовка Ansible плейбука для установки elastic.

6. Подготовка Ansible плейбука для раскатки Zabbix, kibana на хостах.
