from sklearn.preprocessing import MinMaxScaler
import numpy as np

def get_scaler():
    # Defining MAX and MIN values
    feature_ranges = {
        "person_age": (18, 100),
        "person_income": (10000, 7000000),
        "loan_amnt": (500, 35000),
        "loan_int_rate": (0, 0.2),          # loan_int_rate in percentage
        "credit_score": (390, 850),
    }

    # Creating scalers for each resource
    scalers = {}
    for feature, (min_val, max_val) in feature_ranges.items():
        scaler = MinMaxScaler(feature_range=(0, 1))
        scaler.fit(np.array([min_val, max_val]).reshape(-1, 1))
        scalers[feature] = scaler
    return scalers
