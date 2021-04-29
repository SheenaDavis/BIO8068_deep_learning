###Deep learning practicals 
##Part 1 - machine learning 

# First use
install.packages("keras")
library(keras)
install_keras()

# All subsequent use, simply issue
# library(keras)

# list of animals to model
animal_list <- c("Butterfly", "Cow", "Elephant", "Spider")

# number of output classes (i.e. fruits)
output_n <- length(animal_list)

# image size to scale down to (original images vary but about 600 x 800 px)
img_width <- 250
img_height <- 250
target_size <- c(img_width, img_height)

# RGB = 3 channels
channels <- 3

# path to image folders
train_image_files_path <- "Training\\"
valid_image_files_path <- "Validation\\"
#You should be able to confirm that there are the correct number of images
#in your dataset by issuing the command length(list.files(train_image_files_path, recursive = TRUE)),
#and similarly for the Validation folder with the valid_image_files_path.

#Data generators and augmentation
# Rescale from 255 to between zero and 1
train_data_gen = image_data_generator(
  rescale = 1/255
)

valid_data_gen <- image_data_generator(
  rescale = 1/255
)  

#The image_data_generator function controls what happens to the images as they are read into R

# training images
train_image_array_gen <- flow_images_from_directory(train_image_files_path, 
                                                    train_data_gen,
                                                    target_size = target_size,
                                                    class_mode = "categorical",
                                                    classes = animal_list,
                                                    seed = 42)

# validation images
valid_image_array_gen <- flow_images_from_directory(valid_image_files_path, 
                                                    valid_data_gen,
                                                    target_size = target_size,
                                                    class_mode = "categorical",
                                                    classes = animal_list,
                                                    seed = 42)

# Check that things seem to have been read in OK
cat("Number of images per class:")
table(factor(train_image_array_gen$classes))
