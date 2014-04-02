# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obmenu-generator/obmenu-generator-0.59.ebuild,v 1.1 2014/04/02 21:05:06 hasufell Exp $

EAPI=5

DESCRIPTION="A fast pipe/static menu generator for the Openbox Window Manager"
HOMEPAGE="http://trizen.go.ro/"
SRC_URI="https://github.com/trizen/obmenu-generator/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Data-Dump
	>=dev-perl/Linux-DesktopFiles-0.80.0
	x11-wm/openbox"

src_install() {
	dobin ${PN}
	insinto /etc/xdg/obmenu-generator
	doins schema.pl
	newdoc README.md README
}

pkg_postinst() {
	elog "No docs, run 'obmenu-generator -h' for help."
	elog "Config file will be created at"
	elog "~/.config/${PN}/config.pl"
}
