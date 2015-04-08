# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/coolkey/coolkey-1.1.0-r4.ebuild,v 1.3 2012/05/03 18:16:38 jdhore Exp $

EAPI=3

inherit eutils

PDATE="20110419"

DESCRIPTION="Linux Driver support for the CoolKey and CAC products"
HOMEPAGE="http://directory.fedora.redhat.com/wiki/CoolKey"
SRC_URI="http://directory.fedora.redhat.com/download/coolkey/${P}.tar.gz
	mirror://gentoo/${PN}-patches-${PDATE}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND=">=sys-apps/pcsc-lite-1.6.4
	dev-libs/nss[utils]
	sys-libs/zlib"

DEPEND="${RDEPEND}
	>=app-crypt/ccid-1.4.0
	virtual/pkgconfig"

pkg_setup() {
	pk="pk11install"
	dbdir="/etc/pki/nssdb"
	ck_mod_name="CoolKey PKCS #11 Module"

	if ! [[ -x $dbdir ]]; then
		ewarn "No /etc/pki/nssdb found; check under \$HOME/.pki and"
		ewarn "follow the suggested commands using the correct path."
	fi
}

src_prepare() {
	epatch "${WORKDIR}/${PN}-patches/01_${PN}-cache-dir-move.patch"
	epatch "${WORKDIR}/${PN}-patches/02_${P}-gcc43.patch"
	epatch "${WORKDIR}/${PN}-patches/03_${P}-latest.patch"
	epatch "${WORKDIR}/${PN}-patches/04_${P}-simple-bugs.patch"
	epatch "${WORKDIR}/${PN}-patches/05_${P}-thread-fix.patch"
	epatch "${WORKDIR}/${PN}-patches/06_${P}-cac.patch"
	epatch "${WORKDIR}/${PN}-patches/07_${PN}-cac-1.patch"
	epatch "${WORKDIR}/${PN}-patches/08_${PN}-pcsc-lite-fix.patch"
}

src_configure() {
	econf --enable-pk11install $(use_enable debug) \
		|| die "configure failed"
}

src_compile() {
	emake CFLAGS+="-fno-strict-aliasing" -j1 || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	diropts -m 1777
	keepdir /var/cache/coolkey
}

pkg_postinst() {
	if [[ -x $dbdir ]]; then
		if ! $(modutil -rawlist -dbdir $dbdir | grep libcoolkeypk11); then
			elog "You still need to install libcoolkey in your PKCS11 library:"
			elog "$pk -p $dbdir 'name=$ck_mod_name library=libcoolkeypk11.so'"

		fi
	else
		elog ""
		elog "You still need to setup your PKCS11 library, or at least"
		elog "find where it is (perhaps \$HOME/.pki/nssdb).  Once you"
		elog "find it, use 'modutil -rawlist -dbdir \$db' to look for"
		elog "libcoolkeypk11.so, and if not found, add it using:"
		elog ""
		elog "$pk -p \$db 'name=$ck_mod_name library=libcoolkeypk11.so'"
		elog ""
		elog "where \$db is the full path to your pki/nssdb directory."
		elog ""
	fi
}

pkg_postrm() {
	if [[ -x $dbdir ]]; then
		if $(modutil -rawlist -dbdir $dbdir | grep libcoolkeypk11); then
			elog "You should remove libcoolkey from your PKCS11 library."
		fi
	fi
}
