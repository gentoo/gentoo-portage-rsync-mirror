# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rsstool/rsstool-1.0.0_rc4.ebuild,v 1.8 2012/01/04 09:12:43 radhermit Exp $

inherit versionator eutils
MY_PV=$(replace_version_separator 3 '')
MY_P=${PN}-${MY_PV}
S="${WORKDIR}/${MY_P}"-src/src
DESCRIPTION="cmdline tool to read, parse, merge, and write RSS (and Atom) feeds"
HOMEPAGE="http://rsstool.sourceforge.net/"
SRC_URI="mirror://berlios/${PN}/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/libxml2"
RDEPEND="dev-libs/libxml2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '1i#!/bin/bash' configure #141906
}

src_install() {
	emake DESTDIR="${D}" BINDIR="/usr/bin" install || die "emake install failed"
	dohtml ../*.html
}
