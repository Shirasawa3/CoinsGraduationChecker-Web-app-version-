# 卒業要件確認webアプリ（筑波大学coins22生用）

### アプリの概要
このプログラムでは筑波大学coins22生が現在卒業要件をどれくらい満たしているかを確認することができます。  
以前同様のアプリをpythonで作成したことがあるがコマンドライン上でしか実行できず、使い勝手が悪かったためRuby on Railsを用いてweb上で使えるようにしてみました。  
＊他大学の単位認定や英語の単位免除などの例外には対応していません。


### 使用方法
1. twinsより成績のcsvファイル(Shft-JIS)を取得。
2. ファイルを選択し「実行」をクリック。

<img width="923" alt="スクリーンショット 2024-02-14 185129" src="https://github.com/Shirasawa3/CoinsGraduationChecker-Web-app-version-/assets/156413299/037e4610-ecb7-477b-9934-63ecce2bd94c">  

### 実行結果
【卒業要件】の欄に卒業に必要な単位のうち、取得済みの単位数が表示されます。  
【詳細】の欄に科目ごとの詳細が表示され、どの科目が何単位足りていないかが一目でわかるようになっています。

<img width="923" alt="image" src="https://github.com/Shirasawa3/CoinsGraduationChecker-Web-app-version-/assets/156413299/0a9e8f4d-b5fe-4910-b46c-c452a96ff424">
