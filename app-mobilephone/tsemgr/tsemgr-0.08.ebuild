# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/tsemgr/tsemgr-0.08.ebuild,v 1.7 2013/04/27 21:56:33 vapier Exp $

EAPI="4"

inherit eutils autotools

DESCRIPTION="Utility for Ericsson Mobile Phones"
HOMEPAGE="http://sourceforge.net/projects/tsemgr/"
SRC_URI="mirror://sourceforge/tsemgr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1*
	dev-libs/openobex
	dev-libs/libezV24"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	eautoreconf
}
