import os
import glob
import pickle
import numpy as np
from scipy.io import loadmat
import tensorflow.keras as keras

from my_classes import DataGenerator

model_from_json = keras.models.model_from_json
ModelCheckpoint = keras.callbacks.ModelCheckpoint

Sequential = keras.models.Sequential
Dense = keras.layers.Dense

Flatten = keras.layers.Flatten
Dropout = keras.layers.Dropout

np.random.seed(7)


print("Creating data partition...")

file_list = []
for matfile in glob.glob('unsieved_concat/*.mat'):
    for i in range(56250 - 32):
        file_list.append([matfile, i])

np.random.shuffle(file_list)

total_data = len(file_list)
train_size = int(total_data * 0.7)
val_size = int((total_data - train_size) / 2)
test_size = val_size

partition = {
    'train': file_list[:train_size],
    'val': file_list[train_size:train_size + val_size],
    'test': file_list[train_size + val_size:train_size + val_size + test_size]
}

os.makedirs("models/nnet2", exist_ok=True)

with open('nnet2_partition.pickle', 'wb') as handle:
    pickle.dump(partition, handle, protocol=pickle.HIGHEST_PROTOCOL)

print("Partition saved.")


with open('nnet2_partition.pickle', 'rb') as handle:
    partition = pickle.load(handle)


params = {
    'dim': (16, 32),
    'batch_size': 64,
    'n_classes': 5,
    'n_channels': 1,
    'shuffle': True
}

training_generator = DataGenerator(partition['train'], [], **params)
validation_generator = DataGenerator(partition['val'], [], **params)
testing_generator = DataGenerator(partition['test'], [], **params)

print(f"Test samples: {len(partition['test'])}")

print("Building model...")

model = Sequential()
model.add(Flatten(input_shape=(*params['dim'], 1)))
model.add(Dense(512, activation='relu'))
model.add(Dense(512, activation='relu'))
model.add(Dropout(0.25))
model.add(Dense(5, activation='softmax'))

model.compile(
    loss='sparse_categorical_crossentropy',
    optimizer='adam',
    metrics=['accuracy']
)


print("Training model...")

filepath = "models/nnet2/weights-{epoch:02d}-{val_accuracy:.2f}.hdf5"

checkpoint = ModelCheckpoint(
    filepath,
    monitor='val_accuracy',
    verbose=1,
    save_best_only=True,
    mode='max'
)

history = model.fit(
    training_generator,
    validation_data=validation_generator,
    workers=4,
    epochs=5,
    callbacks=[checkpoint],
    verbose=1
)


print("Saving model...")

model_json = model.to_json()
with open("models/nnet2/model.json", "w") as json_file:
    json_file.write(model_json)


print("Loading best model for evaluation...")

with open('models/nnet2/model.json', 'r') as json_file:
    loaded_model_json = json_file.read()

model = model_from_json(loaded_model_json)

weights_path = 'weights.hdf5'

model.load_weights(weights_path)

model.compile(
    loss='sparse_categorical_crossentropy',
    optimizer='adam',
    metrics=['accuracy']
)

print("Evaluating model...")

scores = model.evaluate(
    testing_generator,
    verbose=1
)

print(f"\nTest Accuracy: {scores[1] * 100:.2f}%")