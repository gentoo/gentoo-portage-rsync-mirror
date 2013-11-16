# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/wxwidgets.eclass,v 1.35 2013/11/16 08:21:23 dirtyepic Exp $

# @ECLASS:			wxwidgets.eclass
# @MAINTAINER:
#  wxwidgets@gentoo.org
# @BLURB:			Manages build configuration for wxGTK-using packages.
# @DESCRIPTION:
#  The wxGTK libraries come in several different possible configurations
#  (release, debug, ansi, unicode, etc.) most of which can be installed
#  side-by-side.  The purpose of this eclass is to provide ebuilds the ability
#  to build against a specific type of profile without interfering with the
#  user-set system configuration.
#
#  Ebuilds that use wxGTK _must_ inherit this eclass.
#
# - Using this eclass -
#
#  1. set WX_GTK_VER to a valid wxGTK SLOT
#  2. inherit wxwidgets
#  3. add an appropriate DEPEND
#  4. done
#
# @CODE
#    WX_GTK_VER="2.8"
#
#    inherit wxwidgets
#
#    DEPEND="x11-libs/wxGTK:2.8[X]"
#    RDEPEND="${DEPEND}"
#    [...]
# @CODE
#
#  This will get you the default configuration, which is what you want 99%
#  of the time.
#
#  If your package has optional wxGTK support controlled by a USE flag or you
#  need to use the wxBase libraries (USE="-X") then you should not set
#  WX_GTK_VER before inherit and instead refer to the need-wxwidgets function
#  below.
#
#  The variable WX_CONFIG is exported, containing the absolute path to the
#  wx-config file to use.  Most configure scripts use this path if it's set in
#  the environment or accept --with-wx-config="${WX_CONFIG}".

inherit eutils multilib

case "${EAPI:-0}" in
	0|1)
		EXPORT_FUNCTIONS pkg_setup
		;;
	*)
		;;
esac

# We do this globally so ebuilds can get sane defaults just by inheriting.  They
# can be overridden with need-wxwidgets later if need be.

# ensure this only runs once
if [[ -z ${WX_CONFIG} ]]; then
	# and only if WX_GTK_VER is set before inherit
	if [[ -n ${WX_GTK_VER} ]]; then
		for wxtoolkit in gtk2 base; do
			# newer versions don't have a seperate debug profile
			for wxdebug in xxx release- debug-; do
				wxconf="${wxtoolkit}-unicode-${wxdebug/xxx/}${WX_GTK_VER}"
				if [[ -f ${EPREFIX}/usr/$(get_libdir)/wx/config/${wxconf} ]]; then
					# if this is a wxBase install, die in pkg_setup
					[[ ${wxtoolkit} == "base" ]] && WXBASE_DIE=1
				else
					continue
				fi
				WX_CONFIG="${EPREFIX}/usr/$(get_libdir)/wx/config/${wxconf}"
				WX_ECLASS_CONFIG="${WX_CONFIG}"
				break
			done
			[[ -n ${WX_CONFIG} ]] && break
		done
		[[ -n ${WX_CONFIG} ]] && export WX_CONFIG WX_ECLASS_CONFIG
	fi
fi

# @FUNCTION:		wxwidgets_pkg_setup
# @DESCRIPTION:
#
#  It's possible for wxGTK to be installed with USE="-X", resulting in something
#  called wxBase.  There's only ever been a couple packages in the tree that use
#  wxBase so this is probably not what you want.  Whenever possible, use EAPI 2
#  USE dependencies(tm) to ensure that wxGTK was built with USE="X".  This
#  function is only exported for EAPI 0 or 1 and catches any remaining cases.
#
#  If you do use wxBase, don't set WX_GTK_VER before inherit.  Use
#  need-wxwidgets() instead.

wxwidgets_pkg_setup() {
	[[ -n $WXBASE_DIE ]] && check_wxuse X
}

