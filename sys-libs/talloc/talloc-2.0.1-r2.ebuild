# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/talloc/talloc-2.0.1-r2.ebuild,v 1.1 2011/12/18 02:38:51 floppym Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="Samba talloc library"
HOMEPAGE="http://talloc.samba.org/"
SRC_URI="http://samba.org/ftp/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="compat doc static-libs swig"

RDEPEND=""
DEPEND="doc? ( app-text/docbook-xml-dtd:4.2
		dev-libs/libxslt )
	swig? ( dev-lang/swig )
	!<net-fs/samba-libs-3.4
	!<net-fs/samba-3.3"

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.0.0-without-doc.patch" \
		"${FILESDIR}"/${P}-respect-ldflags.patch

	eautoconf -Ilibreplace

	sed -i \
		-e 's:$(SHLD_FLAGS) :$(SHLD_FLAGS) $(LDFLAGS) :' \
		Makefile.in
}

src_configure() {
	if ! use swig ; then
		sed -i \
			-e '/swig/d' \
			talloc.mk || die "sed failed"
	fi

	if ! use static-libs ; then
		sed -i \
			-e 's|:: $(TALLOC_STLIB)|::|' \
			-e '/$(TALLOC_STLIB) /d' \
			-e '/libtalloc.a/d' \
			talloc.mk Makefile.in || die "sed failed"
	fi

	econf \
		--sysconfdir=/etc/samba \
		--localstatedir=/var \
		$(use_enable compat talloc-compat1) \
		$(use_with doc)
}

src_compile() {
	emake shared-build || die "emake shared-build failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	use doc && dohtml *.html

	# installs missing symlink
	dolib.so sharedbuild/lib/libtalloc.so{,.2}
}
