# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/nco/nco-4.0.8.ebuild,v 1.1 2011/12/30 04:10:40 bicatali Exp $

EAPI=4
inherit eutils flag-o-matic

DESCRIPTION="Command line utilities for operating on netCDF files"
HOMEPAGE="http://nco.sourceforge.net/"
SRC_URI="http://nco.sf.net/src/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="dap doc gsl ncap2 static-libs udunits"

RDEPEND=">=sci-libs/netcdf-4[dap=]
	gsl? ( sci-libs/gsl )
	udunits? ( >=sci-libs/udunits-2 )"

DEPEND="${RDEPEND}
	ncap2? ( dev-java/antlr:0 )
	doc? ( virtual/latex-base )"

src_configure() {
	local myconf
	if has_version '>=sci-libs/netcdf-4[hdf5]'; then
		myconf="--enable-netcdf4"
		append-flags -DHAVE_NETCDF4_H
	else
		myconf="--disable-netcdf4"
	fi
	if use dap; then
		myconf="${myconf} --enable-dap-netcdf --disable-dap-opendap"
	else
		myconf="${myconf} --disable-dap-netcdf --disable-dap-opendap"
	fi
	econf \
		--disable-udunits \
		$(use_enable gsl) \
		$(use_enable ncap2) \
		$(use_enable static-libs static) \
		$(use_enable udunits udunits2) \
		${myconf}
}

src_compile() {
	# TODO: workout -j1 to make sure lex generation is done
	emake -j1
	cd doc
	emake clean info
	use doc && VARTEXFONTS="${T}/fonts" emake html pdf
}

src_install() {
	default
	cd doc
	dodoc ANNOUNCE ChangeLog MANIFEST NEWS README TAG TODO VERSION *.txt
	doinfo *.info*
	use doc && dohtml nco.html/* && dodoc nco.pdf
}
