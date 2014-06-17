# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libvncserver/libvncserver-0.9.9-r2.ebuild,v 1.1 2014/06/17 17:11:38 mgorny Exp $

EAPI="5"

inherit eutils libtool multilib-minimal

DESCRIPTION="library for creating vnc servers"
HOMEPAGE="http://libvncserver.sourceforge.net/"
SRC_URI="http://libvncserver.sourceforge.net/LibVNCServer-${PV/_}.tar.gz
	mirror://sourceforge/${PN}/LibVNCServer-${PV/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux"
IUSE="+24bpp gcrypt gnutls ipv6 +jpeg +png ssl static-libs test threads +zlib"

REQUIRED_USE="png? ( zlib )"

DEPEND="
	gcrypt? ( dev-libs/libgcrypt:0[${MULTILIB_USEDEP}] )
	gnutls? (
		net-libs/gnutls[${MULTILIB_USEDEP}]
		dev-libs/libgcrypt:0[${MULTILIB_USEDEP}]
	)
	!gnutls? (
		ssl? ( dev-libs/openssl[${MULTILIB_USEDEP}] )
	)
	jpeg? ( virtual/jpeg[${MULTILIB_USEDEP}] )
	png? ( media-libs/libpng:0[${MULTILIB_USEDEP}] )
	zlib? ( sys-libs/zlib[${MULTILIB_USEDEP}] )
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

multilib_src_configure() {
	ECONF_SOURCE=${S} \
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

multilib_src_compile() {
	default
	multilib_is_native_abi && emake -C examples noinst_PROGRAMS=storepasswd
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files
}
