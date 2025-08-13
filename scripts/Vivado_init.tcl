set_param sta.enableAdaptiveDeskew false
set_param clock.gclkDeskew off
set_param route.enableImuxHoldFixing false
set_param physynth.enableClockOptImuxHoldFix false
set_param route.enableImrFilterInSkewOpt false
set_param route.enableIriQuadClockModSkewOpt false
set_param physynth.enableLeafTapInVersal false
set_param physynth.enableCOEClkModDelay false
set_param physynth.ClockOptEnableVersalPulsedLatchOpt false
set_param route.optimizeLeafClkProgDlys false
set_param place.constrainDSPCascadesRBRK 1

#Required only for ES grade silicon
set_param bitstream.enablePR 8519
set_param hd.enablePR 2591
#Need to add the following parameter as well for DFX in order to enable this in the GUI:
set_param bd.enableDFX 1

#Hold recredit of 160ps for AIE <-> BLI Paths
proc waive_BLI_AIE_hold_violations { hold_margin } { 
  set debug 0
  set bliFD [lsort [get_cells -hier -filter "REF_NAME=~FD* && LOC=~BLI_*"]]
  if {$debug && $bliFD == {}} { puts "Warning - No registers placed on BLI sites found" }

  set aiePL [get_cells -quiet -hier -filter "REF_NAME=~AIE_PL_*"]
  if {$debug && $aiePL == {}} { puts "Warning - No AIE_PL_* cells found" }

  if {$bliFD != {} && $aiePL != {}} {
    set_property IS_LOC_FIXED 1 $bliFD -quiet
    set_min_delay -from $bliFD -to $aiePL $hold_margin -quiet
    set_min_delay -from $aiePL -to $bliFD $hold_margin -quiet
  }
}

rename place_design orig_place_design
proc place_design { args } {
   eval "orig_place_design $args"
   puts "DEBUG: Starting Post-Placer with waiver script for AIE <-> BLI paths"
   waive_BLI_AIE_hold_violations -0.16
} 
