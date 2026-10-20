# Полные логи тестирования pgbench

## Этап 1 (Низкая нагрузка: 10 клиентов, 1000 транзакций)

### Запрос к таблице

latency average = 0.707 ms
initial connection time = 1334.352 ms
tps = 14149.294870 (without initial connection time)

### Запрос к VIEW

latency average = 0.744 ms
initial connection time = 1133.740 ms
tps = 13434.540203 (without initial connection time)

## Этап 2 (Высокая нагрузка: 90 клиентов, 10000 транзакций)

### Запрос к таблице

latency average = 7.135 ms
initial connection time = 9960.922 ms
tps = 12614.682709 (without initial connection time)

### Запрос к VIEW

latency average = 6.930 ms
initial connection time = 9305.188 ms
tps = 12986.433189 (without initial connection time)
