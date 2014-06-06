class WordChainer
    def initialize(dictionary_file_name)
        @dictionary =[]
        
        File.foreach(dictionary_file_name) do |word|
            @dictionary << word.chomp
        end
    end
    
    def adjacent_words(word)
        @dictionary.select do |dictionary_word|
            dictionary_word.length == word.length && word_diff(dictionary_word, word) == 1
        end
    end
    
    def word_diff(dictionary_word, word)
        diff_counter = 0
        word.split.each_with_index do |c, index|
            unless dictionary_word[index] == c
                diff_counter += 1
            end
        end
        diff_counter
    end
end