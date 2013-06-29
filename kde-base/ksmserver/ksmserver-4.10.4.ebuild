# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksmserver/ksmserver-4.10.4.ebuild,v 1.2 2013/06/29 16:09:12 ago Exp $

EAPI=5

DECLARATIVE_REQUIRED="always"
KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="The reliable KDE session manager that talks the standard X11R6"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kcminit)
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep solid)
	media-libs/qimageblitz
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXrender
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kcminit/main.h
	libs/kdm/kgreeterplugin.h
	kcheckpass/
	libs/kephal/
	libs/kworkspace/
	solid/
"

KMLOADLIBS="libkworkspace"

PATCHES=( "${FILESDIR}/${PN}-4.10.1-noplasmalock.patch" )
