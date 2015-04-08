# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/torrentinfo/torrentinfo-1.0.2.ebuild,v 1.6 2010/10/10 19:07:07 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"

inherit distutils

DESCRIPTION="A torrent file parser"
HOMEPAGE="http://vrai.net/project.php?project=torrentinfo"
SRC_URI="http://vrai.net/files/software_projects/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
