FactoryBot.define do
  factory :section do
    sequence(:title) { |n| "Title #{n}" }
    content { 'Content' }
    content_markdown { write_markdown }
    status { 'A' }
    icon { 'laptop' }
    sequence(:index) { |n| n }
    event

    trait :inactive do
      status { 'I' }
    end

    trait :other do
      status { 'O' }
      alternative_text { 'other status' }
    end
  end
end

def write_markdown
  <<-MARKDOWN.strip_heredoc
        # Effugiam erit cinerem tenuere concurrere
        ## Mihi persequar et trementi muris constant tibique
        Lorem markdownum, abstulerunt preces prima. Ripas et concipit **genuit**.
  MARKDOWN
end
