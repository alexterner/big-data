# -----------------------------------------------------------
# Importing relevant libraries
# -----------------------------------------------------------
 
from pyspark.sql import SparkSession
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.classification import DecisionTreeClassifier,RandomForestClassifier
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
 
# -----------------------------------------------------------
# Initializing Spark Session
# -----------------------------------------------------------
 
spark = SparkSession.builder.appName('ml_tree').getOrCreate()
 
# -----------------------------------------------------------
# Read the dataset
# -----------------------------------------------------------
 
# survived - Survival. 0 = No, 1 = Yes
# Pclass   - Ticket class. 1 = 1st, 2 = 2nd, 3 = 3rd
# sex      - Gender. 0 = Female, 1 = Male
# Age      - Age in years
# sibsp    - Number of siblings / spouses aboard the Titanic
# parch    - Number of parents / children aboard the Titanic
# ticket   - Ticket number
# fare     - Passenger fare
# cabin    - Cabin number
# embarked - Port of Embarkation 1 = Cherbourg, 3 = Queenstown, 2 = Southampton
 
data = spark.read.csv("data/titanic.csv",inferSchema=True,header=True)
 
# Print the Schema of the DataFrame
data.printSchema()
 
data.show()
 
data.columns
 
# -----------------------------------------------------------
# Preparing the data for our model
# -----------------------------------------------------------
 
# Before creating a model, our data needs to be in the form of two columns:
# ("label","features")
 
assembler = VectorAssembler(
    inputCols=[  'Pclass',
                 'Sex',
                 'Age',
                 'SibSp',
                 'Parch',
                 'Embarked'],
    outputCol="features")
 
output = assembler.transform(data)
 
output.select("features").show()
 
output.show()
 
final_data = output.select("features",'Survived')
 
train_data,test_data = final_data.randomSplit([0.7,0.3], seed=1234)
 
train_data.describe().show()
 
test_data.describe().show()
 
# -----------------------------------------------------------
# Create a Tree Model object
# -----------------------------------------------------------
 
dtc = DecisionTreeClassifier(labelCol='Survived',featuresCol='features')
rfc = RandomForestClassifier(labelCol='Survived',featuresCol='features')
 
# Fit the model to the data and call this model lrModel
dtc_model = dtc.fit(train_data)
rfc_model = rfc.fit(train_data)
 
# -----------------------------------------------------------
# Evaluate
# -----------------------------------------------------------
 
# Evaluate on a different dataset
dtc_predictions = dtc_model.transform(test_data)
rfc_predictions = rfc_model.transform(test_data)
 
dtc_predictions.select("features","prediction").show()
rfc_predictions.select("features","prediction").show()
 
acc_evaluator = MulticlassClassificationEvaluator(labelCol="Survived", predictionCol="prediction", metricName="accuracy")
 
dtc_acc = acc_evaluator.evaluate(dtc_predictions)
rfc_acc = acc_evaluator.evaluate(rfc_predictions)
 
print('A single decision tree had an accuracy of: {:.2f}%'.format(dtc_acc*100))
print('A random forest had an accuracy of: {:.2f}%'.format(rfc_acc*100))
 
 
# Evaluate based on a manual list
unlabeled_data_list = [(3,1,22,1,0,2)]
unlabeled_data_df = spark.createDataFrame(unlabeled_data_list,["f1", "f2", "f3", "f4", "f5", "f6"])
unlabeled_data_df.show()
 
assembler = VectorAssembler(
    inputCols=["f1","f2","f3","f4","f5","f6"],
    outputCol="features")
 
output = assembler.transform(unlabeled_data_df)
output_features_only = output.select("features")
 
dtc_predictions = dtc_model.transform(output_features_only)
rfc_predictions = rfc_model.transform(output_features_only)
 
dtc_predictions.select("features","prediction").show()
rfc_predictions.select("features","prediction").show()
