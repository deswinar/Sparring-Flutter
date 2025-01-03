#!/bin/bash

# Base path for the Auth feature
BASE_PATH="lib/features/auth"

# Create the folder structure
mkdir -p $BASE_PATH/data/datasources
mkdir -p $BASE_PATH/data/models
mkdir -p $BASE_PATH/data/repositories
mkdir -p $BASE_PATH/domain/entities
mkdir -p $BASE_PATH/domain/repositories
mkdir -p $BASE_PATH/domain/usecases
mkdir -p $BASE_PATH/presentation/cubit
mkdir -p $BASE_PATH/presentation/pages
mkdir -p $BASE_PATH/presentation/widgets

# Create files for the Auth feature
touch $BASE_PATH/data/datasources/auth_remote_datasource_impl.dart
touch $BASE_PATH/data/datasources/auth_remote_datasource.dart
touch $BASE_PATH/data/datasources/auth_local_datasource_impl.dart
touch $BASE_PATH/data/datasources/auth_local_datasource.dart
touch $BASE_PATH/data/models/user_model.dart
touch $BASE_PATH/data/repositories/auth_repository_impl.dart
touch $BASE_PATH/domain/entities/user.dart
touch $BASE_PATH/domain/repositories/auth_repository.dart
touch $BASE_PATH/domain/usecases/login_usecase.dart
touch $BASE_PATH/domain/usecases/register_usecase.dart
touch $BASE_PATH/presentation/cubit/auth_cubit.dart
touch $BASE_PATH/presentation/cubit/auth_state.dart
touch $BASE_PATH/presentation/pages/login_page.dart
touch $BASE_PATH/presentation/pages/register_page.dart
touch $BASE_PATH/presentation/widgets/login_form.dart
touch $BASE_PATH/presentation/widgets/register_form.dart

# Completion message
echo "Auth feature structure created successfully!"
