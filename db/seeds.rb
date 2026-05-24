puts "Seeding database..."

# ── Users ──────────────────────────────────────────────────────────────────
def find_or_seed_user(username:, email:, display_name:, bio:)
  User.find_by(username: username) ||
    User.find_by(email: email) ||
    User.create!(
      username: username, email: email,
      display_name: display_name, bio: bio,
      password: "password", password_confirmation: "password"
    )
end

mustafa = find_or_seed_user(username: "mustafa", email: "mustafa@cookbook.com",
                             display_name: "Mustafa", bio: "Home cook. I make what my Mama taught me.")
layla   = find_or_seed_user(username: "layla",   email: "layla@cookbook.com",
                             display_name: "Layla K", bio: "Baking is my therapy. Always flour on my clothes.")
omar    = find_or_seed_user(username: "omar",    email: "omar@cookbook.com",
                             display_name: "Omar", bio: "Grilling enthusiast. Weekends = smoke and fire.")
sara    = find_or_seed_user(username: "sara",    email: "sara@cookbook.com",
                             display_name: "Sara M", bio: "Plant-based cooking that actually tastes good.")

puts "  4 users ready (mustafa=#{mustafa.id}, layla=#{layla.id}, omar=#{omar.id}, sara=#{sara.id})"

# ── Follows ─────────────────────────────────────────────────────────────────
[
  [mustafa, layla], [mustafa, omar], [mustafa, sara],
  [layla, mustafa], [layla, sara],
  [omar, mustafa],  [omar, layla],
  [sara, layla],    [sara, mustafa],
].each do |follower, followed|
  Follow.find_or_create_by(follower_id: follower.id, followed_id: followed.id)
end
puts "  Follows seeded"

