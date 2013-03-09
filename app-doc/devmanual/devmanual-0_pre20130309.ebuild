# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/devmanual/devmanual-0_pre20130309.ebuild,v 1.1 2013/03/09 17:13:03 hwoarang Exp $

EAPI=5

inherit readme.gentoo

[[ "${PV}" == "9999" ]] && inherit git-2

DESCRIPTION="The Gentoo Development Guide"
HOMEPAGE="http://devmanual.gentoo.org/"
if [[ "${PV}" == "9999" ]]; then
EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/devmanual.git"
else
SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${P}.tar.gz"
fi

LICENSE="CC-BY-SA-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh
~sparc ~x86"
IUSE=""

DEPEND="dev-libs/libxslt
	media-gfx/imagemagick[truetype]"

DOC_CONTENTS="In order to browse the Gentoo Development Guide in
	offline mode, point your browser to the following url:
	/usr/share/doc/devmanual/html/index.html"

src_install() {
	dohtml -r *
	einfo "Creating symlink from ${P} to ${PN} for preserving bookmarks"
	dosym /usr/share/doc/${P} /usr/share/doc/${PN}
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
