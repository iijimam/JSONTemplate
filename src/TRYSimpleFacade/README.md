# FHIRファサードをIRISで作ってみよう！

このフォルダに含まれるサンプルを利用して、データベースにあるデータからFHIRリソースを作成する流れを簡単に確認することができます。

サンプルでは、以下の情報をデータベースに登録します。

- 患者基本情報（ISJHospital.Patient）
- 患者に紐づく身長・体重の測定値（ISJHospital.Observation）

サンプルでは、RESTサーバ（RESTディスパッチクラス）を用意していて、エンドポイント（/facade）に **/Patient/患者番号** を指定したGET要求を行うと、ISJHospital.Patientテーブルを検索し、取得できた情報からFHIRのPatientリソースを作成し、返送します。
また、エンドポイント（/facade）に **/Patient/患者番号/everything**　を指定したGET要求を行うと、ISJHospita.PatientテーブルからPatientリソースを作成し、患者に紐づく身長・体重測定データからObservationリソースを作成し、Bundleリソースに詰め合わせた結果を返送します。


## 使用方法
**JSONテンプレートエンジン** がIRISにインポートされている状態でお試しください。

以下フォルダの[Import and Compile]を行ってください。

- [JSONTemplate](../JSONTemplate)
- [FHIRTemplate](../FHIRTemplate)

または、**管理ポータル > システムエクスプローラ > クラス > ネームスペースを選択したあと**「インポート」ボタンからファイル[テンプレートエンジン＆基底クラス一式.xml](./テンプレートエンジン＆基底クラス一式.xml)を指定してインポートしてください（このXMLファイルは体験に必要な基本クラスのみをインポートします）。



- 1) 患者基本情報、患者に紐づく身長・体重の測定値のデータインポート

    IRISの **管理ポータル > システムエクスプローラ > SQLメニュー** を開き、任意のネームスペースに移動します。
    クエリ実行タブで[Table.sql](./ISJHospital/Table.sql) にあるSQL文を1文ずつ実行してください。

    以下のLOAD DATA FROM FILE以降に指定しているファイル：[InputDataPatient.csv](./ISJHospital/InputDataPatient.csv) は、フルパスで指定する必要があります。
    実行環境に合わせ変更後ご利用ください。（[InputDataLabTest.csv](./ISJHospital/InputDataLabTest.csv)のLOAD DATAについても同様にご変更ください。）
    ```
    LOAD DATA FROM FILE '/home/irisowner/InputDataPatient.csv'
    INTO ISJHospital.Patient
    USING {"from":{"file":{"charset":"UTF-8"}}}
    ```

- 2) コンパイル
    [FHIRCustom](./FHIRCustom)フォルダ以下クラスをコンパイルします。
    フォルダを右クリックし、[Import and Compile]をクリックしてください。

    [FHIRFacade](./FHIRFacade)フォルダも同様にコンパイルを実施してください。


- 3) MEDISの看護実践用語標準マスターのインポート
    [FHIRCustom.DB.BodyMeasurementCode](./FHIRCustom/DB/BodyMeasurementCode.cls)にデータをインポートします。

    インポートデータは、MEDISが公開している以下ページよりダウンロードください。

    https://www2.medis.or.jp/master/kango/index.html
    https://www2.medis.or.jp/master/kango/kansatsu/kansatsu-ver.3.6.txt

    ダウンロード後、IRISにログインし、クラス定義をインポートしたネームスペースに移動した後、以下実行します。

    以下の例は、TESTネームスペースにソースコードをインポートした状態で試しています。
    また、ダウンロードしたファイルを　/home/irisowner/　以下に配置した状態で試しています。
    （ファイル名はフルパスで指定してください。）
    ```
    set $namespace="TEST
    write ##class(FHIRCustom.DB.BodyMeasurementCode).ImportData("/home/irisowner/kansatsu-ver3.6.txt")
    ```

    データがインポートできたかどうかは、SQLで確認できます。
    ```
    SELECT * FROM FHIRCustom_DB.BodyMeasurementCode
    ```

- 4) エンドポイントの作成（/facade）

    管理ポータル > システム管理 > セキュリティ > アプリケーション > ウェブ・アプリケーション で「新しいウェブ・アプリケーションを作成」ボタンをクリックします。

    図のように設定してください。
    ![](./webappppath.png)


- 5) RESTクライアントからGET要求実行！
    
    http://127.0.0.1:52773/facade/Patient/498374

    http://127.0.0.1:52773/facade/Patient/498374/everything