# @FUNCTION:		need-wxwidgets
# @USAGE:			<configuration>
# @DESCRIPTION:
#
#  Available configurations are:
#
#    unicode       (USE="X")
#    base-unicode  (USE="-X")
#
#  If your package has optional wxGTK support controlled by a USE flag, set
#  WX_GTK_VER inside a conditional rather than before inherit.  Some broken
#  configure scripts will force wxGTK on if they find ${WX_CONFIG} set.
#
# @CODE
#    src_configure() {
#      if use wxwidgets; then
#          WX_GTK_VER="2.8"
#          if use X; then
#            need-wxwidgets unicode
#          else
#            need-wxwidgets base-unicode
#          fi
#      fi
# @CODE
#

need-wxwidgets() {
	debug-print-function $FUNCNAME $*

	local wxtoolkit wxdebug wxconf

	if [[ -z ${WX_GTK_VER} ]]; then
		echo
		eerror "WX_GTK_VER must be set before calling $FUNCNAME."
		echo
		die "WX_GTK_VER missing"
	fi

	if [[ ${WX_GTK_VER} != 2.8 && ${WX_GTK_VER} != 2.9 ]]; then
			echo
			eerror "Invalid WX_GTK_VER: ${WX_GTK_VER} - must be set to a valid wxGTK SLOT."
			echo
			die "Invalid WX_GTK_VER"
	fi

	debug-print "WX_GTK_VER is ${WX_GTK_VER}"

	case $1 in
		unicode|base-unicode) ;;
		*)
			eerror "Invalid $FUNCNAME argument: $1"
			echo
			die
			;;
	esac

	# TODO: remove built_with_use

	# wxBase can be provided by both gtk2 and base installations
	if built_with_use =x11-libs/wxGTK-${WX_GTK_VER}* X; then
		wxtoolkit="gtk2"
	else
		wxtoolkit="base"
	fi

	debug-print "wxtoolkit is ${wxtoolkit}"

	# 2.8 has a separate debug tuple
	if [[ ${WX_GTK_VER} == 2.8 ]]; then
		if built_with_use =x11-libs/wxGTK-${WX_GTK_VER}* debug; then
			wxdebug="debug-"
		else
			wxdebug="release-"
		fi
	fi

	debug-print "wxdebug is ${wxdebug}"

	# put it all together
	wxconf="${wxtoolkit}-unicode-${wxdebug}${WX_GTK_VER}"

	debug-print "wxconf is ${wxconf}"

	# if this doesn't work, something is seriously screwed
	if [[ ! -f ${EPREFIX}/usr/$(get_libdir)/wx/config/${wxconf} ]]; then
		echo
		eerror "Failed to find configuration ${wxconf}"
		echo
		die "Missing wx-config"
	fi

	debug-print "Found config ${wxconf} - setting WX_CONFIG"

	export WX_CONFIG="${EPREFIX}/usr/$(get_libdir)/wx/config/${wxconf}"

	debug-print "WX_CONFIG is ${WX_CONFIG}"

	export WX_ECLASS_CONFIG="${WX_CONFIG}"

	echo
	einfo "Requested wxWidgets:        ${1} ${WX_GTK_VER}"
	einfo "Using wxWidgets:            ${wxconf}"
	echo
}


# @FUNCTION:		check_wxuse
# @USAGE:			<USE flag>
# @DESCRIPTION:
#
#  Provides a consistant way to check if wxGTK was built with a particular USE
#  flag enabled.  A better way is EAPI 2 USE dependencies (hint hint).

check_wxuse() {
	debug-print-function $FUNCNAME $*

	if [[ -z ${WX_GTK_VER} ]]; then
		echo
		eerror "WX_GTK_VER must be set before calling $FUNCNAME."
		echo
		die "WX_GTK_VER missing"
	fi

	# TODO: Remove built_with_use

	ebegin "Checking wxGTK-${WX_GTK_VER} for ${1} support"
	if built_with_use =x11-libs/wxGTK-${WX_GTK_VER}* "${1}"; then
		eend 0
	else
		eend 1
		echo
		eerror "${FUNCNAME} - You have requested functionality that requires ${1} support to"
		eerror "have been built into x11-libs/wxGTK."
		eerror
		eerror "Please re-merge =x11-libs/wxGTK-${WX_GTK_VER}* with the ${1} USE flag enabled."
		die "Missing USE flags."
	fi
}
