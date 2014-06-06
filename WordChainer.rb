require "set"

class WordChainer
    def initialize(dictionary_file_name)
        @dictionary = Set.new
        
        File.foreach(dictionary_file_name) do |word|
            @dictionary.add(word.chomp)
        end
    end
    
    def adjacent_words(word)
        @dictionary.select do |dictionary_word|
            dictionary_word.length == word.length && word_diff(dictionary_word, word) == 1
        end
    end
    
    def word_diff(dictionary_word, word)
        diff_counter = 0
        word.split('').each_with_index do |c, index|
            unless dictionary_word[index] == c
                diff_counter += 1
            end
        end
        diff_counter
    end
    
    def run(source, target)
        if source.length != target.length
            raise "words must the be same length"
        end
        
        @current_words = [source]
        @all_seen_words = { source => nil }
        
        until @current_words.empty?
            new_current_words = explore_current_words
            @current_words = new_current_words
            
            break unless @all_seen_words[target].nil?
        end
        
        build_path(target).reverse
    end
    
    def explore_current_words
        new_current_words = []
        @current_words.each do |current_word|
            adjacent_words(current_word).each do |adjacent_word|
                next if @all_seen_words.include?(adjacent_word)
                
                new_current_words << adjacent_word
                @all_seen_words[adjacent_word] = current_word
            end
        end
        new_current_words
    end
    
    def build_path(target)
        path = [target]
        while true
            previous_word = @all_seen_words[target]
            
            break if previous_word.nil?
            
            target = previous_word
            path << previous_word
        end
        path
    end
end