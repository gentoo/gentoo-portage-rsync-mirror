# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/rox-rename/rox-rename-0.4.0.ebuild,v 1.1 2008/01/22 17:38:46 lack Exp $

inherit rox

MY_PN="Rename"

DESCRIPTION="Rename can rename multiple files based on a regular expression."
HOMEPAGE="http://php.apsique.com/project/Rename"
SRC_URI="http://php.apsique.com/files/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-lang/ruby-1.8
	dev-ruby/ruby-libglade2"

APPNAME=${MY_PN}
S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"/${MY_PN}
	sed -i -e 's|0.0.3|0.4.0|' AppRun || die "failed to fix version"
	sed -i -e 's|0.0.3|0.4.0|' Rename.xml || die "failed to fix version"
	rm -f Rename.xml.asc
}
