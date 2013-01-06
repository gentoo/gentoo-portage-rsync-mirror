# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libupnp/libupnp-1.6.6.ebuild,v 1.7 2010/10/11 10:53:24 hwoarang Exp $

WANT_AUTOMAKE=1.9

inherit eutils flag-o-matic autotools

DESCRIPTION="An Portable Open Source UPnP Development Kit"
HOMEPAGE="http://pupnp.sourceforge.net/"
SRC_URI="mirror://sourceforge/pupnp/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug"

src_unpack() {
	unpack ${A}
	cd "${S}"

	AT_M4DIR="m4" eautoreconf

	# fix tests
	chmod +x ixml/test/test_document.sh
}

src_compile() {
	use x86-fbsd &&	append-flags -O1
	# w/o docdir to avoid sandbox violations
	econf \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dobin upnp/sample/upnp_tv_{ctrlpt,device,combo}
	dodoc NEWS README ChangeLog
}

pkg_postinst() {
	ewarn "Please remember to run revdep-rebuild when upgrading"
	ewarn "from libupnp 1.4.x to libupnp 1.6.x , so packages"
	ewarn "gets linked with the new library."
	ewarn ""
	ewarn "The revdep-rebuild script is part of the"
	ewarn "app-portage/gentoolkit package."
	ebeep
}
