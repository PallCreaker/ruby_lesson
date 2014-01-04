# coding: utf-8
require 'timeout'

def random_words_hit_game()
    p "この問題の説明・・・・・・"
    filename = ARGV[0]                 # コマンドの第1引数を filname に代入
    file = open(filename)              # filname にある名前のファイルを開く
    i = 1
    time = 10
    while fileText = file.gets()           # file から1行読み込み
        message = nil
        i += 1
        hint_count = 1
        problem = fileText.split(",")
        qestion_words = problem[0].split(//).shuffle
        p "第#{i}問。以下の語を並べ替えて、意味のある英単語にしなさい"
        qestion_words.each do |word|
            print " #{word} "
        end
        puts "\n"
        begin
            timeout(time){
                while message != "good!"
                    a_words = STDIN.gets()
                    if a_words.chomp == problem[0]
                        puts message = "good!"
                    elsif hint_count > 2
                        p "もうヒントはありません"
                    else
                        p "はずれです。ヒントを見ますか?見る方は'yes'を見ない方は'no'を入力してください。"
                        hint_if = STDIN.gets()
                        if hint_if.chomp == "yes"
                            p "これで最後のヒントです。" if hint_count == 2
                            p "ヒントは #{problem[hint_count].chomp}"
                            hint_count += 1
                        elsif hint_if.chomp == "no"
                            next
                        else
                            p "yes か no でお願いします。"
                        end
                    end
                end
            }
        rescue Timeout::Error
            puts "Timeout!"
        end
    end

    p "終了！"
    p "あなたの正解率は？"
    file.close                        # ファイルを閉じる
end

random_words_hit_game()
