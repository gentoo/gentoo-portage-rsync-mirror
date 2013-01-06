# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/rox-rename/rox-rename-1.0.1.ebuild,v 1.3 2010/02/07 12:52:35 hwoarang Exp $

inherit rox

APPNAME="rox-rename"
APPCATEGORY="Utility"

DESCRIPTION="Rename can rename multiple files based on a regular expression."
HOMEPAGE="http://php.apsique.com/project/rox-rename"
SRC_URI="http://php.apsique.com/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

RDEPEND=">=dev-lang/ruby-1.8
	dev-ruby/ruby-libglade2"

S="${WORKDIR}"

src_install() {
	rox_src_install
	dosym /usr/bin/rox-rename /usr/bin/Rename
}
