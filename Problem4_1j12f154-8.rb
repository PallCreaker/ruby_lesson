# coding: utf-8
require 'timeout'
require 'colored'

def random_words_hit_game( time = 20 )
    puts "\n英単語を当てるゲームです。\n\n英単語の語の順序がバラバラになっているので、それを正しく順番を直して入力してください。\n\nなお、以下の問題は#{time}秒以内に答えてください。間違えるとヒントも少しあります。\n\nそれでは10秒後にスタートします。"
    sleep 10
    filename = ARGV[0]
    file = open(filename)
    i = 1
    miss_count = 0
    qestion_count = 10
    while fileText = file.gets()
        message = nil
        hint_count = 1
        problem = fileText.split(",")
        qestion_words = problem[0].split(//).shuffle
        puts " ### 第#{i}問 ###".yellow
        qestion_words.each do |word|
            print " #{word} ".green
        end
        puts "\n"
        i += 1
        begin
            timeout(time){
                while message != "good!"
                    a_words = STDIN.gets()
                    if a_words.chomp == problem[0]
                        puts message = "good!"
                    elsif hint_count > 2
                        puts "もうヒントはありません"
                    else
                        puts "はずれです。\nヒントを見ますか?見る方は'yes'を見ない方は'no'を入力してください。"
                        hint_if = STDIN.gets()
                        if hint_if.chomp == "yes"
                            puts "これで最後のヒントです。" if hint_count == 2
                            puts "ヒントは #{problem[hint_count].chomp}"
                            hint_count += 1
                        elsif hint_if.chomp == "no"
                            next
                        else
                            puts "yes か no でお願いします。"
                        end
                    end
                end
            }
        rescue Timeout::Error
            puts "Timeout!".red
            miss_count += 1
        end
    end
    ans_rate = ((qestion_count - miss_count) * 100 ) / qestion_count
    puts "終了！"
    puts "あなたの正解率は？\n #{ans_rate} %".red.bold
    file.close
end

random_words_hit_game()
