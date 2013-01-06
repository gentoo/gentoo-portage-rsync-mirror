# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kcdemu/kcdemu-0.4.ebuild,v 1.3 2012/04/09 12:13:32 maekke Exp $

EAPI=4
KDE_LINGUAS="de es pl ro sv"
inherit kde4-base

MY_PN='kde_cdemu'

DESCRIPTION="A frontend to cdemu daemon for KDE4"
HOMEPAGE="http://www.kde-apps.org/content/show.php/KDE+CDEmu+Manager?content=99752"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/99752-${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND="app-cdr/cdemu"

S=${WORKDIR}/${MY_PN}

DOCS=( ChangeLog )
