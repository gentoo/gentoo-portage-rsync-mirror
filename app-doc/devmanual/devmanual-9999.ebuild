# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/devmanual/devmanual-9999.ebuild,v 1.6 2013/02/26 18:31:19 hwoarang Exp $

EAPI=5

inherit git-2 readme.gentoo

DESCRIPTION="The Gentoo Development Guide"
HOMEPAGE="http://devmanual.gentoo.org/"
EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/devmanual.git"

LICENSE="CC-BY-SA-2.0"
SLOT="0"
# Live ebuild but does not build anything. It should work everywhere
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh
~sparc ~x86"
IUSE=""

DEPEND="dev-libs/libxslt
	media-gfx/imagemagick[truetype]"

DOC_CONTENTS="In order to browse the Gentoo Development Guide in
	offline mode, point your browser to the following url:
	/usr/share/doc/devmanual-9999/html/index.html"

src_install() {
	dohtml -r *
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
	if ! has_version app-portage/eclass-manpages; then
		elog "The offline version of the devmanual does not include the"
		elog "documentation for the eclasses. If you need it, then emerge"
		elog "the following package:"
		elog
		elog "app-portage/eclass-manpages"
		elog
	fi
}
