top_name = tb
timeout_cycles = 10
#sim_type = run # without waveform
sim_type = run_debug # with waveform

verilator_bin = verilator

work_dir = $(abspath .)
work_dir_name = $(notdir $(abspath .))

docker_work_dir = /home/$(work_dir_name)
docker_image_name = verilator
docker_cmd = docker run -v $(work_dir):$(docker_work_dir) -it $(docker_image_name)

src_dir = $(docker_work_dir)/src

src_files = \
$(src_dir)/$(top_name).v \
$(src_dir)/main.cc

out_dirname = out
docker_out_dir = $(docker_work_dir)/$(out_dirname)

vcd_file = $(docker_out_dir)/$(top_name).vcd

default: clean
	$(docker_cmd) /usr/bin/make -C $(docker_work_dir) $(sim_type)

run: $(docker_out_dir)/V$(top_name)
	$<

run_debug: $(docker_out_dir)/V$(top_name)_debug
	$<

$(docker_out_dir)/V$(top_name):
	$(verilator_bin) --cc --exe -Mdir $(docker_out_dir) $(src_files) \
	-CFLAGS "-include V$(top_name).h -DVNAME=V$(top_name) -DTIMEOUT_CYCLES=$(timeout_cycles)" \
	-o $(docker_out_dir)/V$(top_name)
	make -C $(docker_out_dir) -f V$(top_name).mk

$(docker_out_dir)/V$(top_name)_debug:
	$(verilator_bin) --trace --cc --exe -Mdir $(docker_out_dir) $(src_files) \
	-CFLAGS "-include V$(top_name).h -DVNAME=V$(top_name) -DVM_TRACE" \
	-CFLAGS "-DVCD_FILE=$(vcd_file) -DTIMEOUT_CYCLES=$(timeout_cycles)" \
	-o $(docker_out_dir)/V$(top_name)_debug
	make -C $(docker_out_dir) -f V$(top_name).mk

clean:
	$(docker_cmd) /bin/rm -rf $(docker_out_dir)

debug:
	@echo $(abspath .)
	@echo $(notdir $(abspath .))
