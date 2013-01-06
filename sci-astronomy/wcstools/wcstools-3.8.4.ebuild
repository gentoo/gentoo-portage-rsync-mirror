# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcstools/wcstools-3.8.4.ebuild,v 1.1 2011/09/23 19:17:31 xarthisius Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="World Coordinate System library for astronomical FITS images"
HOMEPAGE="http://tdc-www.harvard.edu/software/wcstools"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DOCS=( Readme Programs NEWS libned/NED_client )

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-3.8.3-autotools.patch \
		"${FILESDIR}"/${P}-overflows.patch \
		"${FILESDIR}"/${P}-implicits.patch

	# avoid colliding with fixdos, getdate and remap from other packages
	sed -i \
		-e 's/getdate/wcsgetdate/' \
		-e 's/crlf/wcscrlf/' \
		-e 's/remap/wcsremap/' \
		-e "s/3.... Programs/${PV} Programs/" \
		wcstools || die
	eautoreconf
}

src_test() {
	einfo "Testing various wcstools programs"
	./newfits -a 10 -j 248 41 -p 0.15 test.fits || die "test newfits failed"
	./sethead test.fits A=1 B=1 ||  die "test sethead failed"
	[[ "$(./gethead test.fits RA)" == "16:32:00.0000" ]] \
		|| die "test gethead failed"
	rm -f test.fits
}

src_install() {
	default
	doman Man/man1/*
	newdoc libwcs/Readme Readme.libwcs
	newdoc libwcs/NEWS NEWS.libwcs
}

pkg_postinst() {
	elog "The following execs have been renamed to avoid colliding"
	elog "with other packages:"
	elog " getdate -> wcsgetdate"
	elog " crlf    -> wcscrlf"
	elog " remap   -> wcsremap"
}
