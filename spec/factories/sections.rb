FactoryBot.define do
  factory :section do
    sequence(:title) { |n| "Title #{n}" }
    content_md { write_markdown }
    alternative_text_md { write_markdown }
    status { 'active' }
    icon { 'fas fa-user' }
    event

    trait :inactive do
      status { 'inactive' }
    end

    trait :alternative do
      status { 'alternative_text' }
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
