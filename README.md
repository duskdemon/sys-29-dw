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
 _Это не годится, используем для этого имена хостов, поправил файлы ТФ._

3. Подготовка Ansible плейбука для раскатки apache на веб-серверах.
Пробный запуск Ансибл. Плейбук в процессе. Нет выхода в инет с внутренних хостов, нужно настраивать.
 _Поправил настройку сети в конфиге network.tf, выход через nat есть._

4. Подготовка плейбука на локальном хосте для проброса файлов для Ansible на basthost.

5. Подготовка Ansible плейбука для установки elastic.

### Необходимо сделать

6. Создание и настройка балансировщика для веб-хостов.

7. Подготовка Ansible плейбука для kibana, настройка связи с elastic.

8. Подготовка Ansible плейбука для раскатки Zabbix на хостах.

__Список файлов__

/img
    scheme01.png    схема проекта
/templates
    index.html.j2   шаблон файла index.html для веб-серверов

ansible.cfg     конфиг Ансибл
inventory*      файлы инвентори для Ансибл
playbook*       файлы плейбуков для Ансибл
*.tf            файлы конфига терраформ