# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/autotools-multilib.eclass,v 1.7 2013/01/26 11:39:41 mgorny Exp $

# @ECLASS: autotools-multilib.eclass
# @MAINTAINER:
# Michał Górny <mgorny@gentoo.org>
# @BLURB: autotools-utils wrapper for multilib builds
# @DESCRIPTION:
# The autotools-multilib.eclass is an autotools-utils.eclass(5) wrapper
# introducing support for building for more than one ABI (multilib).
#
# Inheriting this eclass sets IUSE=multilib and exports autotools-utils
# phase function wrappers which build the package for each supported ABI
# if the flag is enabled. Otherwise, it works like regular
# autotools-utils.
#
# Note that the multilib support requires out-of-source builds to be
# enabled. Thus, it is impossible to use AUTOTOOLS_IN_SOURCE_BUILD with
# it.

# EAPI=5 is required for meaningful MULTILIB_USEDEP.
case ${EAPI:-0} in
	5) ;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

if [[ ${AUTOTOOLS_IN_SOURCE_BUILD} ]]; then
	die "${ECLASS}: multilib support requires out-of-source builds."
fi

inherit autotools-utils multilib multiprocessing

EXPORT_FUNCTIONS src_configure src_compile src_test src_install

IUSE=multilib

# @ECLASS-VARIABLE: MULTILIB_USEDEP
# @DESCRIPTION:
# The USE-dependency to be used on dependencies (libraries) needing
# to support multilib as well.
#
# Example use:
# @CODE
# RDEPEND="dev-libs/libfoo[${MULTILIB_USEDEP}]
#	net-libs/libbar[ssl,${MULTILIB_USEDEP}]"
# @CODE
MULTILIB_USEDEP='multilib(-)?'

# @FUNCTION: autotools-multilib_foreach_abi
# @USAGE: argv...
# @DESCRIPTION:
# If multilib support is enabled, sets the toolchain up for each
# supported ABI along with the ABI variable and correct BUILD_DIR,
# and runs the given commands with them.
#
# If multilib support is disabled, it just runs the commands. No setup
# is done.
autotools-multilib_foreach_abi() {
	local initial_dir=${BUILD_DIR:-${S}}

	if use multilib; then
		local ABI
		for ABI in $(get_all_abis); do
			multilib_toolchain_setup "${ABI}"
			BUILD_DIR=${initial_dir%%/}-${ABI} "${@}"
		done
	else
		"${@}"
	fi
}

# @FUNCTION: autotools-multilib_parallel_foreach_abi
# @USAGE: argv...
# @DESCRIPTION:
# If multilib support is enabled, sets the toolchain up for each
# supported ABI along with the ABI variable and correct BUILD_DIR,
# and runs the given commands with them. The commands are run
# in parallel with number of jobs being determined from MAKEOPTS.
#
# If multilib support is disabled, it just runs the commands. No setup
# is done.
#
# Useful for running configure scripts.
autotools-multilib_parallel_foreach_abi() {
	local initial_dir=${BUILD_DIR:-${S}}

	if use multilib; then
		multijob_init

		local ABI
		for ABI in $(get_all_abis); do
			(
				multijob_child_init

				multilib_toolchain_setup "${ABI}"
				BUILD_DIR=${initial_dir%%/}-${ABI}
				"${@}"
			) &

			multijob_post_fork
		done

		multijob_finish
	else
		"${@}"
	fi
}

autotools-multilib_src_configure() {
	autotools-multilib_parallel_foreach_abi autotools-utils_src_configure
}

autotools-multilib_src_compile() {
	autotools-multilib_foreach_abi autotools-utils_src_compile
}

autotools-multilib_src_test() {
	autotools-multilib_foreach_abi autotools-utils_src_test
}

autotools-multilib_src_install() {
	autotools-multilib_foreach_abi autotools-utils_src_install
}
