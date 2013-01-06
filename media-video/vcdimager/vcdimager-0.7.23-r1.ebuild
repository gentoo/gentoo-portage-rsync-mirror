# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vcdimager/vcdimager-0.7.23-r1.ebuild,v 1.15 2013/01/01 19:03:46 armin76 Exp $

EAPI=5
inherit eutils

DESCRIPTION="GNU VCDimager"
HOMEPAGE="http://www.vcdimager.org/"
SRC_URI="http://www.vcdimager.org/pub/${PN}/${PN}-${PV%.*}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE="+xml static-libs"

RDEPEND=">=dev-libs/libcdio-0.71[-minimal]
	dev-libs/popt
	xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

RESTRICT="test" #226249

DOCS="AUTHORS BUGS ChangeLog FAQ HACKING NEWS README THANKS TODO"

src_configure() {
	# We disable the xmltest because the configure script includes differently
	# than the actual XML-frontend C files.
	local myconf
	use xml && myconf="--with-xml-prefix=/usr --disable-xmltest"
	use xml || myconf="--without-xml-frontend"
	econf $(use_enable static-libs static) ${myconf}
}

src_install() {
	default
	prune_libtool_files
}
