

help -variable rangecnst_severity_level
set rangecnst_severity_level ignore
set textio_severity_level ignore
database -open pipe1sample.vcd -vcd
probe -all -depth all -database pipe1sample.vcd :pipe1sample
run
database -close pipe1sample.vcd


