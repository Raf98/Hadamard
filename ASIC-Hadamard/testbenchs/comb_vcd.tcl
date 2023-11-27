
help -variable rangecnst_severity_level
set rangecnst_severity_level ignore
set textio_severity_level ignore
database -open comb.vcd -vcd
probe -all -depth all -database comb.vcd :comb
run
database -close comb.vcd

