# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/acgmake/acgmake-1.2-r2.ebuild,v 1.3 2009/10/12 12:23:19 ssuominen Exp $

inherit eutils

S=${WORKDIR}/${PN}
DESCRIPTION="Build system for large projects"
HOMEPAGE="http://www-i8.informatik.rwth-aachen.de/software/acgmake/html/index.html"
SRC_URI="http://www-i8.informatik.rwth-aachen.de/software/acgmake/${P}.tgz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-shells/bash
	sys-devel/make"

src_unpack() {
	unpack ${A}
	cd "${S}"

	find . -name 'CVS' -type d -print0 | xargs -0 rm -rf
	sed -i "s:g++.*:g++:" configs/config.gcc-linux
	chmod 644 "${S}"/configs/*
	chmod 644 "${S}"/modules/*

	# Allow ebuilds to set CXXFLAGS
	epatch "${FILESDIR}"/${P}-cflags.patch
}

src_install() {
	insinto /usr/lib/misc/acgmake
	doins Config Rules
	cp -a bin configs modules "${D}"/usr/lib/misc/acgmake

	dosym ../lib/misc/acgmake/bin/acgmake /usr/bin/acgmake
}
