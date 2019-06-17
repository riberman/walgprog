FactoryBot.define do
  factory :section do
    title { 'The A title' }
    content_markdown { write_markdown }
    status { 'A' }
    icon { 'glass' }
    index { 1 }
    event
  end
end

def write_markdown
  <<-MARKDOWN.strip_heredoc
        # Effugiam erit cinerem tenuere concurrere
        ## Mihi persequar et trementi muris constant tibique
        Lorem markdownum, abstulerunt preces prima. Ripas et concipit **genuit**.
  MARKDOWN
end
