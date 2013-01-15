# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/yasm/yasm-9999.ebuild,v 1.2 2013/01/15 02:41:42 vapier Exp $

EAPI=4
PYTHON_DEPEND="python? 2:2.7"
inherit autotools eutils python
if [[ ${PV} == "9999"* ]] ; then
	EGIT_REPO_URI="git://github.com/yasm/yasm.git"
	inherit git-2
else
	SRC_URI="http://www.tortall.net/projects/yasm/releases/${P}.tar.gz"
	KEYWORDS="-* ~amd64 ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~x86-solaris"
fi

DESCRIPTION="An assembler for x86 and x86_64 instruction sets"
HOMEPAGE="http://yasm.tortall.net/"

LICENSE="BSD-2 BSD || ( Artistic GPL-2 LGPL-2 )"
SLOT="0"
IUSE="nls python"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="nls? ( sys-devel/gettext )
	python? ( >=dev-python/cython-0.14 )"

DOCS=( AUTHORS )

pkg_setup() {
	# Python is required for generating x86insns.c, see
	# modules/arch/x86/Makefile.inc for more details.
	if use python || [[ ${PV} == "9999" ]] ; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	# ksh doesn't grok $(xxx), makes aclocal fail
	sed -i -e '1c\#!/usr/bin/env sh' YASM-VERSION-GEN.sh || die
	eautoreconf

	if [[ ${PV} == "9999" ]] ; then
		./modules/arch/x86/gen_x86_insn.py || die
	fi
}

src_configure() {
	econf \
		--disable-warnerror \
		$(use_enable python) \
		$(use_enable python python-bindings) \
		$(use_enable nls)
}