# ── Recipes ──────────────────────────────────────────────────────────────────
recipes_data = [
  {
    user: mustafa,
    title: "Mama's Chicken Karahi",
    description: "The recipe that started everything. Rich tomato and spice base, bone-in chicken, finished with fresh ginger and cilantro.",
    base_servings: 4,
    prep_time_mins: 20,
    cook_time_mins: 45,
    status: :published,
    ingredients: [
      { name: "Bone-in chicken pieces", amount: 2,   unit: :whole },
      { name: "Roma tomatoes, chopped", amount: 4,   unit: :whole },
      { name: "Cooking oil",            amount: 0.5, unit: :cup },
      { name: "Garlic paste",           amount: 1,   unit: :tbsp },
      { name: "Ginger paste",           amount: 1,   unit: :tbsp },
      { name: "Cumin seeds",            amount: 1,   unit: :tsp },
      { name: "Red chili powder",       amount: 1,   unit: :tsp },
      { name: "Salt",                   amount: 1,   unit: :tsp },
      { name: "Fresh cilantro",         amount: 0.5, unit: :cup },
      { name: "Julienned ginger",       amount: 2,   unit: :tbsp },
    ],
    steps: [
      "Heat oil in a wok over high heat. Add cumin seeds and let them splutter.",
      "Add garlic and ginger paste. Stir-fry for 1–2 minutes until fragrant.",
      "Add chicken pieces and sear on all sides until lightly browned, about 8 minutes.",
      "Add chopped tomatoes, red chili powder, and salt. Stir well to combine.",
      "Cover and cook on medium heat for 25 minutes, stirring occasionally, until chicken is cooked through and oil separates.",
      "Uncover, raise heat, and cook off excess liquid until gravy is thick and clings to the chicken.",
      "Finish with julienned ginger and fresh cilantro. Serve with naan.",
    ],
  },
  {
    user: mustafa,
    title: "Daal Makhani",
    description: "Slow-cooked black lentils in a buttery tomato cream sauce. Best made the night before.",
    base_servings: 6,
    prep_time_mins: 15,
    cook_time_mins: 120,
    status: :published,
    ingredients: [
      { name: "Whole black lentils (urad dal)", amount: 1,   unit: :cup },
      { name: "Kidney beans (canned, drained)", amount: 0.5, unit: :cup },
      { name: "Butter",                         amount: 4,   unit: :tbsp },
      { name: "Heavy cream",                    amount: 0.5, unit: :cup },
      { name: "Tomato puree",                   amount: 1,   unit: :cup },
      { name: "Onion, finely diced",            amount: 1,   unit: :whole },
      { name: "Garlic cloves, minced",          amount: 4,   unit: :whole },
      { name: "Fresh ginger, grated",           amount: 1,   unit: :tbsp },
      { name: "Garam masala",                   amount: 1,   unit: :tsp },
      { name: "Salt",                           amount: 1,   unit: :tsp },
    ],
    steps: [
      "Soak urad dal overnight. Drain and pressure cook with salt and water for 30 minutes, or simmer for 2 hours until very soft.",
      "In a heavy pot, melt butter over medium heat. Add onion and cook until golden, about 10 minutes.",
      "Add garlic and ginger, cook 2 more minutes. Add tomato puree and garam masala.",
      "Simmer tomato mixture for 10 minutes until it darkens slightly.",
      "Add cooked lentils and kidney beans. Stir in cream. Simmer on lowest heat for 30–60 minutes, stirring often.",
      "Taste and adjust salt. The daal should be rich, creamy, and very thick. Serve with basmati rice or naan.",
    ],
  },
  {
    user: layla,
    title: "Brown Butter Tahini Chocolate Chip Cookies",
    description: "Nutty browned butter meets tahini in these thick, chewy cookies. A little salty, a little sweet — impossible to stop at one.",
    base_servings: 24,
    prep_time_mins: 20,
    cook_time_mins: 12,
    status: :published,
    ingredients: [
      { name: "Unsalted butter",        amount: 226,  unit: :grams },
      { name: "Tahini",                 amount: 0.25, unit: :cup },
      { name: "Brown sugar, packed",    amount: 1.5,  unit: :cup },
      { name: "Large eggs",             amount: 2,    unit: :whole },
      { name: "Vanilla extract",        amount: 2,    unit: :tsp },
      { name: "All-purpose flour",      amount: 2.25, unit: :cup },
      { name: "Baking soda",            amount: 1,    unit: :tsp },
      { name: "Fine sea salt",          amount: 1,    unit: :tsp },
      { name: "Dark chocolate chips",   amount: 1.5,  unit: :cup },
      { name: "Flaky salt for topping", amount: 1,    unit: :tsp },
    ],
    steps: [
      "Brown the butter: melt in a light-colored saucepan over medium heat, stirring constantly, until it smells nutty and milk solids turn golden, about 5–7 minutes. Pour into a large bowl and let cool 10 minutes.",
      "Whisk tahini and brown sugar into the browned butter until smooth. Add eggs one at a time, then vanilla. Whisk vigorously for 2 minutes — the mixture should be glossy.",
      "Fold in flour, baking soda, and salt until just combined. Fold in chocolate chips.",
      "Refrigerate dough for at least 1 hour (overnight is even better).",
      "Preheat oven to 375°F. Scoop 2-tablespoon balls of dough onto parchment-lined baking sheets, spacing 2 inches apart.",
      "Bake 10–12 minutes until edges are set but centers look underdone. Sprinkle with flaky salt immediately.",
      "Cool on pan for 5 minutes before transferring — they firm up as they cool.",
    ],
  },
  {
    user: layla,
    title: "Cardamom Honey Cake",
    description: "A simple, fragrant loaf perfumed with cardamom and floral honey. Wonderful with tea.",
    base_servings: 8,
    prep_time_mins: 15,
    cook_time_mins: 50,
    status: :published,
    ingredients: [
      { name: "All-purpose flour",    amount: 2,   unit: :cup },
      { name: "Honey",                amount: 0.75, unit: :cup },
      { name: "Butter, softened",     amount: 113,  unit: :grams },
      { name: "Large eggs",           amount: 3,    unit: :whole },
      { name: "Whole milk",           amount: 0.5,  unit: :cup },
      { name: "Ground cardamom",      amount: 1.5,  unit: :tsp },
      { name: "Baking powder",        amount: 2,    unit: :tsp },
      { name: "Salt",                 amount: 0.5,  unit: :tsp },
    ],
    steps: [
      "Preheat oven to 350°F. Grease and flour a 9×5 loaf pan.",
      "Beat butter until fluffy, then gradually beat in honey.",
      "Add eggs one at a time, beating well after each addition.",
      "Whisk together flour, cardamom, baking powder, and salt. Add to butter mixture alternating with milk, beginning and ending with flour.",
      "Pour into prepared pan. Bake 45–50 minutes until a toothpick comes out clean.",
      "Cool in pan 10 minutes, then turn out onto a rack. Drizzle with extra honey while still warm.",
    ],
  },
  {
    user: omar,
    title: "Harissa Grilled Chicken Thighs",
    description: "Bone-in thighs marinated in harissa, lemon, and garlic then grilled over direct heat. Crispy skin, juicy inside.",
    base_servings: 4,
    prep_time_mins: 15,
    cook_time_mins: 30,
    status: :published,
    ingredients: [
      { name: "Bone-in skin-on chicken thighs", amount: 4,   unit: :whole },
      { name: "Harissa paste",                  amount: 3,   unit: :tbsp },
      { name: "Olive oil",                      amount: 2,   unit: :tbsp },
      { name: "Lemon, juice and zest",          amount: 1,   unit: :whole },
      { name: "Garlic cloves, minced",          amount: 3,   unit: :whole },
      { name: "Cumin",                          amount: 0.5, unit: :tsp },
      { name: "Salt",                           amount: 1,   unit: :tsp },
    ],
    steps: [
      "Score chicken thighs 2–3 times through to the bone with a sharp knife.",
      "Mix harissa, olive oil, lemon juice and zest, garlic, cumin, and salt. Coat chicken all over, including under the skin. Marinate at least 1 hour, up to overnight.",
      "Set up grill for two-zone cooking. Sear thighs skin-side down over direct heat, 5–6 minutes, until skin is charred in spots.",
      "Flip and move to indirect heat. Close lid and cook until internal temperature reaches 175°F, about 20–25 minutes.",
      "Rest 5 minutes before serving. Great with flatbread and yogurt.",
    ],
  },
  {
    user: sara,
    title: "Roasted Red Pepper & Lentil Soup",
    description: "Silky, smoky, and deeply satisfying. Red lentils cook down into the base while roasted peppers add sweetness and depth.",
    base_servings: 4,
    prep_time_mins: 10,
    cook_time_mins: 35,
    status: :published,
    ingredients: [
      { name: "Red bell peppers",       amount: 3,   unit: :whole },
      { name: "Red lentils, rinsed",    amount: 1,   unit: :cup },
      { name: "Vegetable broth",        amount: 4,   unit: :cup },
      { name: "Onion, diced",           amount: 1,   unit: :whole },
      { name: "Garlic cloves",          amount: 4,   unit: :whole },
      { name: "Olive oil",              amount: 2,   unit: :tbsp },
      { name: "Smoked paprika",         amount: 1,   unit: :tsp },
      { name: "Cumin",                  amount: 0.5, unit: :tsp },
      { name: "Lemon juice",            amount: 2,   unit: :tbsp },
      { name: "Salt",                   amount: 1,   unit: :tsp },
    ],
    steps: [
      "Roast peppers directly over a gas flame or under the broiler, turning occasionally, until charred all over. Place in a covered bowl for 10 minutes, then peel, seed, and roughly chop.",
      "Heat olive oil in a large pot over medium heat. Cook onion until soft, about 5 minutes. Add garlic, paprika, and cumin. Cook 1 minute more.",
      "Add roasted peppers, lentils, and broth. Bring to a boil, then reduce heat and simmer 20 minutes until lentils are completely soft.",
      "Blend until smooth with an immersion blender. Add lemon juice and salt to taste.",
      "If too thick, add more broth. Serve with crusty bread and a drizzle of olive oil.",
    ],
  },
]

