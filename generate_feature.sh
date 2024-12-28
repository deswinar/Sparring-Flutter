#!/bin/bash

# Check if feature name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <feature_name>"
  exit 1
fi

FEATURE_NAME=$1

# Base path for the feature
BASE_PATH="lib/features/$FEATURE_NAME"

# Create the folder structure
mkdir -p $BASE_PATH/data/datasources
mkdir -p $BASE_PATH/data/models
mkdir -p $BASE_PATH/domain/entities
mkdir -p $BASE_PATH/domain/repositories
mkdir -p $BASE_PATH/domain/usecases
mkdir -p $BASE_PATH/presentation/bloc
mkdir -p $BASE_PATH/presentation/pages
mkdir -p $BASE_PATH/presentation/widgets

# Create files with the feature name
touch $BASE_PATH/data/datasources/${FEATURE_NAME}_remote_data_source.dart
touch $BASE_PATH/data/datasources/${FEATURE_NAME}_local_data_source.dart
touch $BASE_PATH/data/models/${FEATURE_NAME}_model.dart
touch $BASE_PATH/domain/entities/${FEATURE_NAME}_entity.dart
touch $BASE_PATH/domain/repositories/${FEATURE_NAME}_repository.dart
touch $BASE_PATH/domain/usecases/get_${FEATURE_NAME}_usecase.dart
touch $BASE_PATH/domain/usecases/save_${FEATURE_NAME}_usecase.dart
touch $BASE_PATH/presentation/bloc/${FEATURE_NAME}_bloc.dart
touch $BASE_PATH/presentation/bloc/${FEATURE_NAME}_event.dart
touch $BASE_PATH/presentation/bloc/${FEATURE_NAME}_state.dart
touch $BASE_PATH/presentation/pages/${FEATURE_NAME}_page.dart
touch $BASE_PATH/presentation/pages/${FEATURE_NAME}_details_page.dart
touch $BASE_PATH/presentation/widgets/${FEATURE_NAME}_list_item.dart
touch $BASE_PATH/presentation/widgets/${FEATURE_NAME}_details_widget.dart

# Completion message
echo "Feature structure for '$FEATURE_NAME' created successfully!"
