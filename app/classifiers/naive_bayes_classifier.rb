class NaiveBayesClassifier
  TRAINING_DATA = [
      { klass: 'greeting', sentence: 'how are you?' },
      { klass: 'greeting', sentence: 'can we talk tomorrow?' },
      { klass: 'greeting', sentence: 'Hello, are you bot?' },
      { klass: 'greeting', sentence: 'can we see each other today?' },
      { klass: 'greeting', sentence: 'Hi, are you a human?' },
      { klass: 'greeting', sentence: 'how is your day?' },
      { klass: 'greeting', sentence: 'Good morning, can you help me?' },
      { klass: 'greeting', sentence: 'good day' },
      { klass: 'greeting', sentence: 'how is it going today?' },
      { klass: 'goodbye', sentence: 'have a nice evening' },
      { klass: 'goodbye', sentence: 'bye' },
      { klass: 'goodbye', sentence: 'goodbye, have a good night' },
      { klass: 'goodbye', sentence: 'see you soon' },
      { klass: 'goodbye', sentence: 'see you later' },
      { klass: 'goodbye', sentence: 'talk to you soon' },
      { klass: 'help', sentence: 'can you help me' },
      { klass: 'help', sentence: 'I need advice on' },
      { klass: 'help', sentence: 'how can i do this' },
      { klass: 'help', sentence: 'what should I do' },
      { klass: 'help', sentence: 'see you need advise' },
      { klass: 'weather', sentence: 'what is the weather like today' },
      { klass: 'weather', sentence: 'is it raining' },
      { klass: 'weather', sentence: 'will it be sunny tomorrow' },
      { klass: 'weather', sentence: 'it is cold outside' },
      { klass: 'weather', sentence: 'better sit home tomorrow' },
      { klass: 'weather', sentence: 'seems like it is raining' }
  ]

  CORPUS_WORDS = {}
  CLASS_WORDS = {}

  class << self
    def prepare_data
      classes = TRAINING_DATA.map { |d| d[:klass] }.uniq
      classes.each do |c|
        CLASS_WORDS[c] = []
      end
      TRAINING_DATA.each do |d|
        normalize_sentence(d[:sentence]).split(' ').each do |w|
          word = Lingua.stemmer(w).downcase
          if CORPUS_WORDS[word]
            CORPUS_WORDS[word] = CORPUS_WORDS[word] + 1
          else
            CORPUS_WORDS[word] = 1
          end
          CLASS_WORDS[d[:klass]].push(word)
        end
      end
    end

    def normalize_sentence(sentence)
      sentence.downcase.gsub(/[^a-z\s]/i, '')
    end

    def classify(sentence)
      words = normalize_sentence(sentence).split(' ')
      classes = CLASS_WORDS.map { |k, _| k }
      max_score = 0
      klass = ''
      puts "\n" * 10
      puts "class\t\t\tscore"
      puts '-' * 30
      classes.each do |c|
        score = classify_per_class(words, c)
        puts "#{(c + ((' ' * (10-c.length))))}\t\t#{score}"
        if score > max_score
          max_score = score
          klass = c
        end
      end
      puts "\n" * 10
      klass || 'Not classified'
    end

    def classify_per_class(words, klass)
      score = 0
      words.each do |w|
        word = Lingua.stemmer(w)
        if CLASS_WORDS[klass].include? word
          # score += (1.0 / CORPUS_WORDS[word])
          score += 1
        end
      end
      score
    end
  end
end
