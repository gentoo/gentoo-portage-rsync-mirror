# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-plugins/quodlibet-plugins-3.0.2.ebuild,v 1.1 2014/02/06 11:13:10 ssuominen Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit python-r1

DESCRIPTION="Plugins for Quod Libet and Ex Falso"
HOMEPAGE="http://code.google.com/p/quodlibet/"
SRC_URI="http://quodlibet.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-sound/quodlibet-${PV}"
DEPEND=""

src_prepare() {
	rm -f README || die
}

src_install() {
	local python_moduleroot=quodlibet/plugins
	python_foreach_impl python_domodule .
}
