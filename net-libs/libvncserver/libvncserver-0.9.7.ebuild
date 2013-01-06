# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libvncserver/libvncserver-0.9.7.ebuild,v 1.11 2012/11/14 18:51:50 floppym Exp $

EAPI="2"

inherit libtool

DESCRIPTION="library for creating vnc servers"
HOMEPAGE="http://libvncserver.sourceforge.net/"
SRC_URI="http://libvncserver.sourceforge.net/LibVNCServer-${PV/_}.tar.gz
	mirror://sourceforge/libvncserver/LibVNCServer-${PV/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="no24bpp +jpeg test threads +zlib"

DEPEND="jpeg? ( virtual/jpeg )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/LibVNCServer-${PV/_}

src_prepare() {
	sed -i -r \
		-e '/^CFLAGS =/d' \
		-e "/^SUBDIRS/s:\<($(use test || echo 'test|')client_examples|contrib|examples)\>::g" \
		Makefile.in || die "sed foo"

	sed -i \
		-e '/^AM_CFLAGS/s: -g : :' \
		*/Makefile.in || die

	elibtoolize
}

src_configure() {
	econf \
		--disable-silent-rules \
		--without-x11vnc \
		$(use_with !no24bpp 24bpp) \
		$(use_with jpeg) \
		$(use_with threads pthread) \
		$(use_with zlib) \
		|| die
}

src_compile() {
	default
	emake -C examples noinst_PROGRAMS=storepasswd || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dobin examples/storepasswd
	dodoc AUTHORS ChangeLog NEWS README TODO
}
