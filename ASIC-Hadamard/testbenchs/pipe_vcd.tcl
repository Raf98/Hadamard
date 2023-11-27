
help -variable rangecnst_severity_level
set rangecnst_severity_level ignore
set textio_severity_level ignore
database -open pipe.vcd -vcd
probe -all -depth all -database pipe.vcd :pipe
run
database -close pipe.vcd

