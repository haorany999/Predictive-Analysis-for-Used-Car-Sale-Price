# kaggle - Haoran
data = read.csv("/Users/yanghaoran/Desktop/Kaggle competition/analysisData.csv")
scoringData = read.csv('/Users/yanghaoran/Desktop/Kaggle competition/scoringData.csv')

pred = predict(rf_model,newdata=scoringData)
submissionFile = data.frame(id = scoringData$id, price = pred)

write.csv(submissionFile, 'my_submission_18.csv',row.names = F)

### NA
library(dplyr)
library(tidyr)
# Identify variable types
numeric_vars <- sapply(data, is.numeric)
categorical_vars <- sapply(data, is.factor)
# Fill NA in numeric columns with mean
data <- data %>%
  mutate_at(vars(names(data)[numeric_vars]), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .))
#positon
columns_with_missing <- colnames(data)[apply(data, 2, function(x) any(is.na(x)))]
# mode
library(dplyr)

mode_color <- data %>%
  group_by(exterior_color) %>%
  summarize(count = n()) %>%
  arrange(desc(count)) %>%
  top_n(1, count) %>%
  pull(exterior_color)

data$exterior_color[is.na(data$exterior_color)] <- mode_color
sum(is.na(data))
str(data)

#  scoringData
str(scoringData)
sum(is.na(scoringData))# 假设你的打分数据集为 scoringData

# 为数值变量的缺失值使用 data 的均值
# 确保处理两个数据集都有的列
setdiff(names(data), names(scoringData))

common_numeric_vars <- names(data)[numeric_vars & names(data) %in% names(scoringData)]

for (var in common_numeric_vars) {
  mean_val <- mean(data[[var]], na.rm = TRUE)
  scoringData[[var]] <- ifelse(is.na(scoringData[[var]]), mean_val, scoringData[[var]])
}


# 对于分类变量 exterior_color 使用 data 的众数
scoringData$exterior_color[is.na(scoringData$exterior_color)] <- mode_color

# 检查处理后的 scoringData 是否还存在缺失值
sum(is.na(scoringData))


# model_name,trim_name,power,torque,exterior_color,interior_color, major_options
# model_name:
model_name_counts <- table(data$model_name)

# 按频率降序排列
model_name_sorted <- sort(model_name_counts, decreasing = TRUE)

# 计算占比
model_name_prop <- prop.table(model_name_sorted)

# 打印占比
print(model_name_prop)
print(model_name_prop[1:50])

# 定义一个函数来将非前50类别替换为"Other"
reduce_model_name <- function(df) {
  top_models <- names(model_name_sorted)[1:50]
  
  df$model_name <- ifelse(df$model_name %in% top_models, 
                          df$model_name, "Other")
  return(df)
}

# 在data和scoringData上应用函数
data <- reduce_model_name(data)
scoringData <- reduce_model_name(scoringData)

# 检查data数据集上的修改
str(data)


### trim_name
# 查看trim_name中的类别占比
trim_counts <- table(data$trim_name) / nrow(data)
trim_counts_sorted <- sort(trim_counts, decreasing = TRUE)

# 选取前50个类别
top_50_trims <- names(trim_counts_sorted)[1:50]

# 定义一个函数来将非前50类别替换为"Other"
reduce_trim_name <- function(df) {
  df$trim_name <- ifelse(df$trim_name %in% top_50_trims, 
                         df$trim_name, "Other")
  return(df)
}

# 在data和scoringData上应用函数
data <- reduce_trim_name(data)
scoringData <- reduce_trim_name(scoringData)

# 检查data数据集上的修改
table(data$trim_name) / nrow(data)




### power and torque

# 提取 power 中的 hp 数值
data$power_hp <- as.numeric(gsub(" hp.*", "", data$power))

# 提取 power 中的 RPM 数值
data$power_rpm <- as.numeric(gsub(",", "", gsub(".*@", "", gsub(" RPM", "", data$power))))

# 提取 torque 中的 lb-ft 数值
data$torque_lbft <- as.numeric(gsub(" lb-ft.*", "", data$torque))

# 提取 torque 中的 RPM 数值
data$torque_rpm <- as.numeric(gsub(",", "", gsub(".*@", "", gsub(" RPM", "", data$torque))))

