# 概要
JSONテンプレートエンジン。
OutputToDeviceメソッドを実行することで、XDATA に記述されたjsonテンプレートにプロパティ値を挿入し、結果のJSONデータを標準出力に出力します。

# プロパティ値の記載方法

## \#(..プロパティ名)\#
プロパティ値を挿入します。
プロパティがJSONTemplate.Baseを継承している場合、そのクラスのテンプレートを元にしたJSONデータを出力します。
プロパティがlist形式の場合、JSON配列となり、その要素にプロパティ値が挿入されます。

## \#($this)\#
現在のインスタンスで指定されているテンプレートを元にしたJSONデータを出力します

## \#(..プロパティ名(クラス名))\#
プロパティがJSONTemplate.Baseを継承している場合、クラス名で指定したテンプレートを使用し、
プロパティ値をJSON出力します。

## \#(..#パラメータ名)\#
パラメータ値を挿入します。

# 使用方法
## 作成時
2) JSONTemplate.Baseを継承したクラスを作成
3) Templateをオーバーライドし、JSONテンプレートを作成
4) 挿入したいデータに合わせてプロパティを作成

## 使用時
1) 作成したクラスのインスタンスを作成
    set obj=##class(テンプレートクラス名).%New()

    以下のように%New()のパラメータに%DynamicObjectを設定することで、各プロパティに値を代入することも可能です。
    この場合、プロパティに存在しないキーを指定すると、その内容は無視されます。

    set obj=##class(テンプレートクラス名).%New({"code":"A001","display":"テストコード"})

2) プロパティに値を設定
    プロパティには指定されたクラスのインスタンスだけでなく%DynamicObjectも使用できますので、
    set obj.Property={"param1":"xxxx","param2": "yyy"}
    といった記述も可能です。
3) OutputToDevice、OutputToFile、OutputToDeviceメソッドを実行


# 収録クラス

## JSONTemplate.Base
テンプレートの基底クラス

## JSONTEmplate.Generator
テンプレート出力メソッドの生成クラス

## FHIRTemplate.ResourceBase
FHIRTemplate基底クラス

## FHIRTemplate.Resource
FHIRリソース基底クラス

## FHIRTemplate.Bundle
Bundleリソース出力クラス

## FHIRTemplate.Bundle.entry
Bundleリソースのentryプロパティで参照先のリソースのuuidとその実体を出力するクラス

## FHIRTemplate.Composition
Compositionリソース出力クラス

## FHIRTemplate.DataType.CodeableConcept
CodableConcept出力クラス

## FHIRTemplate.Patient
患者リソース出力クラス
