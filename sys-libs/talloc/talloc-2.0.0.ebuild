# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/talloc/talloc-2.0.0.ebuild,v 1.4 2009/11/04 11:30:19 patrick Exp $

EAPI="2"

inherit confutils eutils

DESCRIPTION="Samba talloc library"
HOMEPAGE="http://talloc.samba.org/"
SRC_URI="http://samba.org/ftp/talloc/${P}.tar.gz"
LICENSE="GPL-3"
IUSE="compat"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc64 ~x86"

DEPEND="
	!<net-fs/samba-libs-3.4
	"
RDEPEND="${DEPEND}"

src_prepare() {

	./autogen.sh || die "autogen.sh failed"

	sed -i \
		-e 's|SHLD_FLAGS = @SHLD_FLAGS@|SHLD_FLAGS = @SHLD_FLAGS@ @LDFLAGS@|' \
		-e 's|CC = @CC@|CC = @CC@\
LDFLAGS = @LDFLAGS@|' \
		Makefile.in || die "sed failed"

}

src_configure() {

	econf \
		--sysconfdir=/etc/samba \
		--localstatedir=/var \
		--enable-largefile \
		$(use_enable compat talloc-compat1) \
	|| die "econf failed"

}

src_compile() {

	emake showflags || die "emake showflags failed"
	emake shared-build || die "emake shared-build failed"

}

src_install() {

	emake install DESTDIR="${D}" || die "emake install failed"
	dolib.a sharedbuild/lib/libtalloc.a
	dolib.so sharedbuild/lib/libtalloc.so

}
