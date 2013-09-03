# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgpg/kgpg-4.11.1.ebuild,v 1.1 2013/09/03 19:04:10 creffett Exp $

EAPI=5

KDE_HANDBOOK="optional"
KDE_SELINUX_MODULE="gpg"
inherit kde4-base

DESCRIPTION="KDE gpg keyring manager"
HOMEPAGE="http://www.kde.org/applications/utilities/kgpg
http://utils.kde.org/projects/kgpg"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"

pkg_postinst() {
	kde4-base_pkg_postinst

	if ! has_version app-crypt/dirmngr ; then
		elog "For improved key search functionality, install app-crypt/dirmngr."
	fi
}
