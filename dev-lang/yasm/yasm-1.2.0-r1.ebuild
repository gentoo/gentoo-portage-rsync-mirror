# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/yasm/yasm-1.2.0-r1.ebuild,v 1.7 2015/03/03 06:13:53 dlan Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
inherit autotools eutils python-r1

DESCRIPTION="An assembler for x86 and x86_64 instruction sets"
HOMEPAGE="http://yasm.tortall.net/"
SRC_URI="http://www.tortall.net/projects/yasm/releases/${P}.tar.gz
	mirror://gentoo/${P}-x32.patch.xz"

LICENSE="BSD-2 BSD || ( Artistic GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="-* amd64 ~arm64 x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~x86-solaris"
IUSE="nls python"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="nls? ( sys-devel/gettext )
	python? (
		${PYTHON_DEPS}
		>=dev-python/cython-0.14[${PYTHON_USEDEP}]
		)"

DOCS=( AUTHORS )

src_prepare() {
	sed -i -e 's:xmlto:&dIsAbLe:' configure.ac || die #459940
	epatch "${WORKDIR}"/${P}-x32.patch #435838
	chmod a+rx modules/objfmts/elf/tests/{gas,}x32/*_test.sh
	epatch "${FILESDIR}/${P}-fix_cython_check.patch"
	# ksh doesn't grok $(xxx), makes aclocal fail
	sed -i -e '1c\#!/usr/bin/env sh' YASM-VERSION-GEN.sh || die
	eautoreconf
}

src_configure() {
	use python && python_export_best

	econf \
		$(use_enable python) \
		$(use_enable python python-bindings) \
		$(use_enable nls)
}

src_test() {
	emake check
}
