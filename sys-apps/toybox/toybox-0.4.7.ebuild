# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/toybox/toybox-0.4.7.ebuild,v 1.1 2014/04/01 04:09:36 patrick Exp $

EAPI=5

inherit eutils

# makefile is stupid
RESTRICT="test"

DESCRIPTION="Common linux commands in a multicall binary"
HOMEPAGE="http://landley.net/code/toybox/"
SRC_URI="http://landley.net/code/toybox/downloads/${P}.tar.bz2"

# The source code does not explicitly say that it's BSD, but the author has repeatedly said it
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_configure() {
	:;
}

src_compile() {
	emake || die
}

src_test() {
	emake test || die
}

src_install() {
	mkdir -p "${D}/usr/bin"
	cp toybox "${D}/usr/bin" || die
}
