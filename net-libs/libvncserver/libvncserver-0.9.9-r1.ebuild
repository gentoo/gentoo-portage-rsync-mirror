# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libvncserver/libvncserver-0.9.9-r1.ebuild,v 1.4 2013/02/27 04:24:49 zmedico Exp $

EAPI="4"

inherit eutils libtool

DESCRIPTION="library for creating vnc servers"
HOMEPAGE="http://libvncserver.sourceforge.net/"
SRC_URI="http://libvncserver.sourceforge.net/LibVNCServer-${PV/_}.tar.gz
	mirror://sourceforge/${PN}/LibVNCServer-${PV/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux"
IUSE="+24bpp gcrypt gnutls ipv6 +jpeg +png ssl static-libs test threads +zlib"

REQUIRED_USE="png? ( zlib )"

DEPEND="
	gcrypt? ( dev-libs/libgcrypt )
	gnutls? (
		net-libs/gnutls
		dev-libs/libgcrypt
	)
	!gnutls? (
		ssl? ( dev-libs/openssl )
	)
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng:0 )
	zlib? ( sys-libs/zlib )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/LibVNCServer-${PV/_}

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_prepare() {
	sed -i -r \
		-e '/^CFLAGS =/d' \
		-e "/^SUBDIRS/s:\<($(use test || echo 'test|')client_examples|examples)\>::g" \
		Makefile.in || die

	elibtoolize
}

src_configure() {
	econf \
		--disable-silent-rules \
		--without-x11vnc \
		$(use_enable static-libs static) \
		$(use_with 24bpp) \
		$(use_with gnutls) \
		$(usex gnutls --with-gcrypt $(use_with gcrypt)) \
		$(usex gnutls --without-ssl $(use_with ssl)) \
		$(use_with ipv6) \
		$(use_with jpeg) \
		$(use_with png) \
		$(use_with threads pthread) \
		$(use_with zlib)
}

src_compile() {
	default
	emake -C examples noinst_PROGRAMS=storepasswd
}

src_install() {
	default
	prune_libtool_files
}
