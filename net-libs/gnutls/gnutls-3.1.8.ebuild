# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnutls/gnutls-3.1.8.ebuild,v 1.1 2013/02/10 14:35:24 flameeyes Exp $

EAPI=5

inherit autotools libtool eutils versionator

DESCRIPTION="A TLS 1.2 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/gcrypt/gnutls/v$(get_version_component_range 1-2)/${P}.tar.xz"

# LGPL-3 for libgnutls library and GPL-3 for libgnutls-extra library.
# soon to be relicensed as LGPL-2.1 unless heartbeat extension enabled.
LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE_LINGUAS=" en cs de fi fr it ms nl pl sv uk vi zh_CN"
IUSE="+cxx dane doc examples guile nls pkcs11 static-libs test zlib ${IUSE_LINGUAS// / linguas_}"
# heartbeat support is not disabled until re-licensing happens fullyf

# NOTICE: sys-devel/autogen is required at runtime as we
# use system libopts
RDEPEND=">=dev-libs/libtasn1-2.14
	>=dev-libs/nettle-2.5[gmp]
	sys-devel/autogen
	dane? ( net-dns/unbound )
	guile? ( >=dev-scheme/guile-1.8[networking] )
	nls? ( virtual/libintl )
	pkcs11? ( >=app-crypt/p11-kit-0.11 )
	zlib? ( >=sys-libs/zlib-1.2.3.1 )"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.11.6
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )
	nls? ( sys-devel/gettext )
	test? ( app-misc/datefudge )"

DOCS=( AUTHORS ChangeLog NEWS README THANKS doc/TODO )

src_prepare() {
	local dir file

	# tests/suite directory is not distributed.
	sed -i \
		-e ':AC_CONFIG_FILES(\[tests/suite/Makefile\]):d' \
		-e '/^AM_INIT_AUTOMAKE/s/-Werror//' \
		configure.ac || die

	sed -i \
		-e 's/imagesdir = $(infodir)/imagesdir = $(htmldir)/' \
		doc/Makefile.am || die

	rm -f {m4,gl/m4}/{lt*,libtool.m4}
	find . -name ltmain.sh -delete

	# use system libopts
	sed -i -e "/^enable_local_libopts/s/yes/no/" configure.ac || die

	# force regeneration of autogen-ed files
	for file in $(grep -l AutoGen-ed src/*.c) ; do
		rm src/$(basename ${file} .c).{c,h} || die
	done

	# support user patches
	epatch_user

	eautoreconf

	# Use sane .so versioning on FreeBSD.
	elibtoolize
}

src_configure() {
	LINGUAS="${LINGUAS//en/en@boldquot en@quot}"

	# TPM needs to be tested before being enabled
	econf \
		--htmldir="${EPREFIX}/usr/share/doc/${PF}/html" \
		--disable-silent-rules \
		--disable-valgrind-tests \
		--enable-heartbeat-support \
		$(use_enable cxx) \
		$(use_enable dane libdane) \
		$(use_enable doc gtk-doc) \
		$(use_enable doc gtk-doc-pdf) \
		$(use_enable guile) \
		$(use_enable nls) \
		$(use_enable static-libs static) \
		$(use_with pkcs11 p11-kit) \
		$(use_with zlib) \
		--without-tpm
}

src_install() {
	default

	find "${ED}" -name '*.la' -delete

	dodoc doc/certtool.cfg

	if use doc; then
		dodoc doc/gnutls.pdf
		dohtml doc/gnutls.html
	fi

	if use examples; then
		docinto examples
		dodoc doc/examples/*.c
	fi
}
