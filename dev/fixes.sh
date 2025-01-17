#!/bin/bash

# This script should be executed after generating a new `LibP4est.jl` bindings file using Clang.jl
# via `generator.jl`. It corrects a number of issues that are not (easily) fixable through Clang.jl alone.
# Note for macOS users: This script needs to be run on a Linux machine, since `sed` cannot be
#                       used in a portable manner with `-i` on Linux and macOS systems. Sorry!

LIB_JL="Libt8.jl"

set -euxo pipefail

# Remove Fortran macros
sed -i "/INTEGER(KIND/d" "${LIB_JL}"

# Remove other probably unused macros
sed -i "/P4EST_NOTICE/d" "${LIB_JL}"
sed -i "/P4EST_GLOBAL_NOTICE/d" "${LIB_JL}"

# Fix MPI types that have been wrongly converted to Julia types
sed -i "s/mpicomm::Cint/mpicomm::MPI_Comm/g" "${LIB_JL}"
sed -i "s/\bcomm::Cint/comm::MPI_Comm/g" "${LIB_JL}"
sed -i "s/\bintranode::Ptr{Cint}/intranode::Ptr{MPI_Comm}/g" "${LIB_JL}"
sed -i "s/\binternode::Ptr{Cint}/internode::Ptr{MPI_Comm}/g" "${LIB_JL}"
sed -i "s/mpifile::Cint/mpifile::MPI_File/g" "${LIB_JL}"
sed -i "s/mpidatatype::Cint/mpidatatype::MPI_Datatype/g" "${LIB_JL}"
sed -i "s/\bt::Cint/t::MPI_Datatype/g" "${LIB_JL}"

# Fix type of `sc_array` field `array`
sed -i "s/array::Cstring/array::Ptr{Int8}/g" "${LIB_JL}"

# Remove cross references that are not found
sed -i "s/\[\`p4est\`](@ref)/\`p4est\`/g" "${LIB_JL}"
sed -i "s/\[\`p6est\`](@ref)/\`p6est\`/g" "${LIB_JL}"
sed -i "s/\[\`p8est\`](@ref)/\`p8est\`/g" "${LIB_JL}"
sed -i "s/\[\`P4EST_QMAXLEVEL\`](@ref)/\`P4EST_QMAXLEVEL\`/g" "${LIB_JL}"
sed -i "s/\[\`P8EST_QMAXLEVEL\`](@ref)/\`P8EST_QMAXLEVEL\`/g" "${LIB_JL}"
sed -i "s/\[\`P4EST_CONN_DISK_PERIODIC\`](@ref)/\`P4EST_CONN_DISK_PERIODIC\`/g" "${LIB_JL}"
sed -i "s/\[\`p8est_iter_corner_side_t\`](@ref)/\`p8est_iter_corner_side_t\`/g" "${LIB_JL}"
sed -i "s/\[\`p8est_iter_edge_side_t\`](@ref)/\`p8est_iter_edge_side_t\`/g" "${LIB_JL}"
sed -i "s/\[\`p4est_corner_info_t\`](@ref)/\`p4est_corner_info_t\`/g" "${LIB_JL}"
sed -i "s/\[\`p8est_corner_info_t\`](@ref)/\`p8est_corner_info_t\`/g" "${LIB_JL}"
sed -i "s/\[\`p8est_edge_info_t\`](@ref)/\`p8est_edge_info_t\`/g" "${LIB_JL}"
sed -i "s/\[\`sc_MPI_Barrier\`](@ref)/\`sc_MPI_Barrier\`/g" "${LIB_JL}"
sed -i "s/\[\`sc_MPI_COMM_NULL\`](@ref)/\`sc_MPI_COMM_NULL\`/g" "${LIB_JL}"
sed -i "s/\[\`SC_CHECK_ABORT\`](@ref)/\`SC_CHECK_ABORT\`/g" "${LIB_JL}"
sed -i "s/\[\`SC_LP_DEFAULT\`](@ref)/\`SC_LP_DEFAULT\`/g" "${LIB_JL}"
sed -i "s/\[\`SC_LC_NORMAL\`](@ref)/\`SC_LC_NORMAL\`/g" "${LIB_JL}"
sed -i "s/\[\`SC_LC_GLOBAL\`](@ref)/\`SC_LC_GLOBAL\`/g" "${LIB_JL}"
sed -i "s/\[\`SC_LP_ALWAYS\`](@ref)/\`SC_LP_ALWAYS\`/g" "${LIB_JL}"
sed -i "s/\[\`SC_LP_SILENT\`](@ref)/\`SC_LP_SILENT\`/g" "${LIB_JL}"
sed -i "s/\[\`SC_LP_THRESHOLD\`](@ref)/\`SC_LP_THRESHOLD\`/g" "${LIB_JL}"
sed -i "s/\[\`sc_logf\`](@ref)/\`sc_logf\`/g" "${LIB_JL}"

# For nicer docstrings
sed -i "s/\`p4est\`.h/\`p4est.h\`/g" "${LIB_JL}"
sed -i "s/\`p8est\`.h/\`p8est.h\`/g" "${LIB_JL}"

sed -i "/_sc_const/d" "${LIB_JL}"
sed -i "/_sc_restrict/d" "${LIB_JL}"
sed -i "/sc_keyvalue_t/d" "${LIB_JL}"

sed -i "/T8_VERSION_POINT/d" "${LIB_JL}"
sed -i "/P4EST_VERSION_POINT/d" "${LIB_JL}"

sed -i "/P4EST_GLOBAL_NOTICE/d" "${LIB_JL}"
sed -i "/P4EST_NOTICE/d" "${LIB_JL}"

sed -i "/P4EST_F90_QCOORD/d" "${LIB_JL}"
sed -i "/P4EST_F90_TOPIDX/d" "${LIB_JL}"
sed -i "/P4EST_F90_LOCIDX/d" "${LIB_JL}"
sed -i "/P4EST_F90_GLOIDX/d" "${LIB_JL}"

sed -i "/MPI_ERR_GROUP/d" "${LIB_JL}"
