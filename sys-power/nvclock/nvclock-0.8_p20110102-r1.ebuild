# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/nvclock/nvclock-0.8_p20110102-r1.ebuild,v 1.8 2012/09/05 08:12:47 jlec Exp $

EAPI="2"

inherit autotools eutils flag-o-matic

DESCRIPTION="NVIDIA Overclocking Utility"
HOMEPAGE="http://www.linuxhardware.org/nvclock/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk nvcontrol"

RDEPEND="
	gtk? ( x11-libs/gtk+:2 )
	nvcontrol? ( x11-libs/libX11 x11-libs/libXext )
"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-make.patch \
		"${FILESDIR}"/${P}-usleep.patch
	eautoreconf
}

src_configure() {
	# libc_wrapper.c:54: warning: implicit declaration of function usleep
	append-flags -D_BSD_SOURCE

	# Qt support would mean Qt 3.
	econf --bindir=/usr/bin --disable-qt --docdir=/usr/share/doc/${PF} \
		$(use_enable gtk) $(use_enable nvcontrol)
}

src_compile() {
	emake -C src/ nvclock smartdimmer || die
	if use gtk; then
		emake -C src/gtk/ || die
	fi
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
