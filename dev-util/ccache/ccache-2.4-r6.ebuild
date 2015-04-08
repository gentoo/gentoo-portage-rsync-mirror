# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ccache/ccache-2.4-r6.ebuild,v 1.19 2010/12/16 20:42:34 robbat2 Exp $

WANT_AUTOMAKE=none # not using automake

inherit eutils autotools

DESCRIPTION="fast compiler cache"
HOMEPAGE="http://ccache.samba.org/"
SRC_URI="http://samba.org/ftp/ccache/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

# Note: this version is designed to be auto-detected and used if
# you happen to have Portage 2.0.X+ installed.

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/ccache-2.4-respectflags.patch
	epatch "${FILESDIR}"/ccache-2.4-utimes.patch
	eautoconf
}

do_links() {
	insinto /usr/lib/ccache/bin
	for a in ${CHOST}-{gcc,g++,c++} gcc c++ g++; do
	    dosym /usr/bin/ccache /usr/lib/ccache/bin/${a}
	done
}

src_install() {
	dobin ccache || die
	doman ccache.1
	dodoc README
	dohtml web/*.html

	diropts -m0755
	dodir /usr/lib/ccache/bin
	keepdir /usr/lib/ccache/bin

	dobin "${FILESDIR}"/ccache-config || die

	diropts -m0700
	dodir /root/.ccache
	keepdir /root/.ccache
}

pkg_preinst() {
	# Do NOT duplicate this in your ebuilds or phear of the wrath!!!
	if [[ ${ROOT} = "/" ]] ; then
	    einfo "Scanning for compiler front-ends..."
	    do_links
	else
	    ewarn "Install is incomplete; you must run the following commands:"
	    ewarn " # ccache-config --install-links"
	    ewarn " # ccache-config --install-links ${CHOST}"
	    ewarn "after booting or chrooting to ${ROOT} to complete installation."
	fi
}

pkg_postinst() {
	# nuke broken symlinks from previous versions that shouldn't exist
	for i in cc ${CHOST}-cc ; do
	    [[ -L "${ROOT}/usr/lib/ccache/bin/${i}" ]] && rm -rf "${ROOT}/usr/lib/ccache/bin/${i}"
	done
	[[ -d "${ROOT}/usr/lib/ccache.backup" ]] && rm -fr "${ROOT}/usr/lib/ccache.backup"

	elog "To use ccache with **non-Portage** C compiling, add"
	elog "/usr/lib/ccache/bin to the beginning of your path, before /usr/bin."
	elog "Portage 2.0.46-r11+ will automatically take advantage of ccache with"
	elog "no additional steps.  If this is your first install of ccache, type"
	elog "something like this to set a maximum cache size of 2GB:"
	elog "# ccache -M 2G"
}
