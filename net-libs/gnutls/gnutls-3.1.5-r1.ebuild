# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnutls/gnutls-3.1.5-r1.ebuild,v 1.4 2012/12/23 09:40:46 alonbl Exp $

EAPI=4

inherit autotools libtool eutils

DESCRIPTION="A TLS 1.2 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"

if [[ "${PV}" == *pre* ]]; then
	SRC_URI="http://daily.josefsson.org/${P%.*}/${P%.*}-${PV#*pre}.tar.gz"
else
	SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"
fi

# LGPL-3 for libgnutls library and GPL-3 for libgnutls-extra library.
LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="+cxx dane doc examples guile nls pkcs11 static-libs test zlib"
IUSE_LINGUAS="en cs de fi fr it ms nl pl sv uk vi zh_CN"
for lingua in ${IUSE_LINGUAS}; do
	IUSE+=" linguas_${lingua}"
done
unset lingua

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
	sys-devel/libtool
	doc? ( dev-util/gtk-doc )
	nls? ( sys-devel/gettext )
	test? ( app-misc/datefudge )"

S=${WORKDIR}/${P%_pre*}

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

	epatch "${FILESDIR}"/${PN}-3.1.3-guile-parallelmake.patch

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
