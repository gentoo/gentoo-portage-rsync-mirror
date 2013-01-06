# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/rox-rename/rox-rename-0.0.3.ebuild,v 1.2 2007/03/23 18:04:49 armin76 Exp $

inherit rox

MY_PN="Rename"

DESCRIPTION="Rename can rename multiple files based on a regular expression."
HOMEPAGE="http://php.apsique.com/project/Rename"
SRC_URI="http://php.apsique.com/files/proyectos/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86"

RDEPEND="
	>=dev-lang/ruby-1.8
	dev-ruby/ruby-libglade2"

APPNAME=${MY_PN}
S=${WORKDIR}

src_unpack() {
	unpack ${A}
	rm -rf ${S}/${APPNAME}/.svn
	cd ${S}
}
