# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/i3status/i3status-2.6.ebuild,v 1.3 2012/12/16 16:33:16 ago Exp $

EAPI=4

inherit toolchain-funcs versionator

DESCRIPTION="generates a status bar for dzen2, xmobar or similar"
HOMEPAGE="http://i3wm.org/i3status/"
SRC_URI="http://i3wm.org/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+caps"

RDEPEND="dev-libs/confuse
	>=dev-libs/yajl-2.0.2
	media-libs/alsa-lib
	net-wireless/wireless-tools"
DEPEND="${RDEPEND}
	caps? ( sys-libs/libcap )"

# borrowed from GSoC2010_Gentoo_Capabilities by constanze and flameyeys
# @FUNCTION: fcaps
# @USAGE: fcaps {uid:gid} {file-mode} {cap1[,cap2,...]} {file}
# @RETURN: 0 if all okay; non-zero if failure and fallback
# @DESCRIPTION:
# fcaps sets the specified capabilities in the effective and permitted set of
# the given file. In case of failure fcaps sets the given file-mode.
# Requires versionator.eclass
fcaps() {
	local uid_gid=$1
	local perms=$2
	local capset=$3
	local path=$4
	local res

	chmod $perms $path && \
	chown $uid_gid $path
	res=$?

	use caps || return $res

	#set the capability
	setcap "$capset=ep" "$path" &> /dev/null
	#check if the capabilitiy got set correctly
	setcap -v "$capset=ep" "$path" &> /dev/null
	res=$?

	if [ $res -ne 0 ]; then
		ewarn "Failed to set capabilities. Probable reason is missing kernel support."
		ewarn "Your kernel must have <FS>_FS_SECURITY enabled (e.g. EXT4_FS_SECURITY)"
		ewarn "where <FS> is the filesystem to store ${path}"
		if ! version_is_at_least 2.6.33 "$(uname -r)"; then
			ewarn "For kernel 2.6.32 or older, you will also need to enable"
			ewarn "SECURITY_FILE_CAPABILITIES."
		fi
		ewarn
		ewarn "Falling back to suid now..."
		chmod u+s ${path}
	fi
	return $res
}

pkg_setup() {
	tc-export CC
}

src_prepare() {
	sed -e "/@echo/d" -e "s:@\$(:\$(:g" -e "/setcap/d" \
		-e '/CFLAGS+=-g/d' -i Makefile || die
}

pkg_postinst() {
	fcaps 0:users 550 cap_net_admin "${ROOT}"/usr/bin/${PN}
	elog "You need to install x11-misc/xmobar or x11-misc/dzen to use ${PN}."
	elog "Please refer to manual: man ${PN}"
}
