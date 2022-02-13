.PHONY: all clean-build clean

all: transfer_fncs_2_mlx1.mlx

transfer_fncs_2_mlx1.mlx: $(shell find transfer_fncs_2_mlx1)
	cd $< && \
		zip -vr ../$@ *

clean-build: clean all

clean: *.slx
	-rm -rf $^
