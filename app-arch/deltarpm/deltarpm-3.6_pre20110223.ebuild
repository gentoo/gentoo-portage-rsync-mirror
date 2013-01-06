# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/deltarpm/deltarpm-3.6_pre20110223.ebuild,v 1.1 2012/05/15 08:41:59 pacho Exp $

EAPI="4"
PYTHON_DEPEND="python? 2:2.7"

inherit eutils toolchain-funcs python

SNAPSHOT="20110223"

DESCRIPTION="tools to create and apply deltarpms"
HOMEPAGE="http://gitorious.org/deltarpm/deltarpm"
SRC_URI="http://pkgs.fedoraproject.org/repo/pkgs/${PN}/${PN}-git-${SNAPSHOT}.tar.bz2/70f8884be63614ca7c3fc888cf20ebc8/${PN}-git-${SNAPSHOT}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"

DEPEND="sys-libs/zlib
	app-arch/xz-utils
	app-arch/bzip2
	<app-arch/rpm-5"

S="${WORKDIR}/${PN}-git-${SNAPSHOT}"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	sed -i \
		-e '/^prefix/s:/local::' \
		-e '/^mandir/s:/man:/share/man:' \
		Makefile || die
	epatch "${FILESDIR}/3.6_pre20110223-build.patch"
}

src_compile() {
	emake -j1 CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" CC="$(tc-getCC)"

	if use python; then
		emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" CC="$(tc-getCC)" python
	fi
}
