# Projeto do Módulo 8 - Análise do dataset "Wine Quality"

 - Objetivo: Este projeto consistiu em uma análise de dados e posterior modelagem para prever a qualidade em dois datasets que trazem informações sobre a características de alguns vinhos, sendo um dataset de vinhos tintos e outro de vinhos brancos. Bibliotecas utilizadas: ```pandas```, ```numpy```, ```sklearn```, ```matplotlib```, e ```seaborn```. Os modelos analisados foram: Regressão Linear e Regressão Logística.

### Metadados:

Ambos os datasets, tanto sobre vinhos tintos quanto vinhos brancos, contém as mesmas 12 colunas. Cada linha corresponde às características físico-químicas de cada vinho estudado, tendo uma variável target classificando a qualidade do vinho entre 0 e 10.

|Variável|Tradução|Descrição|
|:----------------|:--------------|:----------------------------------------------------------------------|
|fixed acidity|Acidez fixa| É a diferença entre a acidez total e a acidez volátil.
|volatile acidity|Acidez volátil| Ácido acético que é formado na fermentação alcoólica e, em dose elevada, origina o aroma a vinagre.
|citric acid|Ácido cítrico| É um ácido orgânico forte, normalmente presente em fracas quantidades nos mostos de uva e geralmente ausente nos vinhos.
|residual sugar|Açúcar residual| Açúcar que sobra após terminar a fermentação alcoólica.
|chlorides|Cloretos| Indica a presença de sal no vinho.
|free sulfur dioxide|Dióxido de enxofre livre| É uma medida da quantidade de dióxido de enxofre que não está ligado a outras moléculas.
|total sulfur dioxide|Dióxido de enxofre total| É uma médida de ambos os dióxidos de enxofre, livre e ligado a outras moléculas.
|density|Densidade| A densidade do vinho.
|pH|pH| O pH do vinho.
|sulphates|Sulfatos| Indica a presença de sais de ácido sulfúrico.
|alcohol|Álcool| Teor alcoólico do vinho.
|quality|Qualidade| Indica a qualidade do vinho de 0 a 10, sendo 0 a pior nota e 10 a melhor.

