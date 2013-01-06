# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdmthemegenerator/kdmthemegenerator-0.8.ebuild,v 1.3 2011/10/29 00:38:12 abcd Exp $

EAPI=4
inherit kde4-base

MY_P=KdmThemeGenerator

DESCRIPTION="A program that will generate kdm theme from your current plasma theme and wallpaper"
HOMEPAGE="http://kde-apps.org/content/show.php/Kdm+theme+generator?content=102760"
SRC_URI="http://kde-apps.org/CONTENT/content-files/102760-${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdm)
"

S=${WORKDIR}/${MY_P}

src_install() {
	kde4-base_src_install
	exeinto /usr/share/${MY_P}
	doexe copyFromUserToSystem.sh || die
	insinto /usr/share/${MY_P}
	doins input-shadow.svg || die
}
