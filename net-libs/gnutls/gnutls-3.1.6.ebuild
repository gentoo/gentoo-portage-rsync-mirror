# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnutls/gnutls-3.1.6.ebuild,v 1.7 2013/01/20 19:56:21 alonbl Exp $

EAPI=4

WANT_AUTOMAKE="1.11.6"

inherit autotools libtool eutils

DESCRIPTION="A TLS 1.2 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/gcrypt/gnutls/v${PV:0:3}/${P}.tar.xz"

# LGPL-3 for libgnutls library and GPL-3 for libgnutls-extra library.
LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE_LINGUAS=" en cs de fi fr it ms nl pl sv uk vi zh_CN"
IUSE="+cxx dane doc examples guile nls pkcs11 static-libs test zlib ${IUSE_LINGUAS// / linguas_}"

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

	for dir in m4 gl/m4; do
		rm -f "${dir}/lt"* "${dir}/libtool.m4"
	done
	find . -name ltmain.sh -exec rm {} \;

	# use system libopts
	sed -i -e "/^enable_local_libopts/s/yes/no/" configure.ac || die

	# force regeneration of autogen-ed files
	for file in $(grep -l AutoGen-ed src/*.c) ; do
		rm src/$(basename ${file} .c).{c,h} || die
	done

	epatch "${FILESDIR}/${P}-danetool.patch"

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

src_test() {
	# let it build in parallel
	emake check
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +

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
