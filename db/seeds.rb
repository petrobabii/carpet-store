Carpet.destroy_all

Carpet.create!([
  { title: "Сучасний килим", description: "Стильний килим для вітальні в сіро-білих тонах.", price: 3500.00, stock: 10,
  image_url: "carpet_1.jpg", category: "Кімнатний килим" },
  { title: "Килимова доріжка", description: "Класична килимова доріжка.", price: 7800.00, stock: 4,
  image_url: "carpet_2.jpg", category: "Доріжка" },
  { title: "Дитячий м'який килим", description: "М'який килим для дитячої кімнати.", price: 2200.00, stock: 15,
  image_url: "carpet_3.jpg", category: "Кімнатний килим" },
  { title: "Коротковорсний килим", description: "Простий і практичний килим.", price: 1800.00, stock: 8,
  image_url: "carpet_4.jpg", category: "Кімнатний килим" },
  { title: "Овальний килимок", description: "Невеликий овальний килимок.", price: 950.00, stock: 20,
  image_url: "carpet_5.jpg", category: "Кімнатний килим" },
  { title: "Килим з геометричним малюнком", description: "Сірий килим у прямокутну клітинку.", price: 4100.00, stock: 6,
  image_url: "carpet_6.jpg", category: "Кімнатний килим" },
  { title: "Шерстяний килим", description: "Теплий натуральний килим.", price: 6500.00, stock: 5,
  image_url: "carpet_7.jpg", category: "Кімнатний килим" },
  { title: "Однотонний сірий килим", description: "Звичайний сірий килим без зайвих малюнків.", price: 2900.00, stock: 12,
  image_url: "carpet_8.jpg", category: "Кімнатний килим" },
  { title: "Килим на гумовій основі", description: "Зносостійкий килимок на гумовій основі.", price: 800.00, stock: 25,
  image_url: "carpet_9.jpg", category: "Вхідний килим" },
  { title: "Плетений безворсовий килим", description: "Легкий килимок.", price: 2400.00, stock: 7,
  image_url: "carpet_10.jpg", category: "Кімнатний килим" },
  { title: "Бежевий килим", description: "Теплий бежевий килим для затишку в кімнаті.", price: 3100.00, stock: 9,
  image_url: "carpet_11.jpg", category: "Кімнатний килим" },
  { title: "Килим великого розміру", description: "Просторий килим для великої вітальні.", price: 9200.00, stock: 3,
  image_url: "carpet_12.jpg", category: "Кімнатний килим" },
  { title: "Килимок для ванної", description: "М'який килимок на підлогу.", price: 650.00, stock: 30,
  image_url: "carpet_13.jpg", category: "Килими для ванної" },
  { title: "Килим із довгим ворсом", description: "Пухнастий килим.", price: 4800.00, stock: 6,
  image_url: "carpet_14.jpg", category: "Кімнатний килим" },
  { title: "Кухонний килимок", description: "Компактний килимок довгастої форми.", price: 850.00, stock: 18,
  image_url: "carpet_15.jpg", category: "Доріжка" }
])

puts "Успішно створено #{Carpet.count} килимів!"

User.find_or_create_by!(email_address: "admin@carpetstore.com") do |user|
  user.password = "admin123"
  user.password_confirmation = "admin123"
  user.admin = true
end