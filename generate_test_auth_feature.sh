#!/bin/bash

# Base path for the tests
BASE_PATH="test/features/auth"

mkdir -p $BASE_PATH

# Create the folder structure
mkdir -p $BASE_PATH/data/datasources
mkdir -p $BASE_PATH/data/models
mkdir -p $BASE_PATH/data/repositories
mkdir -p $BASE_PATH/domain/usecases
mkdir -p $BASE_PATH/domain/entities
mkdir -p $BASE_PATH/domain/repositories
mkdir -p $BASE_PATH/presentation/cubit
mkdir -p $BASE_PATH/presentation/pages
mkdir -p $BASE_PATH/presentation/widgets

# Create test files for the Auth feature
touch $BASE_PATH/data/datasources/auth_remote_datasource_impl_test.dart
touch $BASE_PATH/data/datasources/auth_remote_datasource_test.dart
touch $BASE_PATH/data/datasources/auth_local_datasource_impl_test.dart
touch $BASE_PATH/data/datasources/auth_local_datasource_test.dart
touch $BASE_PATH/data/models/user_model_test.dart
touch $BASE_PATH/data/repositories/auth_repository_impl_test.dart
touch $BASE_PATH/domain/entities/user_test.dart
touch $BASE_PATH/domain/repositories/auth_repository_test.dart
touch $BASE_PATH/domain/usecases/login_usecase_test.dart
touch $BASE_PATH/domain/usecases/register_usecase_test.dart
touch $BASE_PATH/presentation/cubit/auth_cubit_test.dart
touch $BASE_PATH/presentation/cubit/auth_state_test.dart
touch $BASE_PATH/presentation/pages/login_page_test.dart
touch $BASE_PATH/presentation/pages/register_page_test.dart
touch $BASE_PATH/presentation/widgets/login_form_test.dart
touch $BASE_PATH/presentation/widgets/register_form_test.dart

# Completion message
echo "Auth feature test structure created successfully!"
