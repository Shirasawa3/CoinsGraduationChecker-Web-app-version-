class HomeController < ApplicationController


  def top
  end
  def about
  end

  def main
    grade_list = ['A+', 'A', 'B', 'C', 'P']
    senmonkisoMustList = ["線形代数A", "線形代数B", "微分積分A", "微分積分B", "情報数学A", "専門基礎英語", 
                      "プログラミング入門A", "プログラミング入門B", "コンピュータとプログラミング",
                      "データ構造とアルゴリズム", "データ構造とアルゴリズム実験", "論理回路", "論理回路演習",
                      "線形代数1", "線形代数2", "微積分1", "微積分2"]
    senmonkisoSelectListA = ["確率論", "統計学", "数値計算法", "論理と形式化", "論理システム", "論理システム演習"]
    senmonkisoSelectListB = ["Computer Science in English A", "Computer Science in English B"]
    kisoCommonList = ["ファーストイヤーセミナー", "学問への誘い", "情報リテラシー(講義)", "情報リテラシー(演習)", "データサイエンス",
                    "English Reading Skills I", "English Presentation Skills I",
                    "English Reading Skills II", "English Presentation Skills II"]
    senmonMustList = ["ソフトウェアサイエンス実験A", "ソフトウェアサイエンス実験B", "情報システム実験A", "情報システム実験B",
                    "知能情報メディア実験A", "知能情報メディア実験B", "卒業研究A", "卒業研究B", "専門語学A", "専門語学B"]
    senmonSelectList = ["情報科学特別演習", "情報特別演習I", "情報特別演習II"]
    ngList = ["情報科学I", "情報科学II", "情報メディア理論", "情報理論", "統計学入門", "メディアアート・プログラミング"]

    @kisoCommonMustCount = 0
    @kisoCommonSelectCountA = 0
    @kisoCommonSelectCountB = 0
    @kisoRelationCountA = 0
    @kisoRelationCountB = 0

    @senmonMustCount = 0
    @senmonSelectCountA = 0
    @senmonSelectCountB = 0

    @senmonkisoMustCount = 0
    @senmonkisoSelectCountA = 0
    @senmonkisoSelectCountB = 0
    @senmonkisoSelectCountC = 0
    @senmonkisoSelectCountD = 0
    
    grades = Grade.all
    grades.each do |grade|
#専門基礎科目(必修)の計算
      if senmonkisoMustList.include?(grade.subject_name)
        if grade_list.include?(grade.overall_evaluation)
          @senmonkisoMustCount += grade.unit_count.to_f
        end
#専門基礎科目(選択)の計算
      elsif senmonkisoSelectListA.include?(grade.subject_name)
        if grade_list.include?(grade.overall_evaluation)
          @senmonkisoSelectCountA += grade.unit_count.to_f
        end
      elsif senmonkisoSelectListB.include?(grade.subject_name)
        if grade_list.include?(grade.overall_evaluation)
          @senmonkisoSelectCountB += grade.unit_count.to_f
        end
      elsif grade.subject_number.start_with?("GB1")
        if grade_list.include?(grade.overall_evaluation)
          @senmonkisoSelectCountC += grade.unit_count.to_f
        end
      elsif grade.subject_number.start_with?("GA1") && !senmonSelectList.include?(grade.subject_name)
        if grade_list.include?(grade.overall_evaluation)
          @senmonkisoSelectCountD += grade.unit_count.to_f
        end
#専門科目(必修)の計算
      elsif senmonkisoMustList.include?(grade.subject_name)
        if grade_list.include?(grade.overall_evaluation)
          @senmonMustCount += grade.unit_count.to_f
        end
#専門科目(選択)の計算
      elsif grade.subject_number.start_with?("GB20") || grade.subject_number.start_with?("GB30") or grade.subject_number.start_with?("GB40")
        if grade_list.include?(grade.overall_evaluation)
          @senmonSelectCountA += grade.unit_count.to_f
        end
      elsif grade.subject_number.start_with?("GA4") || grade.subject_number.start_with?("GB2") or grade.subject_number.start_with?("GB3") or grade.subject_number.start_with?("GB4")
        if grade_list.include?(grade.overall_evaluation)
          @senmonSelectCountB += grade.unit_count.to_f
        end
#基礎科目(共通)の計算
      elsif kisoCommonList.include?(grade.subject_name) || grade.subject_name.start_with?("基礎体育", "応用体育")
        if grade_list.include?(grade.overall_evaluation)
          @kisoCommonMustCount += grade.unit_count.to_f
        end
      elsif grade.subject_number.start_with?("12")
        if grade_list.include?(grade.overall_evaluation)
          @kisoCommonSelectCountA += grade.unit_count.to_f
        end
      elsif grade.subject_number.start_with?("32," "33", "34", "35", "36", "37","40", "51", "52")
        if grade_list.include?(grade.overall_evaluation)
          @kisoCommonSelectCountB += grade.unit_count.to_f
        end
#基礎科目(関連)の計算
      elsif grade.subject_number.start_with?("A", "B", "C", "D", "W", "Y") && !ngList.include?(grade.subject_name)
        if grade_list.include?(grade.overall_evaluation)
          @kisoRelationCountA += grade.unit_count.to_f
        end
      elsif grade.subject_number.start_with?("E", "F", "GC", "GE", "H")
        if grade_list.include?(grade.overall_evaluation)
          @kisoRelationCountB += grade.unit_count.to_f
        end
      end

# 最大単位数があるものの調整
      @senmonSelectCountB = [@senmonSelectCountB, 18].min
      @kisoCommonSelectCountB = [@kisoCommonSelectCountB, 4].min
      @kisoRelationCountB = [@kisoRelationCountB, 4].min

# 卒業要件の確認に必要な計算
      @MustCount = @senmonMustCount + @senmonkisoMustCount + @kisoCommonMustCount
      @senmonSelectCount = [@senmonSelectCountA + @senmonkisoSelectCountB, 34].min
      @senmonkisoSelectCount = [@senmonkisoSelectCountA + @senmonkisoSelectCountB + @senmonkisoSelectCountC + @senmonkisoSelectCountD, 26].min
      @kisoCommonSelectCount = [@kisoCommonSelectCountA + @kisoCommonSelectCountB, 5].min
      @kisoRelationCount = [@kisoRelationCountA + @kisoRelationCountB, 10].min
      @SelectCount = @senmonSelectCount + @senmonkisoSelectCount + @kisoCommonSelectCount + @kisoRelationCount
      @sotsugyouCount = @MustCount + @SelectCount
    end
  end

  def upload
    if params[:csv].nil? || params[:csv].blank?
      flash[:alert] = "ファイルが選択されていません"
      redirect_to("/")
      return
    end

    Grade.delete_all
    uploaded_file = params[:csv]
    success = true

    CSV.foreach(uploaded_file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
      unless Grade.create(
        subject_number: row[2],   # 3列目のデータを科目番号として保存
        subject_name: row[3],  # 4列目のデータを科目名として保存
        unit_count: row[4],      # 5列目のデータを単位数として保存
        overall_evaluation: row[7]  # 8列目のデータを総合評価として保存
      )
        success = false
        break
      end
    end
    if success
      redirect_to("/main")
    else
      redirect_to("/")
    end
  end
end