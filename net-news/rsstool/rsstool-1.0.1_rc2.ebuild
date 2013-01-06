# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rsstool/rsstool-1.0.1_rc2.ebuild,v 1.3 2012/01/04 09:12:43 radhermit Exp $

EAPI=4

inherit eutils toolchain-funcs

MY_P=${PN}-${PV/_}

DESCRIPTION="cmdline tool to read, parse, merge, and write RSS (and Atom) feeds"
HOMEPAGE="http://rsstool.sourceforge.net/"
SRC_URI="mirror://berlios/${PN}/${MY_P}-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/libxml2
	net-misc/curl"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_P}-src/src

src_prepare() {
	sed -i '1i#!/bin/bash' configure || die
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	emake DESTDIR="${D}" BINDIR="/usr/bin" install
	dohtml ../*.html
}
