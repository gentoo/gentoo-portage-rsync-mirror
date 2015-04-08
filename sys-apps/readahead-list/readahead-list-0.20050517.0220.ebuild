# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/readahead-list/readahead-list-0.20050517.0220.ebuild,v 1.5 2014/08/10 20:24:55 slyfox Exp $

DESCRIPTION="Preloads files into the page cache to accelerate program loading"
HOMEPAGE="http://www.orbis-terrarum.net"
SRC_URI="http://tirpitz.iat.sfu.ca/custom-software/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="doc"

RDEPEND=""
# the blocked headers are broken
# they don't compile properly!
DEPEND="${RDEPEND}
		virtual/os-headers"

src_compile() {
	econf --sbindir=/sbin || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# init scripts
	cd "${S}/contrib/init/gentoo/"
	newinitd init.d-readahead-list readahead-list
	newinitd init.d-readahead-list-early readahead-list-early
	newconfd conf.d-readahead-list readahead-list

	# default config
	insinto /etc/readahead-list
	cd "${S}/contrib/data"
	newins readahead.runlevel-default.list runlevel-default
	newins readahead.runlevel-boot.list runlevel-boot
	newins readahead._sbin_rc.list exec_sbin_rc

	# docs
	cd "${S}"
	dodoc README
	if use doc; then
		docinto scripts
		dodoc contrib/scripts/*
	fi
	# clean up a bit
	find "${D}/usr/share/doc/${PF}/" -type f -name 'Makefile*' -exec rm -f \{} \;
}

pkg_postinst() {
	einfo "You should add readahead-list to your runlevels:"
	einfo "  rc-update add readahead-list-early boot"
	einfo "  rc-update add readahead-list boot"
	einfo "Also consider customizing the lists in /etc/readahead-list"
	einfo "for maximum performance gain."
}
