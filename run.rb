#!/usr/bin/env ruby

gcloud = ARGV.shift + " "
slave_jar = ARGV.shift
host = ARGV.shift
zone = ARGV.shift

at_exit do
  system(gcloud + "compute instances stop #{ host } --zone #{ zone }")
end

system(gcloud + "compute instances start #{ host } --zone #{ zone }")
system(gcloud + "compute copy-files #{ slave_jar } #{ host }:slave.jar --zone #{ zone }")
system(gcloud + "compute ssh #{ host } --command 'java -jar slave.jar' --zone #{ zone }")
