# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-gfx/sdl-gfx-2.0.22.ebuild,v 1.8 2011/07/17 21:25:58 halcy0n Exp $

EAPI=2
inherit autotools multilib

MY_P="${P/sdl-/SDL_}"
DESCRIPTION="Graphics drawing primitives library for SDL"
HOMEPAGE="http://www.ferzkopp.net/joomla/content/view/19/14/"
SRC_URI="http://www.ferzkopp.net/Software/SDL_gfx-2.0/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc mmx static-libs"

DEPEND="media-libs/libsdl[video]"

S=${WORKDIR}/${MY_P}

src_prepare() {
	mkdir m4
	sed -i -e 's/-O //' configure.in || die "sed failed"
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable mmx) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	use doc && dohtml -r Docs/*
	use static-libs || rm -f "${D}"/usr/$(get_libdir)/lib*.la
}