# 处理新的NA
data$power_hp[is.na(data$power_hp)] <- median(data$power_hp, na.rm = TRUE)
data$power_rpm[is.na(data$power_rpm)] <- median(data$power_rpm, na.rm = TRUE)
data$torque_lbft[is.na(data$torque_lbft)] <- median(data$torque_lbft, na.rm = TRUE)
data$torque_rpm[is.na(data$torque_rpm)] <- median(data$torque_rpm, na.rm = TRUE)

str(data)

# scoringData 一致性
# 在scoringData上提取 power 中的 hp 数值
scoringData$power_hp <- as.numeric(gsub(" hp.*", "", scoringData$power))

# 在scoringData上提取 power 中的 RPM 数值
scoringData$power_rpm <- as.numeric(gsub(",", "", gsub(".*@", "", gsub(" RPM", "", scoringData$power))))

# 在scoringData上提取 torque 中的 lb-ft 数值
scoringData$torque_lbft <- as.numeric(gsub(" lb-ft.*", "", scoringData$torque))

# 在scoringData上提取 torque 中的 RPM 数值
scoringData$torque_rpm <- as.numeric(gsub(",", "", gsub(".*@", "", gsub(" RPM", "", scoringData$torque))))

# 在scoringData上处理新的NA
scoringData$power_hp[is.na(scoringData$power_hp)] <- median(scoringData$power_hp, na.rm = TRUE)
scoringData$power_rpm[is.na(scoringData$power_rpm)] <- median(scoringData$power_rpm, na.rm = TRUE)
scoringData$torque_lbft[is.na(scoringData$torque_lbft)] <- median(scoringData$torque_lbft, na.rm = TRUE)
scoringData$torque_rpm[is.na(scoringData$torque_rpm)] <- median(scoringData$torque_rpm, na.rm = TRUE)

# 查看scoringData的结构
str(scoringData)

###  exterior_color,interior_color, major_options 这三个先不加入考虑
# 因此目前想要放入rf_model 的变量有23个数值变量和分类变量中的：

library(randomForest)

# 选择的数值和分类变量
selected_vars <- c("make_name", "model_name", "trim_name", "body_type", "fuel_type", 
                   "transmission", "transmission_display", "wheel_system", "wheel_system_display", 
                   "engine_type", "fleet", "frame_damaged", "franchise_dealer", "franchise_make", 
                   "has_accidents", "isCab", "is_cpo", "is_new", "salvage", 
                   "highway_fuel_economy", "city_fuel_economy", "wheelbase_inches", "back_legroom_inches", 
                   "front_legroom_inches", "length_inches", "height_inches", "horsepower", 
                   "daysonmarket", "maximum_seating", "mileage", "owner_count", "seller_rating", 
                   "power_hp", "power_rpm", "torque_lbft", "torque_rpm", "price")

selected_vars_2 <- c("make_name", "model_name", "trim_name", "body_type", "fuel_type", 
                   "transmission", "transmission_display", "wheel_system", "wheel_system_display", 
                   "engine_type", "franchise_make", "is_new", 
                   "highway_fuel_economy", "city_fuel_economy", "wheelbase_inches", "back_legroom_inches", 
                   "front_legroom_inches", "length_inches", "height_inches", "horsepower", 
                   "daysonmarket", "maximum_seating", "mileage", "owner_count", "seller_rating", 
                   "power_hp", "power_rpm", "torque_lbft", "torque_rpm", "price")

selected_vars_3 <- c("make_name", "model_name", "trim_name", "body_type", "fuel_type", 
                     "transmission", "wheel_system", 
                     "engine_type", "franchise_make", "is_new", 
                     
                     "height_inches", "horsepower", 
                     "daysonmarket", "maximum_seating", "mileage", "owner_count", "seller_rating", 
                     "power_hp", "power_rpm", "torque_lbft", "torque_rpm", "price")

length(selected_vars_2)

sub_data <- data[, selected_vars_2]
rf_model <- randomForest(price ~ ., data=sub_data, ntree=1000, mtry=13, importance=TRUE)

# 查看数据结构
str(data)

# 查看变量重要性
importance_values <- importance(rf_model)
sorted_importance <- importance_values[order(importance_values[,"%IncMSE"], decreasing = TRUE), ]

print(sorted_importance)

fleet                 4.635418  2.551505e+11
isCab                 4.451735  2.264698e+11
frame_damaged         4.198957  1.557129e+11
franchise_dealer      4.164572  6.050486e+10
is_cpo                3.624856  8.109234e+09
salvage               3.490230  1.585881e+11
has_accidents         2.879044  1.139961e+11




