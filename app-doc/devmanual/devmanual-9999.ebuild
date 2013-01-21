# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/devmanual/devmanual-9999.ebuild,v 1.2 2013/01/21 20:02:24 hwoarang Exp $

EAPI=5

inherit git-2

DESCRIPTION="The Gentoo Development Guide"
HOMEPAGE="http://devmanual.gentoo.org/"
EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/devmanual.git"

LICENSE="CCPL-Attribution-ShareAlike-2.0"
SLOT="0"
# Live ebuild but does not build anycode. It should work everywhere
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh
~sparc ~x86"
IUSE=""

DEPEND="dev-libs/libxslt
	media-gfx/imagemagick[truetype]"

src_install() {
	dohtml -r *
}

pkg_postinst() {
	elog
	elog "In order to browse the Gentoo Development Guide in"
	elog "offline mode, point your browser to the following url:"
	elog "/usr/share/doc/devmanual-9999/html/index.html"
	elog
}
