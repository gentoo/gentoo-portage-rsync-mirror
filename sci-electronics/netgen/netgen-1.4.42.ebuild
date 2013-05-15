# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/netgen/netgen-1.4.42.ebuild,v 1.1 2013/05/15 08:24:16 xmw Exp $

EAPI=4

inherit eutils

DESCRIPTION="LVS tool (layout versus schematic comparison)"
HOMEPAGE="http://www.opencircuitdesign.com/netgen/index.html"
SRC_URI="http://www.opencircuitdesign.com/${PN}/archive/${P}.tgz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X"

DEPEND="X? (
		dev-lang/tcl
		dev-lang/tk
		x11-libs/libX11 )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.4.40-tcl-bin-name.patch

	if $(use X) ; then
		cp -r "${S}" "${WORKDIR}"/with-x || die
	fi
}

src_configure() {
	cd scripts
	econf --without-x

	if $(use X) ; then
		cd "${WORKDIR}"/with-x/scripts || die
		econf --with-x
	fi
}

src_compile() {
	emake

	if $(use X) ; then
		cd "${WORKDIR}"/with-x || die
		emake
	fi
}

src_install() {
	emake DESTDIR="${D}" DOCDIR=/usr/share/doc/${PF} install

	if $(use X) ; then
		cd "${WORKDIR}"/with-x || die
		emake DESTDIR="${D}" DOCDIR=/usr/share/doc/${PF} install
	fi

	dodoc Changes README TO_DO
}
