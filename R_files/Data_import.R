### This is a new R file to run your script!

### First, import the data using the SQL code from the dataset generator
library(tidyverse)
library(bigrquery)

# This query represents dataset "heart_disease" for domain "measurement" and was generated for All of Us Registered Tier Dataset v7
dataset_23375548_measurement_sql <- paste("
    SELECT
        measurement.person_id,
        m_standard_concept.concept_name as standard_concept_name,
        measurement.value_as_number 
    FROM
        ( SELECT
            * 
        FROM
            `measurement` measurement 
        WHERE
            (
                measurement_source_concept_id IN (
                    SELECT
                        DISTINCT c.concept_id 
                    FROM
                        `cb_criteria` c 
                    JOIN
                        (
                            SELECT
                                CAST(cr.id as string) AS id       
                            FROM
                                `cb_criteria` cr       
                            WHERE
                                concept_id IN (
                                    903124
                                )       
                                AND full_text LIKE '%_rank1]%'      
                        ) a 
                            ON (
                                c.path LIKE CONCAT('%.',
                            a.id,
                            '.%') 
                            OR c.path LIKE CONCAT('%.',
                            a.id) 
                            OR c.path LIKE CONCAT(a.id,
                            '.%') 
                            OR c.path = a.id) 
                        WHERE
                            is_standard = 0 
                            AND is_selectable = 1
                        )
                )  
                AND (
                    measurement.PERSON_ID IN (
                        SELECT
                            distinct person_id  
                        FROM
                            `cb_search_person` cb_search_person  
                        WHERE
                            cb_search_person.person_id IN (
                                SELECT
                                    criteria.person_id 
                                FROM
                                    (SELECT
                                        DISTINCT person_id,
                                        entry_date,
                                        concept_id 
                                    FROM
                                        `cb_search_all_events` 
                                    WHERE
                                        (
                                            concept_id IN(
                                                SELECT
                                                    DISTINCT c.concept_id 
                                                FROM
                                                    `cb_criteria` c 
                                                JOIN
                                                    (
                                                        SELECT
                                                            CAST(cr.id as string) AS id       
                                                        FROM
                                                            `cb_criteria` cr       
                                                        WHERE
                                                            concept_id IN (1585873, 1586162)       
                                                            AND full_text LIKE '%_rank1]%'      
                                                    ) a 
                                                        ON (
                                                            c.path LIKE CONCAT('%.',
                                                        a.id,
                                                        '.%') 
                                                        OR c.path LIKE CONCAT('%.',
                                                        a.id) 
                                                        OR c.path LIKE CONCAT(a.id,
                                                        '.%') 
                                                        OR c.path = a.id) 
                                                    WHERE
                                                        is_standard = 0 
                                                        AND is_selectable = 1
                                                    ) 
                                                    AND is_standard = 0 
                                            )
                                        ) criteria 
                                    UNION
                                    DISTINCT SELECT
                                        criteria.person_id 
                                    FROM
                                        (SELECT
                                            DISTINCT person_id,
                                            entry_date,
                                            concept_id 
                                        FROM
                                            `cb_search_all_events` 
                                        WHERE
                                            (
                                                concept_id IN(
                                                    SELECT
                                                        DISTINCT c.concept_id 
                                                    FROM
                                                        `cb_criteria` c 
                                                    JOIN
                                                        (
                                                            SELECT
                                                                CAST(cr.id as string) AS id       
                                                            FROM
                                                                `cb_criteria` cr       
                                                            WHERE
                                                                concept_id IN (1586207)       
                                                                AND full_text LIKE '%_rank1]%'      
                                                        ) a 
                                                            ON (
                                                                c.path LIKE CONCAT('%.',
                                                            a.id,
                                                            '.%') 
                                                            OR c.path LIKE CONCAT('%.',
                                                            a.id) 
                                                            OR c.path LIKE CONCAT(a.id,
                                                            '.%') 
                                                            OR c.path = a.id) 
                                                        WHERE
                                                            is_standard = 0 
                                                            AND is_selectable = 1
                                                        ) 
                                                        AND is_standard = 0 
                                                )
                                            ) criteria 
                                        UNION
                                        DISTINCT SELECT
                                            criteria.person_id 
                                        FROM
                                            (SELECT
                                                DISTINCT person_id,
                                                entry_date,
                                                concept_id 
                                            FROM
                                                `cb_search_all_events` 
                                            WHERE
                                                (
                                                    concept_id IN (903124) 
                                                    AND is_standard = 0 
                                                )) criteria ) 
                                    )
                                )) measurement 
                        LEFT JOIN
                            `concept` m_standard_concept 
                                ON measurement.measurement_concept_id = m_standard_concept.concept_id", sep="")

# Formulate a Cloud Storage destination path for the data exported from BigQuery.
# NOTE: By default data exported multiple times on the same day will overwrite older copies.
#       But data exported on a different days will write to a new location so that historical
#       copies can be kept as the dataset definition is changed.
measurement_23375548_path <- file.path(
  Sys.getenv("WORKSPACE_BUCKET"),
  "bq_exports",
  Sys.getenv("OWNER_EMAIL"),
  strftime(lubridate::now(), "%Y%m%d"),  # Comment out this line if you want the export to always overwrite.
  "measurement_23375548",
  "measurement_23375548_*.csv")
message(str_glue('The data will be written to {measurement_23375548_path}. Use this path when reading ',
                 'the data into your notebooks in the future.'))

# Perform the query and export the dataset to Cloud Storage as CSV files.
# NOTE: You only need to run `bq_table_save` once. After that, you can
#       just read data from the CSVs in Cloud Storage.
bq_table_save(
  bq_dataset_query(Sys.getenv("WORKSPACE_CDR"), dataset_23375548_measurement_sql, billing = Sys.getenv("GOOGLE_PROJECT")),
  measurement_23375548_path,
  destination_format = "CSV")


# Read the data directly from Cloud Storage into memory.
# NOTE: Alternatively you can `gsutil -m cp {measurement_23375548_path}` to copy these files
#       to the Jupyter disk.
read_bq_export_from_workspace_bucket <- function(export_path) {
  col_types <- cols(standard_concept_name = col_character())
  bind_rows(
    map(system2('gsutil', args = c('ls', export_path), stdout = TRUE, stderr = TRUE),
        function(csv) {
          message(str_glue('Loading {csv}.'))
          chunk <- read_csv(pipe(str_glue('gsutil cat {csv}')), col_types = col_types, show_col_types = FALSE)
          if (is.null(col_types)) {
            col_types <- spec(chunk)
          }
          chunk
        }))
}
dataset_23375548_measurement_df <- read_bq_export_from_workspace_bucket(measurement_23375548_path)

dim(dataset_23375548_measurement_df)

head(dataset_23375548_measurement_df, 5)
library(tidyverse)
library(bigrquery)

# This query represents dataset "heart_disease" for domain "survey" and was generated for All of Us Registered Tier Dataset v7
dataset_23375548_survey_sql <- paste("
    SELECT
        answer.person_id,
        answer.question,
        answer.answer  
    FROM
        `ds_survey` answer   
    WHERE
        (
            question_concept_id IN (
                1585873, 1586162, 1586207
            )
        )  
        AND (
            answer.PERSON_ID IN (
                SELECT
                    distinct person_id  
                FROM
                    `cb_search_person` cb_search_person  
                WHERE
                    cb_search_person.person_id IN (
                        SELECT
                            criteria.person_id 
                        FROM
                            (SELECT
                                DISTINCT person_id,
                                entry_date,
                                concept_id 
                            FROM
                                `cb_search_all_events` 
                            WHERE
                                (
                                    concept_id IN(
                                        SELECT
                                            DISTINCT c.concept_id 
                                        FROM
                                            `cb_criteria` c 
                                        JOIN
                                            (
                                                SELECT
                                                    CAST(cr.id as string) AS id       
                                                FROM
                                                    `cb_criteria` cr       
                                                WHERE
                                                    concept_id IN (1585873, 1586162)       
                                                    AND full_text LIKE '%_rank1]%'      
                                            ) a 
                                                ON (
                                                    c.path LIKE CONCAT('%.',
                                                a.id,
                                                '.%') 
                                                OR c.path LIKE CONCAT('%.',
                                                a.id) 
                                                OR c.path LIKE CONCAT(a.id,
                                                '.%') 
                                                OR c.path = a.id) 
                                            WHERE
                                                is_standard = 0 
                                                AND is_selectable = 1
                                            ) 
                                            AND is_standard = 0 
                                    )
                                ) criteria 
                            UNION
                            DISTINCT SELECT
                                criteria.person_id 
                            FROM
                                (SELECT
                                    DISTINCT person_id,
                                    entry_date,
                                    concept_id 
                                FROM
                                    `cb_search_all_events` 
                                WHERE
                                    (
                                        concept_id IN(
                                            SELECT
                                                DISTINCT c.concept_id 
                                            FROM
                                                `cb_criteria` c 
                                            JOIN
                                                (
                                                    SELECT
                                                        CAST(cr.id as string) AS id       
                                                    FROM
                                                        `cb_criteria` cr       
                                                    WHERE
                                                        concept_id IN (1586207)       
                                                        AND full_text LIKE '%_rank1]%'      
                                                ) a 
                                                    ON (
                                                        c.path LIKE CONCAT('%.',
                                                    a.id,
                                                    '.%') 
                                                    OR c.path LIKE CONCAT('%.',
                                                    a.id) 
                                                    OR c.path LIKE CONCAT(a.id,
                                                    '.%') 
                                                    OR c.path = a.id) 
                                                WHERE
                                                    is_standard = 0 
                                                    AND is_selectable = 1
                                                ) 
                                                AND is_standard = 0 
                                        )
                                    ) criteria 
                                UNION
                                DISTINCT SELECT
                                    criteria.person_id 
                                FROM
                                    (SELECT
                                        DISTINCT person_id,
                                        entry_date,
                                        concept_id 
                                    FROM
                                        `cb_search_all_events` 
                                    WHERE
                                        (
                                            concept_id IN (903124) 
                                            AND is_standard = 0 
                                        )) criteria ) 
                            )
                        )", sep="")

# Formulate a Cloud Storage destination path for the data exported from BigQuery.
# NOTE: By default data exported multiple times on the same day will overwrite older copies.
#       But data exported on a different days will write to a new location so that historical
#       copies can be kept as the dataset definition is changed.
survey_23375548_path <- file.path(
  Sys.getenv("WORKSPACE_BUCKET"),
  "bq_exports",
  Sys.getenv("OWNER_EMAIL"),
  strftime(lubridate::now(), "%Y%m%d"),  # Comment out this line if you want the export to always overwrite.
  "survey_23375548",
  "survey_23375548_*.csv")
message(str_glue('The data will be written to {survey_23375548_path}. Use this path when reading ',
                 'the data into your notebooks in the future.'))

# Perform the query and export the dataset to Cloud Storage as CSV files.
# NOTE: You only need to run `bq_table_save` once. After that, you can
#       just read data from the CSVs in Cloud Storage.
bq_table_save(
  bq_dataset_query(Sys.getenv("WORKSPACE_CDR"), dataset_23375548_survey_sql, billing = Sys.getenv("GOOGLE_PROJECT")),
  survey_23375548_path,
  destination_format = "CSV")


# Read the data directly from Cloud Storage into memory.
# NOTE: Alternatively you can `gsutil -m cp {survey_23375548_path}` to copy these files
#       to the Jupyter disk.
read_bq_export_from_workspace_bucket <- function(export_path) {
  col_types <- cols(survey = col_character(), question = col_character(), answer = col_character())
  bind_rows(
    map(system2('gsutil', args = c('ls', export_path), stdout = TRUE, stderr = TRUE),
        function(csv) {
          message(str_glue('Loading {csv}.'))
          chunk <- read_csv(pipe(str_glue('gsutil cat {csv}')), col_types = col_types, show_col_types = FALSE)
          if (is.null(col_types)) {
            col_types <- spec(chunk)
          }
          chunk
        }))
}
dataset_23375548_survey_df <- read_bq_export_from_workspace_bucket(survey_23375548_path)

dim(dataset_23375548_survey_df)

head(dataset_23375548_survey_df, 5)
library(tidyverse)
library(bigrquery)

# This query represents dataset "heart_disease" for domain "condition" and was generated for All of Us Registered Tier Dataset v7
dataset_23375548_condition_sql <- paste("
    SELECT
        c_occurrence.person_id,
        c_standard_concept.concept_name as standard_concept_name 
    FROM
        ( SELECT
            * 
        FROM
            `condition_occurrence` c_occurrence 
        WHERE
            (
                condition_concept_id IN (
                    SELECT
                        DISTINCT c.concept_id 
                    FROM
                        `cb_criteria` c 
                    JOIN
                        (
                            SELECT
                                CAST(cr.id as string) AS id       
                            FROM
                                `cb_criteria` cr       
                            WHERE
                                concept_id IN (
                                    317576, 321588
                                )       
                                AND full_text LIKE '%_rank1]%'      
                        ) a 
                            ON (
                                c.path LIKE CONCAT('%.',
                            a.id,
                            '.%') 
                            OR c.path LIKE CONCAT('%.',
                            a.id) 
                            OR c.path LIKE CONCAT(a.id,
                            '.%') 
                            OR c.path = a.id) 
                        WHERE
                            is_standard = 1 
                            AND is_selectable = 1
                        )
                )  
                AND (
                    c_occurrence.PERSON_ID IN (
                        SELECT
                            distinct person_id  
                        FROM
                            `cb_search_person` cb_search_person  
                        WHERE
                            cb_search_person.person_id IN (
                                SELECT
                                    criteria.person_id 
                                FROM
                                    (SELECT
                                        DISTINCT person_id,
                                        entry_date,
                                        concept_id 
                                    FROM
                                        `cb_search_all_events` 
                                    WHERE
                                        (
                                            concept_id IN(
                                                SELECT
                                                    DISTINCT c.concept_id 
                                                FROM
                                                    `cb_criteria` c 
                                                JOIN
                                                    (
                                                        SELECT
                                                            CAST(cr.id as string) AS id       
                                                        FROM
                                                            `cb_criteria` cr       
                                                        WHERE
                                                            concept_id IN (1585873, 1586162)       
                                                            AND full_text LIKE '%_rank1]%'      
                                                    ) a 
                                                        ON (
                                                            c.path LIKE CONCAT('%.',
                                                        a.id,
                                                        '.%') 
                                                        OR c.path LIKE CONCAT('%.',
                                                        a.id) 
                                                        OR c.path LIKE CONCAT(a.id,
                                                        '.%') 
                                                        OR c.path = a.id) 
                                                    WHERE
                                                        is_standard = 0 
                                                        AND is_selectable = 1
                                                    ) 
                                                    AND is_standard = 0 
                                            )
                                        ) criteria 
                                    UNION
                                    DISTINCT SELECT
                                        criteria.person_id 
                                    FROM
                                        (SELECT
                                            DISTINCT person_id,
                                            entry_date,
                                            concept_id 
                                        FROM
                                            `cb_search_all_events` 
                                        WHERE
                                            (
                                                concept_id IN(
                                                    SELECT
                                                        DISTINCT c.concept_id 
                                                    FROM
                                                        `cb_criteria` c 
                                                    JOIN
                                                        (
                                                            SELECT
                                                                CAST(cr.id as string) AS id       
                                                            FROM
                                                                `cb_criteria` cr       
                                                            WHERE
                                                                concept_id IN (1586207)       
                                                                AND full_text LIKE '%_rank1]%'      
                                                        ) a 
                                                            ON (
                                                                c.path LIKE CONCAT('%.',
                                                            a.id,
                                                            '.%') 
                                                            OR c.path LIKE CONCAT('%.',
                                                            a.id) 
                                                            OR c.path LIKE CONCAT(a.id,
                                                            '.%') 
                                                            OR c.path = a.id) 
                                                        WHERE
                                                            is_standard = 0 
                                                            AND is_selectable = 1
                                                        ) 
                                                        AND is_standard = 0 
                                                )
                                            ) criteria 
                                        UNION
                                        DISTINCT SELECT
                                            criteria.person_id 
                                        FROM
                                            (SELECT
                                                DISTINCT person_id,
                                                entry_date,
                                                concept_id 
                                            FROM
                                                `cb_search_all_events` 
                                            WHERE
                                                (
                                                    concept_id IN (903124) 
                                                    AND is_standard = 0 
                                                )) criteria ) 
                                    )
                                )) c_occurrence 
                        LEFT JOIN
                            `concept` c_standard_concept 
                                ON c_occurrence.condition_concept_id = c_standard_concept.concept_id", sep="")

# Formulate a Cloud Storage destination path for the data exported from BigQuery.
# NOTE: By default data exported multiple times on the same day will overwrite older copies.
#       But data exported on a different days will write to a new location so that historical
#       copies can be kept as the dataset definition is changed.
condition_23375548_path <- file.path(
  Sys.getenv("WORKSPACE_BUCKET"),
  "bq_exports",
  Sys.getenv("OWNER_EMAIL"),
  strftime(lubridate::now(), "%Y%m%d"),  # Comment out this line if you want the export to always overwrite.
  "condition_23375548",
  "condition_23375548_*.csv")
message(str_glue('The data will be written to {condition_23375548_path}. Use this path when reading ',
                 'the data into your notebooks in the future.'))

# Perform the query and export the dataset to Cloud Storage as CSV files.
# NOTE: You only need to run `bq_table_save` once. After that, you can
#       just read data from the CSVs in Cloud Storage.
bq_table_save(
  bq_dataset_query(Sys.getenv("WORKSPACE_CDR"), dataset_23375548_condition_sql, billing = Sys.getenv("GOOGLE_PROJECT")),
  condition_23375548_path,
  destination_format = "CSV")


# Read the data directly from Cloud Storage into memory.
# NOTE: Alternatively you can `gsutil -m cp {condition_23375548_path}` to copy these files
#       to the Jupyter disk.
read_bq_export_from_workspace_bucket <- function(export_path) {
  col_types <- cols(standard_concept_name = col_character())
  bind_rows(
    map(system2('gsutil', args = c('ls', export_path), stdout = TRUE, stderr = TRUE),
        function(csv) {
          message(str_glue('Loading {csv}.'))
          chunk <- read_csv(pipe(str_glue('gsutil cat {csv}')), col_types = col_types, show_col_types = FALSE)
          if (is.null(col_types)) {
            col_types <- spec(chunk)
          }
          chunk
        }))
}
dataset_23375548_condition_df <- read_bq_export_from_workspace_bucket(condition_23375548_path)

dim(dataset_23375548_condition_df)

head(dataset_23375548_condition_df, 5)


