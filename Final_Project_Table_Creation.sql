CREATE TABLE provider_names(
name_id int,
providerLastName_organizationName varchar(50) NOT NULL,
first_name varchar(30),
middle_initial varchar(1),
credentials varchar(20),
gender varchar(1),
PRIMARY KEY (name_id)
);

CREATE TABLE providers_misc (
providers_misc_id int,
entity_code varchar(1),
average_age_beneficiaries int,
average_HCC_risk_score_ben numeric(5,4),
PRIMARY KEY (providers_misc_id)
);

CREATE TABLE provider_addresses (
address_id int,
street_address varchar,
city varchar,
zip_code int,
state varchar,
country varchar,
PRIMARY KEY (address_id)
);

CREATE TABLE provider_types(
provider_type_id int,
provider_type varchar(75) NOT NULL,
PRIMARY KEY (provider_type_id)
);

CREATE TABLE medicare_participants(
medicare_participant_id int,
med_participation varchar(1) NOT NULL,
number_medicareBen int,
PRIMARY KEY (medicare_participant_id)
);

CREATE TABLE providers(
NPI int,
name_id int,
provider_type_id int,
address_id int,
medicare_participant_id int,
providers_misc_id int,
PRIMARY KEY (NPI),
FOREIGN KEY (name_id) REFERENCES provider_names(name_id),
FOREIGN KEY (provider_type_id) REFERENCES provider_types(provider_type_id),
FOREIGN KEY (address_id) REFERENCES provider_addresses(address_id),
FOREIGN KEY (medicare_participant_id) REFERENCES
medicare_participants(medicare_participant_id),
FOREIGN KEY (providers_misc_id) REFERENCES providers_misc(providers_misc_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE medicare_charges (
charges_id int,
NPI int,
submitted_charges_amount int,
medicare_allowed_amount int,
medicare_payment_amount int,
medicare_standardized_payment_amount int,
PRIMARY KEY (charges_id),
FOREIGN KEY (NPI) REFERENCES providers (NPI)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE gender_beneficiaries(
NPI int,
gender varchar(1),
count  int,
PRIMARY KEY(NPI,gender),
FOREIGN KEY (NPI) REFERENCES providers (NPI)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE race_beneficiaries (
NPI int,
race varchar(40),
count int,
PRIMARY KEY (NPI, race),
FOREIGN KEY (NPI) REFERENCES providers (NPI)
ON DELETE CASCADE
ON UPDATE CASCADE,
CHECK(race IN('Non-Hispanic White', 'Black or African American',
'Asian Pacific Islander Beneficiaries','Hispanic',
'American Indian/Alaska Native','Race Not Elsewhere Classified'))
);

CREATE TABLE entitlement_beneficiaries (
NPI int,
entitlement_type varchar,
count int,
PRIMARY KEY (NPI, entitlement_type),
FOREIGN KEY (NPI) REFERENCES providers (NPI)
ON DELETE CASCADE
ON UPDATE CASCADE,
CHECK (entitlement_type IN ('Medicare Only' , 'Medicare & Medicaid'))
);

CREATE TABLE chronic_illness (
NPI int,
chronic_illness varchar(50),
percent int,
PRIMARY KEY (NPI, chronic_illness),
FOREIGN KEY (NPI) REFERENCES providers (NPI)
ON DELETE CASCADE
ON UPDATE CASCADE,
CHECK (chronic_illness IN ('Atrial Fibrillation' ,'Alzheimer’s Disease or Dementia', 'Asthma', 'Cancer', 'Heart Failure', 'Chronic Kidney Disease', 'Chronic Obstructive Pulmonary Disease', 'Depression', 'Diabetes', 'Hyperlipidemia', 'Hypertension', 'Ischemic Heart Disease', 'Osteoporosis', 'Rheumatoid Arthritis / Osteoarthritis', 'Schizophrenia / Other Psychotic Disorders', 'Stroke'))
);

CREATE TABLE age_range_beneficiaries (
NPI int,
age_range varchar(20),
count int,
PRIMARY KEY (NPI, age_range),
FOREIGN KEY (NPI) REFERENCES providers (NPI)
ON DELETE CASCADE
ON UPDATE CASCADE,
CHECK (age_range IN('Age Less 65','Age 65 to 74','Age 75 to 84','Age Greater 84'))
);

CREATE TABLE medicare_drug_payments (
drug_payments_id int,
NPI int,
number_medicare_beneficiaries_with_drug int,
drug_submitted_charges numeric(10,2),
drug_medicare_allowed numeric(10,2),
drug_medicare_payment numeric(10,2),
drug_medicare_standardized_payment numeric(10,2),
PRIMARY KEY (drug_payments_id),
FOREIGN KEY (NPI) REFERENCES providers (NPI)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE medical_payment (
medical_payment_id int,
NPI int,
submitted_charges numeric (10,2),
medicare_allowed numeric (10,2),
medicare_payment numeric (10,2),
medicare_standardized_payment numeric (10,2),
PRIMARY KEY (medical_payment_id),
FOREIGN KEY (NPI) REFERENCES providers (NPI)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE drug_services (
drug_services_id int,
NPI int,
drug_suppress_indicator varchar(1),
number_of_HCPCS_associated_with_drug_services int,
number_of_drug_services int,
PRIMARY KEY (drug_services_id),
FOREIGN KEY (NPI) REFERENCES providers (NPI)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE medical_services (
medical_services_id int,
NPI int,
medical_suppress_indicator varchar(1),
number_of_HCPCS_medical_services int,
number_medical_services int,
Number_of_medicare_beneficiaries_with_medical_services int,
PRIMARY KEY (medical_services_id),
FOREIGN KEY (NPI) references providers(NPI)
ON DELETE CASCADE
ON UPDATE CASCADE
);
