# Predictive-Analysis-for-Used-Car-s-Sale-Price

## Project Overview

This project involves the development of a predictive model to estimate the prices of used cars using machine learning techniques. The dataset, obtained from Kaggle, includes 40,000 used cars described by various features. The primary objective of this project was to construct an accurate predictive model while addressing the challenges of data preparation, feature selection, and model tuning.

## Files and Structure

- **analysisData.csv.zip**: The dataset used for building the predictive model.
- **scoringData.csv.zip**: Additional data used for scoring or evaluating the model.
- **Final.R**: The main R script containing the code for data preprocessing, model building, and evaluation.
- **kaggle_report.docx**: A detailed report documenting the process, including data exploration, data preparation, feature selection, and model evaluation.
- **5200-PAC-report.html**: A comprehensive HTML report generated as part of the project documentation, summarizing the project's results and methodologies.

## Methodology

1. **Data Exploration and Understanding**:
   - Initial exploration of the dataset to understand the distribution and characteristics of the variables.
   - Identification and handling of missing values, outliers, and anomalies in the data.

2. **Data Preparation and Transformation**:
   - Cleaning the dataset by replacing missing values and transforming variables to suit the modeling requirements.
   - Normalization of numeric variables and consolidation of categorical variables.

3. **Feature Selection**:
   - Use of Lasso regression for variable selection and regularization, reducing the number of predictors to avoid overfitting.
   - Identification of the most significant features impacting used car prices.

4. **Model Building**:
   - Construction of a Random Forest model, known for its robustness and ability to handle mixed variable types.
   - Fine-tuning of the model parameters through iterative processes to optimize performance.

5. **Model Evaluation**:
   - Assessment of the model's predictive power and analysis of the importance of different variables.
   - Iterative refinement of the model based on evaluation metrics to improve accuracy.

## Results

The project successfully developed a predictive model that can estimate the prices of used cars with reasonable accuracy. The model underwent several iterations of tuning and refinement, demonstrating the importance of a thorough understanding of the data, careful feature selection, and methodical model tuning.

## Conclusion

This project serves as a comprehensive exercise in predictive modeling, emphasizing the importance of each step in the data science process—from data exploration to final model evaluation. The outcome is a refined model capable of providing valuable insights into the factors influencing used car prices.

## How to Use

1. Unzip the `analysisData.csv.zip` and `scoringData.csv.zip` files.
2. Run the `Final.R` script to preprocess the data, build the model, and generate predictions.
3. Refer to the `kaggle_report.docx` and `5200-PAC-report.html` for detailed documentation and insights.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.
