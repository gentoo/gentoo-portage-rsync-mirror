# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akonadi/akonadi-4.4.11.1.ebuild,v 1.7 2012/12/08 12:04:13 dilfridge Exp $

EAPI=4

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="An extensible cross-desktop storage service for PIM data and meta data"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=app-office/akonadi-server-1.3.1
	$(add_kdebase_dep kdelibs 'semantic-desktop' 4.6)
	$(add_kdebase_dep kdepimlibs 'semantic-desktop' 4.6)
	$(add_kdebase_dep libkdepim)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-runtime)
"

KMEXTRA="
	akonadiconsole/
"

# @since 4.3 - blocks kdemaildir - no longer provided (it's in akonadi now)
add_blocker kdemaildir
add_blocker kdepim-kresources '<4.2.95'
# bug #428182
add_blocker akonadiconsole

src_configure() {
	mycmakeargs=(
		# Set the dbus dirs, otherwise it searches in KDEDIR
		-DAKONADI_DBUS_INTERFACES_INSTALL_DIR="${EPREFIX}/usr/share/dbus-1/interfaces"
		-DAKONADI_DBUS_SERVICES_INSTALL_DIR="${EPREFIX}/usr/share/dbus-1/services"
	)

	kde4-meta_src_configure
}
