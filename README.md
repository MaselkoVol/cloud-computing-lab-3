# Лабораторна робота №3: Розгортання інфраструктури за допомогою Terraform

Цей проєкт автоматизує створення віртуальної приватної мережі (VPC) та розгортання веб-сервера Apache на базі Ubuntu в Google Cloud Platform (GCP).

## Передумови (Prerequisites)

- Встановлений [Terraform](https://www.terraform.io/downloads).
- Встановлений та налаштований Google Cloud CLI (\`gcloud auth application-default login\`).
- Створений GCS Bucket для збереження віддаленого стану (\`tf-state\`).

## Використання

1. \`terraform init\` — ініціалізація робочого простору та завантаження плагінів провайдера.
2. \`terraform plan\` — перегляд змін, які будуть застосовані до інфраструктури.
3. \`terraform apply\` — розгортання інфраструктури у хмарі.
4. \`terraform destroy\` — видалення всіх створених ресурсів.
