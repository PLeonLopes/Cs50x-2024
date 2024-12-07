# BANK LOAN ANALYZER
#### Video Demo:  <https://www.youtube.com/watch?v=QLxmUYnA4qk>
#### Description:

# Loan Approval Prediction System

This project is a web application designed to demonstrate the power of machine learning in real-world scenarios. The application predicts whether a client is eligible for a bank loan based on their submitted information. Built with Flask, the project integrates a pre-trained machine learning model using the **Random Forest Classifier** for binary classification.

---

## 1. **Project Overview**
The Loan Approval Prediction System provides users with the following functionality:
- **Prediction:** Users can input their details and receive a real-time prediction on loan approval.
- **History Tracking:** Logged-in users can view their prediction history.
- **Machine Learning Showcase:** A practical demonstration of how machine learning models can be deployed in a web application.

This project was created to serve as an educational and practical example of integrating machine learning into web-based applications.

---

## 2. **File Structure and Functionality**

### **2.1 Core Files**
#### `app.py`
- It is the main Flask application file.
- Handles routes for user interaction, including login, prediction, and history viewing.
- Loads and interacts with the machine learning model.

#### `templates/`
- Contains a Jinja HTML templates for rendering web pages:
  - `layout.html`: Shared layout template for consistent styling (e.g., navbar, footer).
  - `index.html`: Home page with the loan prediction form.
  - `history.html`: Displays prediction history for logged-in users.
  - `result.html`: Shows the loan approval prediction results.

#### `static/`
- Contains static assets such as CSS, JavaScript, and images for styling and client-side interactivity.

---

### **2.2 Additional Files**
#### `data/bank-loan.csv`
- Contains the dataset used to train the machine learning model.
- Includes client attributes and their corresponding loan approval status.

#### `helpers.py`
- Includes helper functions such as:
  - **Min-Max Normalization:** Prepares user input for prediction by normalizing features using `MinMaxScaler`.

#### `utils.py`
- Contains utility functions like:
  - `@RequiredLogin`: A Flask route decorator to restrict access to authenticated users only.

#### `ML_model/`
- Stores the serialized machine learning model file:
  - `loan_model.pkl`: Pre-trained **Random Forest Classifier**, exported using `joblib` for efficient loading and prediction.

#### `notebook/`
- Includes the Jupyter notebook file:
  - `model_training.ipynb`: Contains the steps for preprocessing the dataset, training the Random Forest Classifier, and exporting the model.

#### `ddl.sql`
- SQL script file demonstrating the creation of the database schema, including:
  - Tables for user authentication.
  - Tables for storing prediction history.

---

## 3. **Machine Learning Model**
- **Model Type:** Random Forest Classifier.
- **Training Dataset:** The `bank-loan.csv` dataset from the `data/` directory, containing various client attributes and their loan approval outcomes.
- **Training Process:**
  - Conducted in `model_training.ipynb`.
  - Includes data cleaning, feature scaling, and model training.
  - The trained model is exported to `ML_model/loan_model.pkl` for deployment.

---

## 7. **Getting Started**
To run this project locally, follow these steps:
1. Clone the repository.
2. Set up a Python environment and install dependencies (`pip install -r requirements.txt`).
3. Configure the database using the `ddl.sql` script.
4. Train and export the model using `model_training.ipynb` (optional) .
5. Run the application: `flask run`.
6. Access the web app at `http://localhost:5000`.

---

Enjoy exploring the integration of machine learning with web development!

Made By Pedro Lopes.
