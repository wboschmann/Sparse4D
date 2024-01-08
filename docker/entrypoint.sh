#!/bin/bash

# Default to 'bash' if not set
SPARSE4D_MODE=${SPARSE4D_MODE:-bash}

echo "Selected mode: $SPARSE4D_MODE"

case "$SPARSE4D_MODE" in
  train)
    echo "Starting Training..."
    # Training command
    local_train.sh sparse4d_r101_H4
    ;;

  test)
    echo "Starting Testing..."
    # Testing command
    bash local_test.sh sparse4d_r101_H4 ./model_zoo/sparse4dv1_r101_H4_release.pth --show-dir data/img_bbox
    ;;

  data_prep)
    echo "Starting Data Preparation..."
    # Data preparation command
    python ./tools/create_data.py nuscenes --root-path ./data/nuscenes --out-dir ./data/nuscenes_cam --extra-tag nuscenes
    ;;

  bash)
    # If 'bash' is selected or as a fallback
    echo "Opening bash shell..."
    exec /bin/bash
    ;;

  *)
    echo "Unknown mode: $SPARSE4D_MODE. Opening bash shell as fallback."
    exec /bin/bash
    ;;
esac
