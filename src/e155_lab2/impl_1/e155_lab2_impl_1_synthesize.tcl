if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/2024.2} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) "1"
set para(prj_dir) "C:/Users/kanparker/Downloads/e155_lab2/src/e155_lab2"
if {![file exists {C:/Users/kanparker/Downloads/e155_lab2/src/e155_lab2/impl_1}]} {
  file mkdir {C:/Users/kanparker/Downloads/e155_lab2/src/e155_lab2/impl_1}
}
cd {C:/Users/kanparker/Downloads/e155_lab2/src/e155_lab2/impl_1}
# synthesize IPs
# synthesize VMs
# synthesize top design
file delete -force -- e155_lab2_impl_1.vm e155_lab2_impl_1.ldc
::radiant::runengine::run_engine_newmsg synthesis -f "C:/Users/kanparker/Downloads/e155_lab2/src/e155_lab2/impl_1/e155_lab2_impl_1_lattice.synproj" -logfile "e155_lab2_impl_1_lattice.srp"
::radiant::runengine::run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o e155_lab2_impl_1_syn.udb e155_lab2_impl_1.vm] [list e155_lab2_impl_1.ldc]

} out]} {
   ::radiant::runengine::runtime_log $out
   exit 1
}
