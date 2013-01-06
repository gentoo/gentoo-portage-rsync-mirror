# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obmenu-generator/obmenu-generator-0.53.ebuild,v 1.4 2012/10/26 18:56:29 hasufell Exp $

EAPI=4

DESCRIPTION="A fast pipe/static menu generator for the Openbox Window Manager"
HOMEPAGE="http://trizen.go.ro/"
SRC_URI="http://trizen.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Data-Dump
	dev-perl/Linux-DesktopFiles
	x11-wm/openbox"

S=${WORKDIR}

src_install() {
	dobin ${PN}
}

pkg_postinst() {
	elog "No docs, run 'obmenu-generator -h' for help."
	elog "Config file will be created at"
	elog "~/.config/${PN}/config.pl"
}
