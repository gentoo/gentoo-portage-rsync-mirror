# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vcdimager/vcdimager-0.7.23.ebuild,v 1.17 2012/05/05 08:58:52 jdhore Exp $

inherit eutils libtool

DESCRIPTION="GNU VCDimager"
HOMEPAGE="http://www.vcdimager.org/"
SRC_URI="http://www.vcdimager.org/pub/vcdimager/vcdimager-0.7/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="xml minimal"
RESTRICT="test"

RDEPEND=">=dev-libs/libcdio-0.71
	!minimal? ( dev-libs/popt )
	xml? ( >=dev-libs/libxml2-2.5.11 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	local myconf

	# We disable the xmltest because the configure script includes differently
	# than the actual XML-frontend C files.
	use xml && myconf="${myconf} --with-xml-prefix=/usr --disable-xmltest"
	use xml || myconf="${myconf} --without-xml-frontend"

	econf \
		$(use_with !minimal cli-frontends) \
		${myconf} \
		--disable-dependency-tracking || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog FAQ HACKING NEWS README THANKS TODO
}
