class NaiveBayesClassifier
  TRAINING_DATA = [
      { klass: 'greeting', sentence: 'Hi, how are you?' },
      { klass: 'greeting', sentence: 'Hello' },
      { klass: 'greeting', sentence: 'what\'s up?' },
      { klass: 'greeting', sentence: 'good morning / day / afternoon' },
      { klass: 'greeting', sentence: 'how is it going' },

      { klass: 'about', sentence: 'are you human or bot' },
      { klass: 'about', sentence: 'what can you do' },
      { klass: 'about', sentence: 'what is your name / purpose' },
      { klass: 'about', sentence: 'tell something about yourself' },

      { klass: 'goodbye', sentence: 'have a nice evening / day' },
      { klass: 'goodbye', sentence: 'thanks, bye' },
      { klass: 'goodbye', sentence: 'goodbye, have a good night' },
      { klass: 'goodbye', sentence: 'see you soon' },
      { klass: 'goodbye', sentence: 'see you later' },
      { klass: 'goodbye', sentence: 'talk to you soon' },
      { klass: 'goodbye', sentence: 'looking forward to hearing from you' },

      { klass: 'help', sentence: 'can you help me' },
      { klass: 'help', sentence: 'I need advice on' },
      { klass: 'help', sentence: 'how can i do this' },
      { klass: 'help', sentence: 'what should I do' },
      { klass: 'help', sentence: 'I have a problem with management' },


      { klass: 'apply_job', sentence: 'want to get this position' },
      { klass: 'apply_job', sentence: 'apply for' },
      { klass: 'apply_job', sentence: 'become a developer' },
      { klass: 'apply_job', sentence: 'is this vacancy free' },
      { klass: 'apply_job', sentence: 'send you my cv' },
      { klass: 'apply_job', sentence: 'What need to apply for this job?' },

      { klass: 'apply_project', sentence: 'I would like to schedule a call to discuss a project' },
      { klass: 'apply_project', sentence: 'I want to develop my idea for my new startup' },
      { klass: 'apply_project', sentence: 'interested to use your mobile development service' }
  ]

  ANSWERS = {
      'greeting': 'Hello, how can I help you?',
      'about': 'I\'m bot based on Naive Bayes classifier',
      'help': 'What can I do for you',
      'apply_job': 'Please, contact our HR managers via this email careers@company.com',
      'goodbye': 'Goodbye'
  }

  # ANSWERS = {
  #     'greeting': 'Hi, can I be useful for you?',
  #     'about': 'I can classify your problem and direct you to the right person.',
  #     'help': 'How can I help you?',
  #     'apply_project': 'Ok, we got your email and phone number. Our Sales Manager will contact you.',
  #     'goodbye': 'Have a good day!'
  # }

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
      puts "class\t\t\t\tscore"
      puts '-' * 40
      classes.each do |c|
        score = classify_per_class(words, c)
        puts "#{(c + ((' ' * (20-c.length))))}\t\t#{score}"
        if score > max_score
          max_score = score
          klass = c
        end
      end
      puts "\n" * 10
      puts klass
      (klass && ANSWERS[klass.to_sym]) || 'Sorry, I didn\'t understand you.'
    end

    def classify_per_class(words, klass)
      score = 0
      words.each do |w|
        word = Lingua.stemmer(w)
        if CLASS_WORDS[klass].include? word
          score += (1.0 / CORPUS_WORDS[word])
          # score += 1
        end
      end
      score
    end
  end
end
