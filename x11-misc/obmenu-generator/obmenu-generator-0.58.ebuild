# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obmenu-generator/obmenu-generator-0.58.ebuild,v 1.2 2013/11/09 10:36:14 hasufell Exp $

EAPI=5

DESCRIPTION="A fast pipe/static menu generator for the Openbox Window Manager"
HOMEPAGE="http://trizen.go.ro/"
SRC_URI="http://trizen.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Data-Dump
	>=dev-perl/Linux-DesktopFiles-0.80.0
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
