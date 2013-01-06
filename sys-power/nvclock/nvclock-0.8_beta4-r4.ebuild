# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/nvclock/nvclock-0.8_beta4-r4.ebuild,v 1.3 2012/09/05 08:12:47 jlec Exp $

EAPI="2"

inherit eutils autotools toolchain-funcs

MY_P="${PN}${PV/_beta/b}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="NVIDIA Overclocking Utility"
HOMEPAGE="http://www.linuxhardware.org/nvclock/"
SRC_URI="http://www.linuxhardware.org/nvclock/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gtk"

RDEPEND="gtk? ( x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}"

src_prepare() {
	# Bug #240846:
	epatch "${FILESDIR}"/${P}-flags.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch
	epatch "${FILESDIR}"/${P}-headers.patch

	sed -e 's:NV-CONROL:NV-CONTROL:g' -i configure.in
	sed -i Makefile.in -e "s:/share/doc/nvclock:/share/doc/${PF}:g" || \
		die "sed failed"

	eautoreconf
}

src_configure() {
	tc-export CC CXX

	local myconf

	myconf="--bindir=/usr/bin"

	if use gtk; then
		myconf="${myconf} --enable-nvcontrol"
	else
		myconf="${myconf} --disable-nvcontrol"
	fi

	econf --disable-qt $(use_enable gtk) ${myconf} || die
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/bin
	emake DESTDIR="${D}" install || die
	#dodoc AUTHORS README

	newinitd "${FILESDIR}"/nvclock_initd nvclock
	newconfd "${FILESDIR}"/nvclock_confd nvclock

	#domenu nvclock.desktop
	#validate_desktop_entries /usr/share/applications/nvclock.desktop
}

pkg_postinst() {
	elog "To enable card overclocking at startup, edit your /etc/conf.d/nvclock"
	elog "accordingly and then run: rc-update add nvclock default"
}
