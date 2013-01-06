# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/acgmake/acgmake-1.4.ebuild,v 1.3 2011/05/11 20:03:08 angelos Exp $

inherit eutils multilib

S=${WORKDIR}/${PN}
DESCRIPTION="Build system for large projects"
HOMEPAGE="http://www-i8.informatik.rwth-aachen.de/index.php?id=17"
SRC_URI="http://www.graphics.rwth-aachen.de/fileadmin/download/software/acgmake/${P}.tgz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="app-shells/bash
	sys-devel/make"

src_unpack() {
	unpack ${A}
	cd "${S}"

	chmod 644 "${S}"/configs/*
	chmod 644 "${S}"/modules/*

	# Get rid of moc-qt4 and uic-qt4 paths.
	# Fix libdir for qt libs.
	sed -i \
		-e 's:-qt4$::'  \
		-e "s,\(QT4_LIBDIR := \).*,\1/usr/$(get_libdir)/qt4," \
		configs/config.Linux || die

	# Allow ebuilds to set CXXFLAGS
	epatch "${FILESDIR}"/${PN}-1.2-cflags.patch
}

src_install() {
	insinto /usr/$(get_libdir)/misc/acgmake
	doins Config Rules
	cp -a bin configs modules "${D}"/usr/$(get_libdir)/misc/acgmake

	dosym ../$(get_libdir)/misc/acgmake/bin/acgmake /usr/bin/acgmake
}