recipe_objects = {}

recipes_data.each do |data|
  recipe = data[:user].recipes.find_or_initialize_by(title: data[:title])
  recipe.assign_attributes(
    description:    data[:description],
    base_servings:  data[:base_servings],
    prep_time_mins: data[:prep_time_mins],
    cook_time_mins: data[:cook_time_mins],
    status:         data[:status],
  )

  if recipe.new_record?
    recipe.save!
    data[:ingredients].each_with_index do |ing, i|
      recipe.ingredients.create!(name: ing[:name], amount: ing[:amount], unit: ing[:unit], position: i)
    end
    data[:steps].each_with_index do |instruction, i|
      recipe.steps.create!(instruction: instruction, position: i)
    end
    puts "  Created recipe: #{recipe.title}"
  else
    puts "  Skipping existing recipe: #{recipe.title}"
  end

  recipe_objects[data[:title]] = recipe
end

# ── Saved Recipes ────────────────────────────────────────────────────────────
[
  [mustafa, "Brown Butter Tahini Chocolate Chip Cookies"],
  [mustafa, "Roasted Red Pepper & Lentil Soup"],
  [layla,   "Mama's Chicken Karahi"],
  [layla,   "Harissa Grilled Chicken Thighs"],
  [omar,    "Daal Makhani"],
  [sara,    "Harissa Grilled Chicken Thighs"],
  [sara,    "Brown Butter Tahini Chocolate Chip Cookies"],
].each do |user, title|
  recipe = recipe_objects[title]
  next unless recipe
  SavedRecipe.find_or_create_by(user_id: user.id, recipe_id: recipe.id)
end
puts "  Saved recipes seeded"

puts "Done! #{User.count} users, #{Recipe.count} recipes, #{Follow.count} follows."
