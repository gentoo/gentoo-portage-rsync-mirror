# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/autotools-multilib.eclass,v 1.19 2013/11/24 10:53:43 mgorny Exp $

# @ECLASS: autotools-multilib.eclass
# @MAINTAINER:
# Michał Górny <mgorny@gentoo.org>
# @BLURB: autotools-utils wrapper for multilib builds
# @DESCRIPTION:
# The autotools-multilib.eclass is an autotools-utils.eclass(5) wrapper
# introducing support for building for more than one ABI (multilib).
#
# Inheriting this eclass sets the USE flags and exports autotools-utils
# phase function wrappers which build the package for each supported ABI
# when the relevant flag is enabled. Other than that, it works like
# regular autotools-utils.
#
# The multilib phase functions can be overriden via defining multilib_*
# phase functions as in multilib-minimal.eclass. In some cases you may
# need to call the underlying autotools-utils_* phase though.
#
# Note that the multilib support requires out-of-source builds to be
# enabled. Thus, it is impossible to use AUTOTOOLS_IN_SOURCE_BUILD with
# it.

# EAPI=4 is required for meaningful MULTILIB_USEDEP.
case ${EAPI:-0} in
	4|5) ;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

if [[ ${AUTOTOOLS_IN_SOURCE_BUILD} ]]; then
	die "${ECLASS}: multilib support requires out-of-source builds."
fi

inherit autotools-utils eutils multilib-build multilib-minimal

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_test src_install

# bug #485046
_autotools-multilib_fix_multilib_minimal() {
	src_conf=$(declare -f multilib-minimal_src_configure)
	src_conf=${src_conf/multilib_foreach_abi/multilib_parallel_foreach_abi}
	eval "${src_conf}"
}
_autotools-multilib_fix_multilib_minimal

# Note: _at_args[@] passing is a backwards compatibility measure.
# Don't use it in new packages.

autotools-multilib_src_prepare() {
	autotools-utils_src_prepare "${@}"

	[[ ${AUTOTOOLS_IN_SOURCE_BUILD} ]] && multilib_copy_sources
}

multilib_src_configure() {
	[[ ${AUTOTOOLS_IN_SOURCE_BUILD} ]] && local ECONF_SOURCE=${BUILD_DIR}
	autotools-utils_src_configure "${_at_args[@]}"
}

autotools-multilib_src_configure() {
	local _at_args=( "${@}" )

	multilib-minimal_src_configure
}

multilib_src_compile() {
	emake "${_at_args[@]}"
}

autotools-multilib_src_compile() {
	local _at_args=( "${@}" )

	multilib-minimal_src_compile
}

multilib_src_test() {
	autotools-utils_src_test "${_at_args[@]}"
}

autotools-multilib_src_test() {
	local _at_args=( "${@}" )

	multilib-minimal_src_test
}

multilib_src_install() {
	emake DESTDIR="${D}" "${_at_args[@]}" install
}

multilib_src_install_all() {
	einstalldocs

	# Remove libtool files and unnecessary static libs
	local prune_ltfiles=${AUTOTOOLS_PRUNE_LIBTOOL_FILES}
	if [[ ${prune_ltfiles} != none ]]; then
		prune_libtool_files ${prune_ltfiles:+--${prune_ltfiles}}
	fi
}

autotools-multilib_src_install() {
	local _at_args=( "${@}" )

	multilib-minimal_src_install
}
