CREATE DATABASE clinic

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE
);

CREATE TABLE medical_histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIME,
    patient_id INT REFERENCES patients(id),
    status VARCHAR(255)
);

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255)
);

CREATE TABLE treatment_histories (
    id SERIAL PRIMARY KEY,
    medical_history_id INT,
    treatments_id INT,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
    FOREIGN KEY (treatments_id) REFERENCES treatments(id)
);

CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    invoice_amount DECIMAL NOT NULL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT REFERENCES invoices(id),
    treatments_id INT REFERENCES treatments(id)
);

CREATE INDEX idx_medical_history_patient_id ON medical_histories(patient_id);

CREATE INDEX idx_treatment_history_medical_history_id ON treatment_histories(medical_history_id);
CREATE INDEX idx_treatment_history_treatment_id ON treatment_histories(treatments_id);

CREATE INDEX idx_invoice_medical_history_id ON invoices(medical_history_id);

CREATE INDEX idx_invoice_item_invoice_id ON invoice_items(invoice_id);
CREATE INDEX idx_invoice_item_treatment_id ON invoice_items(treatments_id);