# Домашнее задание к занятию 10.7 «Отказоустойчивость в облаке»

 ---

## Задание 1 

Возьмите за основу [задание 1 из модуля 7.3 «Подъём инфраструктуры в Яндекс Облаке»](https://github.com/netology-code/sdvps-homeworks/blob/main/7-03.md#задание-1).

Теперь вместо одной виртуальной машины сделайте terraform playbook, который:

- создаст 2 идентичные виртуальные машины. Используйте аргумент [count](https://www.terraform.io/docs/language/meta-arguments/count.html) для создания таких ресурсов;
- создаст [таргет-группу](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_target_group). Поместите в неё созданные на шаге 1 виртуальные машины;
- создаст [сетевой балансировщик нагрузки](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer), который слушает на порту 80, отправляет трафик на порт 80 виртуальных машин и http healthcheck на порт 80 виртуальных машин.

Рекомендую почитать [документацию сетевого балансировщика](https://cloud.yandex.ru/docs/network-load-balancer/quickstart) нагрузки для того, чтобы было понятно, что вы сделали.

Далее установите на созданные виртуальные машины пакет Nginx любым удобным способом и запустите Nginx веб-сервер на порту 80.

Далее перейдите в веб-консоль Yandex Cloud и убедитесь, что: 

- созданный балансировщик находится в статусе Active,
- обе виртуальные машины в целевой группе находятся в состоянии healthy.

Сделайте запрос на 80 порт на внешний IP-адрес балансировщика и убедитесь, что вы получаете ответ в виде дефолтной страницы Nginx.

*В качестве результата пришлите:*

*1. Terraform Playbook.*

*2. Скриншот статуса балансировщика и целевой группы.*

*3. Скриншот страницы, которая открылась при запросе IP-адреса балансировщика.*

Ответ:

В качестве Terraform Playbook - файлы main.tf и meta.yml.

Скриншот статуса балансировщика и целевой группы: 

![screen1](https://github.com/KorolkovDenis/10.7-YandexCloud-LoadBalancer/blob/main/Screenshots/screen1.jpg)

![screen2](https://github.com/KorolkovDenis/10.7-YandexCloud-LoadBalancer/blob/main/Screenshots/screen2.jpg)

Скриншот страницы, которая открылась при запросе IP-адреса балансировщика:

При запросе в браузере IP-дреса балансировщика 51.250.72.104 нас перекидывает с одного на другой IP (у меня это vm1-192.168.10.19 и vm0-192.168.10.16)

![screen3](https://github.com/KorolkovDenis/10.7-YandexCloud-LoadBalancer/blob/main/Screenshots/screen3.jpg)

Еще раз запросил и мы видим, что IP сменились:

![screen4](https://github.com/KorolkovDenis/10.7-YandexCloud-LoadBalancer/blob/main/Screenshots/screen4.jpg)

Главная страница после создания двух VM и балансировщика:

![screen5](https://github.com/KorolkovDenis/10.7-YandexCloud-LoadBalancer/blob/main/Screenshots/screen5.jpg)

---

## Задания со звёздочкой*
Эти задания дополнительные. Выполнять их не обязательно. На зачёт это не повлияет. Вы можете их выполнить, если хотите глубже разобраться в материале.

---

## Задание 2*

Теперь, вместо создания виртуальных машин, создайте [группу виртуальных машин с балансировщиком нагрузки](https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer).

Nginx нужно будет поставить тоже автоматизированно. Для этого вам нужно будет подложить файл установки Nginx в user-data-ключ [метадаты](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata) виртуальной машины.

- [Пример файла установки Nginx](https://github.com/nar3k/yc-public-tasks/blob/master/terraform/metadata.yaml).
- [Как подставлять файл в метадату виртуальной машины.](https://github.com/nar3k/yc-public-tasks/blob/a6c50a5e1d82f27e6d7f3897972adb872299f14a/terraform/main.tf#L38)

Далее перейдите в веб-консоль Yandex Cloud и убедитесь, что: 

- созданный балансировщик находится в статусе Active,
- обе виртуальные машины в целевой группе находятся в состоянии healthy.

Сделайте запрос на 80 порт на внешний IP-адрес балансировщика и убедитесь, что вы получаете ответ в виде дефолтной страницы Nginx.

*В качестве результата пришлите*

*1. Terraform Playbook.*

*2. Скриншот статуса балансировщика и целевой группы.*

*3. Скриншот страницы, которая открылась при запросе IP-адреса балансировщика.*



## Моя подробная работа в Google:

[Моя работа по «Отказоустойчивость в облаке»](https://docs.google.com/document/d/13Ep3stebpbpCEpgq5j-O9-lcr44UCPqq/edit?usp=share_link&ouid=104113173630640462528&rtpof=true&sd=true)