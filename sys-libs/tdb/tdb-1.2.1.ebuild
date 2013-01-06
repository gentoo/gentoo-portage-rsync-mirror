# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/tdb/tdb-1.2.1.ebuild,v 1.10 2011/04/01 20:33:03 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="python? 2:2.6"
inherit autotools python

DESCRIPTION="Samba tdb"
HOMEPAGE="http://tdb.samba.org/"
SRC_URI="http://samba.org/ftp/tdb/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="python static-libs tools tdbtest"

RDEPEND="!!<sys-libs/tdb-1.2.1"
DEPEND="!<net-fs/samba-libs-3.4
	!<net-fs/samba-3.3
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt"

pkg_setup() {
	if use python; then
		# Make sure the build system will use the right python bug #360033
	    python_set_active_version 2
	    python_pkg_setup
	fi
}

src_prepare() {
	eautoconf -Ilibreplace
	sed -i \
		-e 's:$(SHLD_FLAGS) :$(SHLD_FLAGS) $(LDFLAGS) :' \
		Makefile.in || die "sed failed"

	# xsltproc will display a warning but we can assume the xml files are valid
	sed -i \
		-e 's|$(XSLTPROC) -o|$(XSLTPROC) --nonet -o|' \
		tdb.mk || die "sed failed"
}

src_configure() {
	econf \
		--sysconfdir=/etc/samba \
		--localstatedir=/var \
		$(use_enable python)
}

src_compile() {
	# TODO:
	# - don't build static-libs in case of USE=-static-libs

	# we create the directories first to avoid workaround parallel build problem
	emake dirs || die "emake dirs failed"

	emake shared-build || die "emake shared-build failed"

	if use tdbtest ; then
		emake bin/tdbtest || die "emake tdbtest failed"
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	# installs a necessary symlink
	dolib.so sharedbuild/lib/libtdb.so

	dodoc docs/README

	use static-libs || rm -f "${D}"/usr/lib*/*.a
	use tools || rm -rf "${D}/usr/bin"
	use tdbtest && dobin bin/tdbtest
	use python && python_need_rebuild
}

src_test() {
	# the default src_test runs 'make test' and 'make check', letting
	# the tests fail occasionally (reason: unknown)
	emake check || die "emake check failed"
}
