# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libseccomp/libseccomp-2.1.0.ebuild,v 1.4 2013/08/28 11:17:28 ago Exp $

# Note: USE=static-libs isn't great -- only PIC objects are provided.

EAPI="4"

inherit eutils

DESCRIPTION="high level interface to Linux seccomp filter"
HOMEPAGE="http://sourceforge.net/projects/libseccomp/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="static-libs"

src_prepare() {
	sed -i \
		-e '/^SUBDIRS_BUILD/s:tests::' \
		Makefile || die
	sed -i \
		-e '/^LDFLAGS/s|:=|+=|' \
		{tests,tools}/Makefile || die
	export MAKEOPTS+=" V=1"
	tc-export AR CC
	export GCC=${CC}
}

src_test() {
	emake SUBDIRS_BUILD='tests'
	cd tests
	./regression || die
}

src_install() {
	default
	use static-libs && dolib.a src/libseccomp.a
}
