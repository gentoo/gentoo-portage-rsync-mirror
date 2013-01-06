# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dropbox/dropbox-1.4.7-r1.ebuild,v 1.3 2012/09/24 00:46:46 vapier Exp $

EAPI="4"

inherit gnome2-utils pax-utils

DESCRIPTION="Dropbox daemon (pretends to be GUI-less)"
HOMEPAGE="http://dropbox.com/"
SRC_URI="x86? ( http://dl-web.dropbox.com/u/17/dropbox-lnx.x86-${PV}.tar.gz )
	amd64? ( http://dl-web.dropbox.com/u/17/dropbox-lnx.x86_64-${PV}.tar.gz )"

LICENSE="CCPL-Attribution-NoDerivs-3.0 FTL MIT LGPL-2 openssl dropbox"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-linux"
IUSE="+librsync-bundled"
RESTRICT="mirror strip"

QA_FLAGS_IGNORED="opt/${PN}/.*"
QA_EXECSTACK_x86="opt/dropbox/_ctypes.so"
QA_EXECSTACK_amd64="opt/dropbox/_ctypes.so"

DEPEND="dev-util/patchelf"

# Be sure to have GLIBCXX_3.4.9, #393125
RDEPEND="
	app-arch/bzip2
	dev-libs/popt
	dev-libs/openssl:0.9.8
	media-libs/libpng:1.2
	!librsync-bundled? ( net-libs/librsync )
	net-misc/wget
	>=sys-devel/gcc-4.2.0
	sys-libs/zlib
	x11-themes/hicolor-icon-theme
"

src_unpack() {
	unpack ${A}
	mkdir -p "${S}"
	mv "${WORKDIR}/.dropbox-dist" "${S}"/src || die
	cd "${S}"/src
	rm -vf libstdc++.so.6 libz* libssl* libbz2* libpopt.so.0 libcrypto.so.0.9.8 libpng12.so.0 || die
	if ! use librsync-bundled; then
		rm -vf librsync.so.1 || die
	else
		patchelf --set-rpath '$ORIGIN' _librsync.so || die
	fi
	pax-mark cm "${S}/src/dropbox"
	cd "${WORKDIR}"
}

src_install() {
	cd src || die
	dodoc README ACKNOWLEDGEMENTS
	rm README ACKNOWLEDGEMENTS || die

	local targetdir="/opt/dropbox"
	insinto "${targetdir}"
	doins -r *
	fperms a+x "${targetdir}/dropbox"
	fperms a+x "${targetdir}/dropboxd"
	dosym "${targetdir}/dropboxd" "/opt/bin/dropbox"

	insinto /usr/share
	doins -r icons

	newinitd "${FILESDIR}"/dropbox.initd dropbox
	newconfd "${FILESDIR}"/dropbox.conf dropbox
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
